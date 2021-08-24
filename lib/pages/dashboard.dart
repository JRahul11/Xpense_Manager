import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
int _date = 23;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Container(
        color: Colors.black87,
        child: SafeArea(
          child: Column(
            
            children: [
              Container(
                //color: Colors.black,
                height: 180,
                // width: 250,
                padding: EdgeInsets.only(
                  top: 10,
                  left: 50,
                  right: 20,
                ),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 155,
                      center: Text(
                        "30%",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      progressColor: Colors.red,
                      backgroundColor: Colors.grey,
                      percent: 0.3,
                      lineWidth: 17,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    Container(
                      // padding: EdgeInsets.only(
                      //   top: 23,
                      //   left: 25,
                      // ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 40,
                            ),
                            child: Text(
                              "Balance",
                              style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: Text(
                              "\u{20B9}123",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

//Expanded
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.only(top: 15),
              //     decoration: BoxDecoration(
              //       color: Colors.indigo,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(50),
              //         topRight: Radius.circular(50),
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Container(
              //           padding: EdgeInsets.symmetric(
              //             vertical: 5,
              //             horizontal: 40,
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Container(
              //                 padding: EdgeInsets.symmetric(
              //                   vertical: 5,
              //                   horizontal: 20,
              //                 ),
              //                 //decoration: null,
              //                 child: Column(
              //                   children: [
              //                     Text(
              //                       "Income",
              //                       style: TextStyle(
              //                           fontSize: 15, color: Colors.white),
              //                     ),
              //                     Text(
              //                       "\$ 45",
              //                       style: TextStyle(
              //                           fontSize: 25, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               Container(
              //                 padding: EdgeInsets.symmetric(
              //                   vertical: 5,
              //                   horizontal: 20,
              //                 ),
              //                 //decoration: null,
              //                 child: Column(
              //                   children: [
              //                     Text(
              //                       "Expenses",
              //                       style: TextStyle(
              //                           fontSize: 15, color: Colors.white),
              //                     ),
              //                     Text(
              //                       "\$ 45",
              //                       style: TextStyle(
              //                           fontSize: 25, color: Colors.white),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
//expanded
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            
                            child: Column(
                              children: [
                                // Text(
                                //   "Total Expenses: \u{20B9}500",
                                //   style: TextStyle(
                                //     fontSize: 25,
                                //     fontWeight: FontWeight.bold,
                                    
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top:10,
                                    bottom: 10,
                                  ),
                                  child: Text("Transactions",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () => setState(() => _date--),
                                        child: const Icon(Icons.arrow_left),
                                      ),
                                      Text(
                                        '$_date ${DateFormat('MMMM yyyy').format(DateTime.now())}',
                                        style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => setState(() => _date++),
                                        child: const Icon(Icons.arrow_right),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: ListView.builder(
                                    itemCount: transactions.length,
                                    itemBuilder: (context, i) {
                                      return TransactionItem(transactions[i]);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
              //     ),
              //   ),
              // ),
//           ],
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final double value;
  final String category;
  final IconData iconData;
  final Color color;
  //final int date; 
  //final DateTime date;

  const Transaction({
    required this.title,
    required this.value,
    required this.category,
    required this.iconData,
    required this.color,
    //required this.date,
  });
}

List<Transaction> transactions = [
  Transaction(
    title: 'Dinner',
    value: 128,
    category: 'Meals',
    iconData: Icons.lunch_dining,
    color: Colors.yellow,
    //date: 2,
    //date: DateTime.now()
  ),
  Transaction(
    title: 'Books',
    value: 28,
    category: 'Education',
    iconData: Icons.school,
    color: Colors.deepPurple,
    //date:3,
    //date: DateTime.now(),
  
  ),
  Transaction(
    title: 'Cloths',
    value: 528,
    category: 'Shopping',
    iconData: Icons.shopping_bag,
    color: Colors.blue,
    //date: 6,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'Petrol',
    value: 200,
    category: 'Travelling',
    iconData: Icons.car_rental,
    color: Colors.purpleAccent,
    //date: 7,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'vedio games',
    value: 528,
    category: 'Entertainment',
    iconData: Icons.tv,
    color: Colors.greenAccent,
    //date: 8,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'Tablet',
    value: 648,
    category: 'Medical',
    iconData: Icons.local_hospital,
    color: Colors.redAccent,
    //date:5,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'Electricity Bill',
    value: 600,
    category: 'Bills and Utensils',
    iconData: Icons.receipt_long,
    color: Colors.orangeAccent,
    //date: 5,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'Birthday gift',
    value: 80,
    category: 'Gifts and Donation',
    iconData: Icons.card_giftcard,
    color: Colors.pink,
    //date: 2,
    //date:DateTime.now()
  ),
  Transaction(
    title: 'xyz',
    value: 180,
    category: 'Others',
    iconData: Icons.add_circle,
    color: Colors.grey,
    //date: 4,
  // date: DateTime.now()
  ),
];


class TransactionItem extends StatelessWidget {
  final Transaction transactions;

  const TransactionItem(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transactions.color,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              transactions.iconData,
              size: 20,
              color: Colors.black,
            ),
          ),

          title: Text(
            '${transactions.category}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Text(
            '${transactions.title}',
            
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Text(DateFormat.yMMMd().format(transactions.date))

          trailing: Text('\u{20B9}${transactions.value}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
