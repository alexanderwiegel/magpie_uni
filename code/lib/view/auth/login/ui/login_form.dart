import 'package:flutter/material.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/widgets/magpie.form.field.dart';

import 'package:magpie_uni/widgets/magpie.form.field.dart';
import 'package:magpie_uni/Constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email, _password, _error, _token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MagpieTextFormField.email(
                validator: EmailValidator.validate,
                name: 'Email',
                onChanged: (value) {},
              ),
              const SizedBox(height: 20.0),
              MagpieTextFormField.password(
                validator: PasswordValidator.validate,
                name: 'Password',
                onChanged: (value) {},
                hintText: 'Re-enter password',
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      primary: mainColor,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/profile');
                        //TODO: implement login
                      }
                    },
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    child: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      primary: mainColor,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
