import 'package:flutter/material.dart';

class Categorywise extends StatefulWidget {
  const Categorywise({Key? key}) : super(key: key);

  @override
  _CategorywiseState createState() => _CategorywiseState();
}

class _CategorywiseState extends State<Categorywise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Categorywise Pie Chart'),
      ),
    );
  }
}
