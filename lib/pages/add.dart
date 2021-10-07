import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namedata = new TextEditingController();
  TextEditingController spentdata = new TextEditingController();

  var isdateValid = false;
  DateTime date = DateTime.parse('2002-01-11');
  DateTime datechecker = DateTime.parse('2002-01-11');

  Future _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: date == datechecker ? today : date,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: today,
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      date = pickedDate;
    });
  }

  String getText() {
    if (date == datechecker) {
      isdateValid = false;
      return 'Date';
    } else {
      isdateValid = true;
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Transaction Added',
        style: TextStyle(fontSize: 14, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 1),
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
      width: 200,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final users = [
    const Item(
        'Education',
        Icon(
          Icons.book_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Rent',
        Icon(
          CupertinoIcons.house,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Entertainment',
        Icon(
          Icons.movie_creation_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Taxes',
        Icon(
          CupertinoIcons.money_dollar_circle,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Vehicle',
        Icon(
          CupertinoIcons.car_detailed,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Stationary',
        Icon(
          CupertinoIcons.pencil_outline,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Meal',
        Icon(
          Icons.fastfood_outlined,
          color: const Color(0xFF000000),
        )),
    const Item(
        'Other',
        Icon(
          Icons.fact_check_outlined,
          color: const Color(0xFF000000),
        )),
  ];
  String values = 'Other';

  @override
  Widget build(BuildContext context) {
    final userKey = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: Vx.m12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  "New Transaction"
                      .text
                      .xl5
                      .fontFamily('Helvetica')
                      .color(Colors.black87)
                      .make(),
                  SizedBox(
                    height: 2,
                  ),
                  "Track Your Expenses!"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(Colors.indigo.shade400)
                      .make(),
                  SizedBox(
                    height: 25,
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 14.0,
                          ),

                          // Title TextField
                          TextFormField(
                            controller: namedata,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefixIcon: Icon(Icons.title),
                              hintText: "Enter a title",
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please fill this field";
                              } else if (value.length < 2) {
                                return "Please enter valid title";
                              } else {
                                return null;
                              }
                            },
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                            controller: spentdata,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              prefixIcon: Icon(Icons.local_atm),
                              hintText: "Enter the amount",
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Please fill this field";
                              } else if (int.parse(value) <= 0) {
                                return "Enter Valid Amount";
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          Container(
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                iconSize: 25,
                                hint: Text("Select a Category"),
                                isExpanded: true,
                                value: values,
                                items: users.map((Item user) {
                                  return DropdownMenuItem(
                                    value: user.name,
                                    child: Row(
                                      children: [
                                        user.icon,
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.values = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30.0,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Date TextField
                              Flexible(
                                fit: FlexFit.loose,
                                child: GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                        ),
                                        labelText: getText(),
                                        hintText: 'Date of Transaction',
                                        prefixIcon: Icon(Icons.calendar_today),
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 40.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 21.0,
                                  )),
                              child: Text(
                                'Add Transaction',
                                style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  color: Colors.indigo,
                                ),
                              ),
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();

                                if (isValid && isdateValid) {
                                  Map<String, dynamic> data = {
                                    "name": namedata.text,
                                    "spent": int.parse(spentdata.text),
                                    "category": values,
                                    "date": date
                                  };
                                  FirebaseFirestore.instance
                                      .collection(userKey!.email!)
                                      .add(data);
                                  showSnackBar(context);
                                  namedata.clear();
                                  spentdata.clear();
                                  values = "Select a Category";
                                  date = DateTime.parse('2002-01-11');
                                  // Navigator.pushNamed(
                                  //     context, MyRoutes.homeRoute);
                                }
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
          ),
        ),
      ),
    );
  }
}
