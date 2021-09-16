import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

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
  TextEditingController namedata = new TextEditingController();
  TextEditingController spentdata = new TextEditingController();
  TextEditingController categorydata = new TextEditingController();
  TextEditingController datedata = new TextEditingController();

  DateTime date = DateTime.parse('2002-01-11');
  DateTime datechecker = DateTime.parse('2002-01-11');

  Future _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: date == datechecker ? today : date,
      firstDate: DateTime(DateTime.now().year - 5),
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
      return 'Date';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
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
  String? values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: Vx.m16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  "New Transaction"
                      .text
                      .xl5
                      .fontFamily('Helvetica')
                      .color(Colors.indigo)
                      .make(),
                  SizedBox(
                    height: 2,
                  ),
                  "Track your Expenses"
                      .text
                      .xl2
                      .fontFamily('Helvetica')
                      .color(Colors.indigo)
                      .make(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),

                            // Title TextField
                            TextFormField(
                              controller: namedata,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                ),
                                prefixIcon: Icon(Icons.title),
                                hintText: "Enter a title",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill this field";
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
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                ),
                                prefixIcon: Icon(Icons.local_atm),
                                hintText: "Enter the amount",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
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
                              padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                          ),
                                          labelText: getText(),
                                          hintText: 'Date of Transaction',
                                          prefixIcon: Icon(Icons.calendar_today),
                                          suffixIcon: Icon(Icons.arrow_drop_down),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return "Please select a date";
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 30.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 60.0,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  shadowColor: Colors.cyanAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))

                                ),
                                icon: Icon(Icons.check),
                                label: Text('Add Transaction'),
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "name": namedata.text,
                                    "spent": int.parse(spentdata.text),
                                    "category": values,
                                    "date": date
                                  };
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}