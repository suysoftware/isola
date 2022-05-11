import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/app_settings/statistics_model.dart';
import 'package:isola_app/src/page/control_panels/barchart/bar_chart1.dart';
import 'package:isola_app/src/page/control_panels/piecharts/pie_chart_sample1.dart';
import 'package:isola_app/src/page/control_panels/piecharts/pie_chart_sample2.dart';
import 'package:isola_app/src/page/control_panels/piecharts/pie_chart_sample3.dart';
import 'package:isola_app/src/service/firebase/storage/getters/panel_getter.dart';
import 'package:sizer/sizer.dart';

class PanelGeneralView extends StatefulWidget {
  const PanelGeneralView({Key? key}) : super(key: key);

  @override
  State<PanelGeneralView> createState() => _PanelGeneralViewState();
}

class _PanelGeneralViewState extends State<PanelGeneralView>
    with TickerProviderStateMixin {
  int totalUserValue = 0;
  ScrollController sc1 = ScrollController();
  var statisticsModel = StatisticsModel(
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      [""],
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0);

  TextStyle topStyle = TextStyle(
      color: Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle subStyle = TextStyle(
      color: Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold);

  TextStyle subStyleMale = TextStyle(
      color: Color.fromARGB(255, 18, 76, 97),
      fontSize: 22,
      fontWeight: FontWeight.bold);

  TextStyle subStyleFemale = TextStyle(
      color: Color.fromARGB(255, 120, 48, 110),
      fontSize: 22,
      fontWeight: FontWeight.bold);
  TextStyle subStyleOther = TextStyle(
      color: Color.fromARGB(255, 116, 87, 8),
      fontSize: 22,
      fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: ColorConstant.themeColor,
        ),
        child: FutureBuilder(
          future: panelCurrentStatisticsGetter(),
          builder:
              (BuildContext context, AsyncSnapshot<StatisticsModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                // return const CupertinoActivityIndicator();
                return CupertinoActivityIndicator();

              default:
                if (snapshot.hasError) {
                  return const Text("Error");
                } else {
                  statisticsModel = snapshot.data as StatisticsModel;

                  return SingleChildScrollView(
                    controller: sc1,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        //FIRST BAR
                        BarChart1(
                          chaosOnline: statisticsModel.chaos_online.toDouble(),
                          chaosSearching:
                              statisticsModel.chaos_searching.toDouble(),
                          groupWaiting:
                              statisticsModel.group_waiting.toDouble(),
                          universityUsed:
                              statisticsModel.university_used.toDouble(),
                          userOnline: statisticsModel.users_online.toDouble(),
                          userSearching:
                              statisticsModel.users_searching.toDouble(),
                          userTotal: statisticsModel.users_total.toDouble(),
                        ),

                        SizedBox(
                          height: 2.h,
                        ),
                        //PIE 1
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: const Color(0xff81e5cd),
                          child: Column(
                            children: [
                              Text('User Gender', style: topStyle),
                              SizedBox(
                                height: 20,
                              ),
                              _tripleCard(
                                  "Male",
                                  "Female",
                                  "Other",
                                  statisticsModel.users_male,
                                  statisticsModel.users_female,
                                  statisticsModel.users_other,
                                  Color.fromARGB(255, 49, 184, 234),
                                  Color.fromARGB(255, 248, 101, 228),
                                  Color.fromARGB(255, 247, 187, 19),
                                  subStyleMale,
                                  subStyleFemale,
                                  subStyleOther,
                                  statisticsModel.users_total),
                              PieChart3(
                                  piePercent1:
                                      ((100 / statisticsModel.users_total) *
                                              statisticsModel.users_male)
                                          .ceilToDouble(),
                                  piePercent2:
                                      ((100 / statisticsModel.users_total) *
                                              statisticsModel.users_female)
                                          .ceilToDouble(),
                                  piePercent3:
                                      ((100 / statisticsModel.users_total) *
                                              statisticsModel.users_other)
                                          .ceilToDouble(),
                                  pieColor1: Color.fromARGB(255, 49, 184, 234),
                                  pieColor2: Color.fromARGB(255, 248, 101, 228),
                                  pieColor3: Color.fromARGB(255, 255, 188, 63)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        //PIE 2
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: const Color(0xff81e5cd),
                          child: Column(
                            children: [
                              Text(
                                'Group Online Gender',
                                style: topStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _tripleCard(
                                  "Male",
                                  "Female",
                                  "Other",
                                  statisticsModel.group_male_active,
                                  statisticsModel.group_female_active,
                                  statisticsModel.group_other_active,
                                  Color.fromARGB(255, 49, 184, 234),
                                  Color.fromARGB(255, 248, 101, 228),
                                  Color.fromARGB(255, 247, 187, 19),
                                  subStyleMale,
                                  subStyleFemale,
                                  subStyleOther,
                                  statisticsModel.group_active),
                              PieChart3(
                                  piePercent1:
                                      ((100 / statisticsModel.group_active) *
                                              statisticsModel.group_male_active)
                                          .ceilToDouble(),
                                  piePercent2: ((100 /
                                              statisticsModel.group_active) *
                                          statisticsModel.group_female_active)
                                      .ceilToDouble(),
                                  piePercent3: ((100 /
                                              statisticsModel.group_active) *
                                          statisticsModel.group_other_active)
                                      .ceilToDouble(),
                                  pieColor1: Color.fromARGB(255, 49, 184, 234),
                                  pieColor2: Color.fromARGB(255, 248, 101, 228),
                                  pieColor3: Color.fromARGB(255, 255, 188, 63)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),

                        //PIE 3
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: const Color(0xff81e5cd),
                          child: Column(
                            children: [
                              Text(
                                'Group Gender',
                                style: topStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _tripleCard(
                                  "Male",
                                  "Female",
                                  "Other",
                                  statisticsModel.group_male,
                                  statisticsModel.group_female,
                                  statisticsModel.group_other,
                                  Color.fromARGB(255, 49, 184, 234),
                                  Color.fromARGB(255, 248, 101, 228),
                                  Color.fromARGB(255, 247, 187, 19),
                                  subStyleMale,
                                  subStyleFemale,
                                  subStyleOther,
                                  statisticsModel.group_total),
                              PieChart3(
                                  piePercent1:
                                      ((100 / statisticsModel.group_total) *
                                              statisticsModel.group_male)
                                          .ceilToDouble(),
                                  piePercent2:
                                      ((100 / statisticsModel.group_total) *
                                              statisticsModel.group_female)
                                          .ceilToDouble(),
                                  piePercent3:
                                      ((100 / statisticsModel.group_total) *
                                              statisticsModel.group_other)
                                          .ceilToDouble(),
                                  pieColor1: Color.fromARGB(255, 49, 184, 234),
                                  pieColor2: Color.fromARGB(255, 248, 101, 228),
                                  pieColor3: Color.fromARGB(255, 255, 188, 63)),
                            ],
                          ),
                        ),

                        /*
                //TOTAL**
                Text('Users : ${statisticsModel.users_total}'), 
        
                //SEX**   //pie chart
                Text('User Male: ${statisticsModel.users_male}'),
                Text('User Female: ${statisticsModel.users_female}'),
                Text('User Other: ${statisticsModel.users_other}'),
        
                //ONLİNE**
                Text('User Online: ${statisticsModel.users_online}'),
        
                //VALİDATİON
                Text('User Valid:${statisticsModel.users_valid}'),
                Text('User Unvalid:${statisticsModel.users_unvalid}'),
        
                //SEARCHİNG**
                Text('User Searching:${statisticsModel.users_searching}'),
        
                //TOTAL ONLİNE**
                Text('Group Total Active:${statisticsModel.group_active}'),
        
                //GROUPS ONLİNE SEX**    //pie chart
                Text('Group Other Active:${statisticsModel.group_other_active}'),
                Text('Group Male Active:${statisticsModel.group_male_active}'),
                Text(
                    'Group Female Active:${statisticsModel.group_female_active}'),
        
                //TOTAL GROUP**
                Text('Group Total :${statisticsModel.group_total}'),
        
                //GROUP SEX**    //pie chart
                Text('Group Other:${statisticsModel.group_other}'),
                Text('Group Male:${statisticsModel.group_male}'),
                Text('Group Female:${statisticsModel.group_female}'),
        
                //GROUP WAİTİNG**
                Text('Group Waiting:${statisticsModel.group_waiting}'),
        
                //CHAOS TOTAL
                Text('Chaos Total:${statisticsModel.chaos_total}'),
        
                //CHAOS ONLİNE**
                Text('Chaos Online:${statisticsModel.chaos_online}'),
        
                //CHAOS SEARCHİNG**
                Text('Chaos Searching:${statisticsModel.chaos_searching}'),
        
                //UNİVERSİTY TOTAL
                Text('University Total:${statisticsModel.university_total}'),
        
                //UNİVERSİTY TOP5
                Text('University TOP5:${statisticsModel.university_top5}'),
        
                //UNİVERSİTY USED**
                Text('University Used:${statisticsModel.university_used}'),
        */
                       /* CupertinoButton(
                            child: Text('reload'),
                            onPressed: () {
                              var reloadRef = FirebaseFirestore.instance
                                  .collection('panel_statistics')
                                  .doc('isola_stats')
                                  .collection('reload_stats')
                                  .doc();

                              reloadRef.set({'halo': 'mrb'});
                              setState(() {});
                            }),*/
                      ],
                    ),
                  );
                }
            }
          },
        ));
  }

  Widget _tripleCard(
      String text1,
      String text2,
      String text3,
      int value1,
      int value2,
      int value3,
      Color color1,
      Color color2,
      Color color3,
      TextStyle tStyle1,
      TextStyle tStyle2,
      TextStyle tStyle3,
      int varTotal) {
    return Row(
      children: [
        SizedBox(
            width: 100,
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: color1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text1,
                      style: tStyle1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$value1/$varTotal',
                      style: tStyle1,
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(
          width: 50,
        ),
        SizedBox(
            width: 100,
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: color2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text2,
                      style: tStyle2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$value2/$varTotal',
                      style: tStyle2,
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(
          width: 50,
        ),
        SizedBox(
            width: 100,
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: color3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text3,
                      style: tStyle3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$value3/$varTotal',
                      style: tStyle3,
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
