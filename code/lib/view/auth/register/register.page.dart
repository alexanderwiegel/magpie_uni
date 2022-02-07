import 'package:flutter/material.dart';
import 'package:magpie_uni/view/auth/register/ui/signup_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: const RegisterForm(),
      ),
    );
  }
}
