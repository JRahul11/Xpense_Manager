import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  static var d = DateTime.now();
  static var weekDay = d.weekday;
  var firstDayOfWeek = d.subtract(Duration(days: weekDay));

  List<double> weeklyData = [0, 0, 0, 0, 0, 0, 0];
  var weekspent = [0, 0, 0, 0, 0, 0, 0];
  int touchedIndex = 0;

  Future<List> getWeeklyData(snapshot) async {
    for (int i = 0; i < 7; i++) {
      weeklyData[i] = 0;
    }
    snapshot.data!.docs.forEach((user) {
      int i = 0;
      if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 1)))) {
        i = user['spent'];
        weekspent[0] = weekspent[0] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 2)))) {
        i = user['spent'];
        weekspent[1] = weekspent[1] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 3)))) {
        i = user['spent'];
        weekspent[2] = weekspent[2] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 4)))) {
        i = user['spent'];
        weekspent[3] = weekspent[3] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 5)))) {
        i = user['spent'];
        weekspent[4] = weekspent[4] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 6)))) {
        i = user['spent'];
        weekspent[5] = weekspent[5] + i;
      } else if (DateFormat("dd-MM-yyyy").format(user['date'].toDate()) ==
          DateFormat("dd-MM-yyyy")
              .format(d.subtract(Duration(days: weekDay - 7)))) {
        i = user['spent'];
        weekspent[6] = weekspent[6] + i;
      }
    });
    for (int i = 0; i < 7; i++) {
      weeklyData[i] = weekspent[i].toDouble();
    }
    weekspent = [0, 0, 0, 0, 0, 0, 0, 0];
    return weekspent;
  }

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFFFFFFF),
      ),
      margin: EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Weekly Analytics',
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: const Color(0xFF123E9C),
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 25,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(userKey!.email!)
                      .where("date", isGreaterThan: firstDayOfWeek)
                      .snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child:
                              CircularProgressIndicator().centered().expand());
                    }
                    getWeeklyData(snapshot).then((weekspent) {
                      setState(() {});
                    });
                    return BarChart(
                      mainBarData(),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBar(
    int x,
    double y, {
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [Colors.indigo, Colors.greenAccent],
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      weeklyData.length,
      (index) =>
          _buildBar(index, weeklyData[index], isTouched: index == touchedIndex),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: _buildBarTouchData(),
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      // Build X axis.
      bottomTitles: SideTitles(
        showTitles: true,
        // textStyle: TextStyle(
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        //   fontSize: 14,
        // ),
        margin: 22,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'M';
            case 1:
              return 'T';
            case 2:
              return 'W';
            case 3:
              return 'T';
            case 4:
              return 'F';
            case 5:
              return 'S';
            case 6:
              return 'S';
            default:
              return '';
          }
        },
      ),
      // Build Y axis.
      leftTitles: SideTitles(
        showTitles: false,
        getTitles: (double value) {
          return value.toString();
        },
      ),
    );
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.indigo[300],
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          String weekDay = "";
          switch (group.x.toInt()) {
            case 0:
              weekDay = 'Monday';
              break;
            case 1:
              weekDay = 'Tuesday';
              break;
            case 2:
              weekDay = 'Wednesday';
              break;
            case 3:
              weekDay = 'Thursday';
              break;
            case 4:
              weekDay = 'Friday';
              break;
            case 5:
              weekDay = 'Saturday';
              break;
            case 6:
              weekDay = 'Sunday';
              break;
          }
          return BarTooltipItem(
            weekDay + '\n' + "\u{20B9} " + (rod.y).toString(),
            TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
