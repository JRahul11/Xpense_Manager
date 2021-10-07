import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:core';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _budget = 50000;
  late DocumentSnapshot documentSnapshot;
  var today = new DateTime.now();
  var ringdate = new DateTime.now();

  getColor(String iconcolor) {
    switch (iconcolor) {
      case 'Education':
        return Color(0xff0293ee);
      case 'Rent':
        return Color(0xfff8b250);
      case 'Entertainment':
        return Color(0xff845bef);
      case 'Taxes':
        return Color(0xff13d38e);
      case 'Vehicle':
        return Color(0xFF800C32);
      case 'Stationary':
        return Color(0xffd500f9);
      case 'Meal':
        return Color(0xff00695c);
    }
    return Color(0xff546e7a);
  }

  IconData getIcon(String iconstring) {
    switch (iconstring) {
      case 'Education':
        return Icons.book_outlined;
      case 'Rent':
        return CupertinoIcons.house;
      case 'Entertainment':
        return Icons.movie_creation_outlined;
      case 'Taxes':
        return CupertinoIcons.money_dollar_circle;
      case 'Vehicle':
        return CupertinoIcons.car_detailed;
      case 'Stationary':
        return CupertinoIcons.pencil_outline;
      case 'Meal':
        return Icons.fastfood_outlined;
    }
    return Icons.fact_check_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    today = new DateTime(today.year, today.month, today.day);
    ringdate = new DateTime(ringdate.year, ringdate.month);
    var _newtoday = today;

    Future<int> getBudget(userKey) async {
      var check = await FirebaseFirestore.instance
          .collection(userKey!.email!)
          .doc('limit')
          .get();
      if (check.exists) {
        FirebaseFirestore.instance
            .collection(userKey!.email!)
            .doc('limit')
            .get()
            .then((value) {
          documentSnapshot = value;
          setState(() {
            _budget = documentSnapshot['limit'];
          });
        });
        return documentSnapshot['limit'];
      }
      return 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: "Dashboard"
            .text
            .xl2
            .fontFamily('Helvetica')
            .color(Colors.white)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(userKey!.email!)
            .where("date", isGreaterThanOrEqualTo: ringdate)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator().centered().expand());
          }

          getBudget(userKey).then((value) {
            if (value == 0) {
              _budget = 50000;
            } else {
              _budget = value;
            }
          });

          var _i = 0;
          var _total = 0;
          snapshot.data!.docs.forEach((user) {
            _i = user['spent'];
            _total = _total + _i;
          });

          var _percent = (_total / _budget);
          var _percenttext = _percent * 100;
          _percent = double.parse(_percent.toStringAsFixed(2));
          _percenttext = double.parse(_percenttext.toStringAsFixed(2));
          var _balance = _budget - _total;
          var balchecker = 0;
          if (_balance < 0) {
            balchecker = 1;
            _balance = -1 * _balance;
          }

          return Container(
            color: Colors.indigo,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 35,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 155,
                          center: Text(
                            _percenttext.toString() + "%",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          progressColor: _percenttext > 75
                              ? Colors.red
                              : Colors.green[400],
                          backgroundColor: Colors.black,
                          percent: _percenttext > 100.0 ? 0 : _percent,
                          lineWidth: 16,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  top: 40,
                                ),
                                child: balchecker == 0
                                    ? Text(
                                        "Balance",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Helvetica',
                                        ),
                                      )
                                    : Text(
                                        "OverBudget",
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.red,
                                          fontFamily: 'Helvetica',
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: balchecker == 0
                                    ? Text(
                                        "\u{20B9}" + _balance.toString(),
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "By" +
                                            " \u{20B9}" +
                                            _balance.toString(),
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    // fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              "Recent Transactions",
                              style: TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              DateFormat.yMMMEd().format(_newtoday),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(userKey.email!)
                                  .orderBy('date', descending: true)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator()
                                          .centered()
                                          .expand());
                                }
                                return ListView(
                                  children: snapshot.data!.docs.map((user) {
                                    return Center(
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: getColor(user['category']),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            getIcon(user['category']),
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          user['name'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd MMMM, yyyy')
                                              .format(
                                                  (user['date'] as Timestamp)
                                                      .toDate())
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: Text(
                                          '\u{20B9}${user['spent'].toString()}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onLongPress: () {
                                          user.reference.delete();
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
