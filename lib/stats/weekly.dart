import 'package:flutter/material.dart';

class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Weekly bar chart'),
      ),
    );
  }
}
