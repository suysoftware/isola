import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isola_app/src/model/app_settings/statistics_settings.dart';
import 'package:isola_app/src/page/control_panels/panel_general_view.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';

class PanelLLoginPage extends StatefulWidget {
  const PanelLLoginPage({Key? key, required this.statisticsData})
      : super(key: key);

  final StatisticsSettings statisticsData;
  @override
  State<PanelLLoginPage> createState() => _PanelLLoginPageState();
}

class _PanelLLoginPageState extends State<PanelLLoginPage> {
  TextEditingController t1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 50.w,
            height: 10.h,
            child: Center(
              child: CupertinoTextField(
                maxLength: 6,
                style: GoogleFonts.staatliches(
                    fontSize: 20.sp, letterSpacing: 4.0),
                onChanged: (t) {
                  setState(() {});
                },
                decoration: const BoxDecoration(
                  color: ColorConstant.milkColor,
                ),
                textAlign: TextAlign.center,
                controller: t1,
                placeholder: '_ _ _ _ _ _',
                placeholderStyle: const TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstant.themeGrey,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                    height: 5.h,
                    width: 30.w,
                    child: Center(
                      child: Text(
                        'Back',
                        style: GoogleFonts.aBeeZee(
                            color: ColorConstant.softBlack, fontSize: 15.sp),
                      ),
                    )),
                onPressed: () {
                  Navigator.pop(context);
                }),
            CupertinoButton(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstant.themeGrey,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                    height: 5.h,
                    width: 30.w,
                    child: Center(
                      child: Text(
                        'Login',
                        style: GoogleFonts.aBeeZee(
                            color: ColorConstant.softBlack, fontSize: 15.sp),
                      ),
                    )),
                onPressed: () {
                  if (t1.text == widget.statisticsData.statisticsPassword) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PanelGeneralView()));
                  } else {
                    Navigator.pop(context);
                            Navigator.pop(context);
                  }
                })
          ],
        )
      ],
    );
  }
}
