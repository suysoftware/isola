import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/page/control_panels/piecharts/pie_indicator.dart';

class PieChart3 extends StatefulWidget {
  const PieChart3(
      {Key? key,
      required this.piePercent1,
      required this.piePercent2,
      required this.piePercent3,
    required this.pieColor1,required this.pieColor2,required this.pieColor3})
      : super(key: key);

  final double piePercent1;
  final double piePercent2;
  final double piePercent3;

  final Color pieColor1;
  final Color pieColor2;
  final Color pieColor3;

  @override
  State<PieChart3> createState() => _PieChart3State();
}

class _PieChart3State extends State<PieChart3> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
      color: const Color(0xff81e5cd),
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections()),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: widget.pieColor1,
            value: widget.piePercent1,
            title: '${widget.piePercent1}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            
            /* badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),*/
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: widget.pieColor2,
            value: widget.piePercent2,
            title: '${widget.piePercent2}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
           
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: widget.pieColor3,
            value: widget.piePercent3,
            title: '${widget.piePercent3}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
           
            badgePositionPercentageOffset: .98,
          );
        /* case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );*/
        default:
          throw 'Oh no';
      }
    });
  }
}
