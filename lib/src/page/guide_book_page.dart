import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isola_app/src/constants/guidebook_constants.dart';
import 'package:sizer/sizer.dart';

import '../extensions/locale_keys.dart';

class GuideBookPage extends StatelessWidget {
  const GuideBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: true,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 13.h,
              ),
              Text('ISOLA',
                  style: GoogleFonts.orbitron(
                      fontSize: 24.sp, fontWeight: FontWeight.w400)),
              Center(
                child: SizedBox(
                    width: 60.w,
                    height: 40.h,
                    child: Image.asset('asset/img/guidebook/guidebook1.png')),
              ),
              SizedBox(
                width: 80.w,
                child: const AutoSizeText.rich(


                    TextSpan(text: GuideBookConstants.guideIsolaText)
                    
                    ,textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('Match',
                  style: GoogleFonts.orbitron(
                      fontSize: 24.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.5.h,
              ),
              Center(
                child: SizedBox(
                    width: 60.w,
                    height: 40.h,
                    child: Image.asset('asset/img/guidebook/guidebook2.png')),
              ),
              SizedBox(
                width: 80.w,
                child: const AutoSizeText.rich(
                    TextSpan(text: GuideBookConstants.guideMatchText)  ,textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(LocaleKeys.main_timeline.tr(),
                  style: GoogleFonts.orbitron(
                      fontSize: 24.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.5.h,
              ),
              Center(
                child: SizedBox(
                    width: 60.w,
                    height: 40.h,
                    child: Image.asset('asset/img/guidebook/guidebook3.png')),
              ),
              SizedBox(
                width: 80.w,
                child: const AutoSizeText.rich(
                    TextSpan(text: GuideBookConstants.guideTimelineText)  ,textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(LocaleKeys.main_explore.tr(),
                  style: GoogleFonts.orbitron(
                      fontSize: 24.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.5.h,
              ),
              Center(
                child: SizedBox(
                    width: 60.w,
                    height: 40.h,
                    child: Image.asset('asset/img/guidebook/guidebook4.png')),
              ),
              SizedBox(
                width: 80.w,
                child: const AutoSizeText.rich(
                    TextSpan(text: GuideBookConstants.guideExploreText)  ,textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('Chat',
                  style: GoogleFonts.orbitron(
                      fontSize: 24.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.5.h,
              ),
              Center(
                child: SizedBox(
                    width: 60.w,
                    height: 40.h,
                    child: Image.asset('asset/img/guidebook/guidebook5.png')),
              ),
              SizedBox(
                width: 80.w,
                child: const AutoSizeText.rich(
                    TextSpan(text: GuideBookConstants.guideChatText)  ,textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  width: 60.w, child: Image.asset('asset/img/isola_logo.png')),
              SizedBox(
                height: 5.h,
              ),
              const Text('_______________'),
              SizedBox(
                height: 7.h,
              ),
              SizedBox(
                  width: 30.w,
                  child: Image.asset('asset/img/dynamic_gentis_logo_head.png')),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                  width: 70.w,
                  child: Image.asset(
                      'asset/img/dynamic_gentis_text_logo_dark.png')),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ));
  }
}
