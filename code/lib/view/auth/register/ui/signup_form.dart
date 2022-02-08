import 'package:flutter/material.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/Constants.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email, _password, _firstName, _lastName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (input) => _firstName = input.trim(),
                decoration: const InputDecoration(
                  labelText: 'Firstname',
                  border: OutlineInputBorder(),
                ),
                validator: FirstNameValidator.validate,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (input) => _lastName = input.trim(),
                decoration: const InputDecoration(
                  labelText: 'Lastname',
                  border: OutlineInputBorder(),
                ),
                validator: LastNameValidator.validate,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                onChanged: (input) => _email = input,
                decoration: const InputDecoration(
                  labelText: 'E-Mail Address',
                  border: OutlineInputBorder(),
                ),
                validator: EmailValidator.validate,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                autocorrect: false,
                onChanged: (input) => _password = input,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: PasswordValidator.validate,
              ),
              const SizedBox(height: 20.0),
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
                    // Navigator.pushNamed(context, '/home');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                    //TODO: Add registration logic
                  }),
            ],
          )),
    );
  }
}
