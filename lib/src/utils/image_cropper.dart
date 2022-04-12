// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:http_client_helper/http_client_helper.dart';
import 'package:image/image.dart';
import 'package:image_editor/image_editor.dart';
import 'dart:async';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageSaver {
  ImageSaver._();
  static Future<String?> save(String name, Uint8List fileData) async {
    final AssetEntity? imageEntity = await PhotoManager.editor.saveImage(
      fileData,
      title: '',
    );

    final File? file = await imageEntity?.file;
    return file?.path;
  }
}

Future<Uint8List?> cropImageDataWithDartLibrary(
    // ignore: duplicate_ignore
    {required ExtendedImageEditorState state}) async {
  print('dart library start cropping');

  ///crop rect base on raw image
  final Rect? cropRect = state.getCropRect();

  final Uint8List data = kIsWeb &&
          state.widget.extendedImageState.imageWidget.image
              is ExtendedNetworkImageProvider
      ? await _loadNetwork(state.widget.extendedImageState.imageWidget.image
          as ExtendedNetworkImageProvider)
      : state.rawImageData;

  final EditActionDetails editAction = state.editAction!;


  Animation? src;
  //LoadBalancer lb;
  if (kIsWeb) {
    src = decodeAnimation(data);
  } else {
    src = await compute(decodeAnimation, data);
  }
  if (src != null) {
    //handle every frame.
    src.frames = src.frames.map((Image image) {
      //clear orientation
      image = bakeOrientation(image);

      if (editAction.needCrop) {
        image = copyCrop(image, cropRect!.left.toInt(), cropRect.top.toInt(),
            cropRect.width.toInt(), cropRect.height.toInt());
      }

      if (editAction.needFlip) {
        late Flip mode;
        if (editAction.flipY && editAction.flipX) {
          mode = Flip.both;
        } else if (editAction.flipY) {
          mode = Flip.horizontal;
        } else if (editAction.flipX) {
          mode = Flip.vertical;
        }
        image = flip(image, mode);
      }

      if (editAction.hasRotateAngle) {
        image = copyRotate(image, editAction.rotateAngle);
      }

      return image;
    }).toList();
  }

  List<int>? fileData;

  if (src != null) {
    final bool onlyOneFrame = src.numFrames == 1;

    if (kIsWeb) {
      fileData = onlyOneFrame ? encodeJpg(src.first) : encodeGifAnimation(src);
    } else {
      fileData = onlyOneFrame
          ? await compute(encodeJpg, src.first)
          : await compute(encodeGifAnimation, src);
    }
  }

  return Uint8List.fromList(fileData!);
}

Future<Uint8List?> cropImageDataWithNativeLibrary(
    {required ExtendedImageEditorState state}) async {
  final Rect? cropRect = state.getCropRect();
  final EditActionDetails action = state.editAction!;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final ImageEditorOption option = ImageEditorOption();

  if (action.needCrop) {
    option.addOption(ClipOption.fromRect(cropRect!));
  }

  if (action.needFlip) {
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }

  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }

  final Uint8List? result = await ImageEditor.editImage(
    image: img,
    imageEditorOption: option,
  );

  return result;
}

Future<dynamic> isolateDecodeImage(List<int> data) async {
  final ReceivePort response = ReceivePort();
  await Isolate.spawn(_isolateDecodeImage, response.sendPort);
  final dynamic sendPort = await response.first;
  final ReceivePort answer = ReceivePort();
  // ignore: always_specify_types
  sendPort.send([answer.sendPort, data]);
  return answer.first;
}

Future<dynamic> isolateEncodeImage(Image src) async {
  final ReceivePort response = ReceivePort();
  await Isolate.spawn(_isolateEncodeImage, response.sendPort);
  final dynamic sendPort = await response.first;
  final ReceivePort answer = ReceivePort();
  // ignore: always_specify_types
  sendPort.send([answer.sendPort, src]);
  return answer.first;
}

void _isolateDecodeImage(SendPort port) {
  final ReceivePort rPort = ReceivePort();
  port.send(rPort.sendPort);
  rPort.listen((dynamic message) {
    final SendPort send = message[0] as SendPort;
    final List<int> data = message[1] as List<int>;
    send.send(decodeImage(data));
  });
}

void _isolateEncodeImage(SendPort port) {
  final ReceivePort rPort = ReceivePort();
  port.send(rPort.sendPort);
  rPort.listen((dynamic message) {
    final SendPort send = message[0] as SendPort;
    final Image src = message[1] as Image;
    send.send(encodeJpg(src));
  });
}

Future<Uint8List> _loadNetwork(ExtendedNetworkImageProvider key) async {
  try {
    final Response? response = await HttpClientHelper.get(Uri.parse(key.url),
        headers: key.headers,
        timeLimit: key.timeLimit,
        timeRetry: key.timeRetry,
        retries: key.retries,
        cancelToken: key.cancelToken);
    return response!.bodyBytes;
  } on OperationCanceledError catch (_) {
    print('User cancel request ${key.url}.');
    return Future<Uint8List>.error(
        StateError('User cancel request ${key.url}.'));
  } catch (e) {
    return Future<Uint8List>.error(StateError('failed load ${key.url}. \n $e'));
  }
}
