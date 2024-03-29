import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    Key? key,
    this.radius = 8,
    required this.mdFileName,
  })  : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension'),
        super(key: key);

  final double radius;
  final String mdFileName;
  bool canSkip = false;

  // ignore: non_constant_identifier_names
  var IconData = CupertinoIcons.checkmark_circle;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ColorConstant.themeGrey,
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
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CupertinoButton(
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: ColorConstant.softBlack,
                        size: 25.sp,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: 5.w,
                  )
                ]),
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
