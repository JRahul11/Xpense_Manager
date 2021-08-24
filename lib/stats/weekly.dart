import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';


class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo.withOpacity(0.65),title: Text("Weekly Analysis"),),
      body: Column(
        children: <Widget>
          [
            AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              color: const Color(0xffffffff),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipMargin: 8,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.y.round().toString(),
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                      margin: 20,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Mn';
                          case 1:
                            return 'Tu';
                          case 2:
                            return 'Wd';
                          case 3:
                            return 'Thu';
                          case 4:
                            return 'Fr';
                          case 5:
                            return 'St';
                          case 6:
                            return 'Sn';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(showTitles: false),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
