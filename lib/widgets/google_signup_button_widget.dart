import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xpense/provider/google_sign_in.dart';

class GoogleSignUpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          side: BorderSide(width: 1, color: Colors.grey),
        ),
        label: Text(
          ' Login with Google',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 22,
            color: Colors.black,
          ),
        ),

        // highLightedBorderColor: Colors.black,
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();
        },
      ),
    );
  }
}
