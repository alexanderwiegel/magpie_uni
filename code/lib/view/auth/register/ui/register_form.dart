import 'package:flutter/material.dart';
import 'package:magpie_uni/services/http_service.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/widgets/atoms/buttons/magpie_button.dart';
import 'package:magpie_uni/widgets/magpie.text.form.field.dart';
import 'package:magpie_uni/constants.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  late bool isLoading = false;
  late String _userName, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formFieldColor = theme.primaryColor;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              MagpieTextFormField.name(
                  labelText: 'User name',
                  validator: FirstNameValidator.validate,
                  name: 'userName',
                  onChanged: (userName) => _userName = userName!,
                  hintText: 'Username'),
              const SizedBox(height: 20.0),
              MagpieTextFormField.email(
                validator: EmailValidator.validate,
                name: 'Email',
                onChanged: (email) => _email = email!,
              ),
              const SizedBox(height: 20.0),
              MagpieTextFormField.password(
                validator: PasswordValidator.validate,
                name: 'Password',
                labelText: 'Password',
                onChanged: (password) => _password = password!,
                hintText: 'Password',
              ),
              const SizedBox(height: 20.0),
              MagpieTextFormField.password(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (value.length < 6) {
                    return 'Your password must be at least 6 characters long';
                  } else if (value != _password) {
                    return 'Your password doesn\'t match';
                  }
                  return null;
                },
                name: 'Re-enter password',
                labelText: 'Confirm password',
                onChanged: (confirmPassword) {},
                hintText: 'Confirm password',
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: MagpieButton.primary(
                  loading: isLoading,
                  label: "Create",
                  color: formFieldColor,
                  textColor: textColor,
                  onPressed: _onCreatePressed,
                ),
              ),
            ],
          )),
    );
  }

  _onCreatePressed() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Map data = {
        'email': _email.trim(),
        'password': _password.trim(),
        'username': _userName.trim(),
      };
      setState(() => isLoading = true);
      final statusCode = await httpService.signUp(data);
      if (statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen(),
            ),
            (route) => false);
      }
      setState(() => isLoading = false);
    }
  }
}
