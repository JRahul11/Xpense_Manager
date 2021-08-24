import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/gestures.dart';

void main() {
  return runApp(Monthly());
}

class Monthly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo,visualDensity: VisualDensity.adaptivePlatformDensity,),
      debugShowCheckedModeBanner: false,
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_ExpenseData> data = [
    _ExpenseData('Jan', 35),
    _ExpenseData('Feb', 28),
    _ExpenseData('Mar', 34),
    _ExpenseData('Apr', 32),
    _ExpenseData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo.withOpacity(0.65),
          toolbarHeight: 35,
          title: Text('Monthly Analysis'),
        ),
        body: Column(children: [
          
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_ExpenseData, String>>[
                LineSeries<_ExpenseData, String>(
                    dataSource: data,
                    xValueMapper: (_ExpenseData sales, _) => sales.year,
                    yValueMapper: (_ExpenseData sales, _) => sales.Expense,
                    name: 'EXPENSE',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
         
        ]));
  }
}

class _ExpenseData {
  _ExpenseData(this.year, this.Expense);

  final String year;
  final double Expense;
}
