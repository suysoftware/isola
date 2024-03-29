import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';

// ignore: must_be_immutable
class LicencesDialog extends StatelessWidget {
  LicencesDialog(
      {Key? key,
      this.radius = 8,
      required this.mdFileName,
      required this.packageName})
      : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension'),
        super(key: key);

  final double radius;
  final String mdFileName;
  final String packageName;

  bool canSkip = false;

  // ignore: non_constant_identifier_names
  var IconData = CupertinoIcons.checkmark_circle;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeGrey,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text(
          packageName,
        ),
      ),
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
          return rootBundle.loadString('asset/document/licences/$mdFileName');
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Markdown(
                    styleSheet: MarkdownStyleSheet(
                      pPadding: const EdgeInsets.all(8.0),
                      p: TextStyle(
                          color: ColorConstant.softBlack,
                          fontFamily: "CoderStyle",
                          fontSize: 10.sp),
                    ),
                    padding: EdgeInsets.fromLTRB(1.w, 7.h, 1.w, 5.h),
                    data: snapshot.data.toString(),
                  ),
                ),
                const SizedBox(height: 1)
              ],
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class TermsAndPrivacyDialog extends StatelessWidget {
  TermsAndPrivacyDialog(
      {Key? key,
      this.radius = 8,
      required this.mdFileName,
      required this.packageName})
      : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension'),
        super(key: key);

  final double radius;
  final String mdFileName;
  final String packageName;

  bool canSkip = false;

  // ignore: non_constant_identifier_names
  var IconData = CupertinoIcons.checkmark_circle;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeGrey,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text(
          packageName,
        ),
      ),
      child: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
          return rootBundle.loadString('asset/document/$mdFileName');
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Markdown(
                    styleSheet: MarkdownStyleSheet(
                      pPadding: const EdgeInsets.all(8.0),
                      p: TextStyle(
                          color: ColorConstant.softBlack,
                          fontFamily: "CoderStyle",
                          fontSize: 10.sp),
                    ),
                    padding: EdgeInsets.fromLTRB(1.w, 7.h, 1.w, 5.h),
                    data: snapshot.data.toString(),
                  ),
                ),
                const SizedBox(height: 1)
              ],
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
