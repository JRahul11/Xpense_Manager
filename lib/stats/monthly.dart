import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class Monthly extends StatefulWidget {
  Monthly({Key? key}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  var spent = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var spentmonth = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  Future<List> getMonthlyData(snapshot) async {
    spentmonth = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    snapshot.data!.docs.forEach((user) {
      int i = 0;
      if (user['date'].toDate().month == 1) {
        i = user['spent'];
        spent[0] = spent[0] + i;
      } else if (user['date'].toDate().month == 2) {
        i = user['spent'];
        spent[1] = spent[1] + i;
      } else if (user['date'].toDate().month == 3) {
        i = user['spent'];
        spent[2] = spent[2] + i;
      } else if (user['date'].toDate().month == 4) {
        i = user['spent'];
        spent[3] = spent[3] + i;
      } else if (user['date'].toDate().month == 5) {
        i = user['spent'];
        spent[4] = spent[4] + i;
      } else if (user['date'].toDate().month == 6) {
        i = user['spent'];
        spent[5] = spent[5] + i;
      } else if (user['date'].toDate().month == 7) {
        i = user['spent'];
        spent[6] = spent[6] + i;
      } else if (user['date'].toDate().month == 8) {
        i = user['spent'];
        spent[7] = spent[7] + i;
      } else if (user['date'].toDate().month == 9) {
        i = user['spent'];
        spent[8] = spent[8] + i;
      } else if (user['date'].toDate().month == 10) {
        i = user['spent'];
        spent[9] = spent[9] + i;
      } else if (user['date'].toDate().month == 11) {
        i = user['spent'];
        spent[10] = spent[10] + i;
      } else if (user['date'].toDate().month == 12) {
        i = user['spent'];
        spent[11] = spent[11] + i;
      }
    });
    for (int i = 0; i < 12; i++) {
      spentmonth[i] = spent[i] / 1000;
    }

    spent = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    return spentmonth;
  }

  makeList(spentmonth) {
    List<_ExpenseData> data = [
      _ExpenseData('Jan', spentmonth[0]),
      _ExpenseData('Feb', spentmonth[1]),
      _ExpenseData('Mar', spentmonth[2]),
      _ExpenseData('Apr', spentmonth[3]),
      _ExpenseData('May', spentmonth[4]),
      _ExpenseData('June', spentmonth[5]),
      _ExpenseData('July', spentmonth[6]),
      _ExpenseData('Aug', spentmonth[7]),
      _ExpenseData('Sep', spentmonth[8]),
      _ExpenseData('Oct', spentmonth[9]),
      _ExpenseData('Nov', spentmonth[10]),
      _ExpenseData('Dec', spentmonth[11]),
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return Container(
        child: Column(children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25),
          child: Text(
            'Monthly Analytics',
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: const Color(0xFF123E9C),
              fontSize: 24,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 60,
      ),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(userKey!.email!)
              .where('date',
                  isGreaterThanOrEqualTo: DateTime(DateTime.now().year))
              .snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator().centered().expand());
            }
            getMonthlyData(snapshot).then((spentmonth) {
              spentmonth = this.spentmonth;
              setState(() {});
            });
            return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_ExpenseData, String>>[
                  LineSeries<_ExpenseData, String>(
                      dataSource: makeList(spentmonth),
                      xValueMapper: (_ExpenseData sales, _) => sales.year,
                      yValueMapper: (_ExpenseData sales, _) => sales.expense,
                      name: 'EXPENSE (in ₹ K)',
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]);
          })
    ]));
  }
}

class _ExpenseData {
  _ExpenseData(this.year, this.expense);

  final String year;
  final double expense;
}
