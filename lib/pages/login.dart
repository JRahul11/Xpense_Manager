import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpense/home.dart';
import 'package:xpense/provider/google_sign_in.dart';
import 'package:xpense/widgets/sign_up_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);

            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return Home();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went Wrong!'));
            } else {
              return SignUpWidget();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
