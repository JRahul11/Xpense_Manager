import 'package:flutter/material.dart';

class Monthly extends StatefulWidget {
  const Monthly({Key? key}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Monthly Line Chart'),
      ),
    );
  }
}
