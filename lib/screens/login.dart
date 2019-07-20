import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gailey_boys/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/timeline');
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 180,
              ),
              SizedBox(height: 15),
              Text(
                'Gailey Boys',
                style: Theme.of(context).textTheme.headline,
              ),
              SizedBox(height: 80),
              LoginButton(
                color: Colors.red[300],
                icon: FontAwesomeIcons.google,
                text: 'Sign in with Google',
                loginMethod: auth.googleSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {this.text, this.icon, this.color, @required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        color: color,
        padding: EdgeInsets.all(20),
        icon: Icon(icon),
        label: Text(text),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/timeline');
          }
        },
      ),
    );
  }
}
