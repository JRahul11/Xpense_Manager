import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class Categorywise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo.withOpacity(0.65),title: Text("Categorywise Analysis",),),
      body: Column(
        children: <Widget>
       [ 
         AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                pieTouchResponse.touchInput is! PointerUpEvent;
                            if (desiredTouch && pieTouchResponse.touchedSection != null) {
                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            } else {
                              touchedIndex = -1;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'First',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Second',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff845bef),
                    text: 'Third',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff13d38e),
                    text: 'Fourth',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xffec407a),
                    text: 'Fifth',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xffd500f9),
                    text: 'Sixth',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff00695c),
                    text: 'Seventh',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff546e7a),
                    text: 'Eighth',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff6d4c41),
                    text: 'ninth',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
     ],
      )
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(9, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 4:
          return PieChartSectionData(
            color: const Color(0xffec407a),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 5:
          return PieChartSectionData(
            color: const Color(0xffd500f9),
            value: 7,
            title: '7%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 6:
          return PieChartSectionData(
            color: const Color(0xff00695c),
            value: 9,
            title: '9%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 7:
          return PieChartSectionData(
            color: const Color(0xff546e7a),
            value: 4,
            title: '4%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
          case 8:
          return PieChartSectionData(
            color: const Color(0xff6d4c41),
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
