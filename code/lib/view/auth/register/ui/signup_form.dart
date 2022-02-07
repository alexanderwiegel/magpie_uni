import 'package:flutter/material.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/widgets/magpie.form.field.dart';

import '../../../../constants.dart';

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
              MagpieTextFormField.name(
                  labelText: 'First Name',
                  validator: FirstNameValidator.validate,
                  name: 'firstName',
                  onChanged: (value) {},
                  hintText: 'First Name'),
              const SizedBox(
                height: 20.0,
              ),
              MagpieTextFormField.name(
                  labelText: 'Last Name',
                  validator: FirstNameValidator.validate,
                  name: 'lastName',
                  onChanged: (value) {},
                  hintText: 'Last Name'),
              const SizedBox(
                height: 20.0,
              ),
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
                hintText: 'Password',
              ),
              const SizedBox(height: 20.0),
              MagpieTextFormField.password(
                validator: PasswordValidator.validate,
                name: 'Re-enter Password',
                onChanged: (value) {},
                hintText: 'Re-enter Password',
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
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/profile');
                      //TODO: Add registration logic

                    }
                  }),
            ],
          )),
    );
  }
}
