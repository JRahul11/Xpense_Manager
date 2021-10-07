import 'package:flutter/material.dart';
import 'package:xpense/widgets/background.dart';
import 'google_signup_button_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          "Xpense Manager"
              .text
              .xl5
              .fontFamily('Helvetica')
              .color(Colors.black)
              .make(),
          SizedBox(
            height: 35,
          ),
          Image.asset(
            "assets/images/login.png",
            height: size.height * 0.45,
          ),
          SizedBox(
            height: 40,
          ),
          GoogleSignUpButtonWidget(),
        ],
      ),
    );
  }
}
