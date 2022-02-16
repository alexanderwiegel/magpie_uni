import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:magpie_uni/services/http_service.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/view/home.page.dart';
import 'package:magpie_uni/widgets/atoms/buttons/magpie_button.dart';
import 'package:magpie_uni/widgets/magpie.text.form.field.dart';
import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/network/user_api_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final HttpService httpService = HttpService();
  late bool isLoading = false;
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formFieldColor = theme.primaryColor;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: MagpieButton.primary(
              loading: isLoading,
              label: "Login",
              color: formFieldColor,
              textColor: textColor,
              onPressed: () => _onLoginPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  _onLoginPressed(BuildContext context) async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Map data = {
        'email': _email.trim(),
        'password': _password.trim(),
      };
      setState(() => isLoading = true);
      final response = await httpService.signIn(data);
      if (response.statusCode == 200) {

        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> user = jsonResponse["user"];
        UserAPIManager.token = jsonResponse["token"].toString();
        UserAPIManager.currentUserId = user["id"];

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const HomePage(),
            ),
            (route) => false);
      }
      else {
        setState(() => isLoading = false);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String errMessage = jsonResponse["message"].toString();
        _showDialog(context, errMessage);
      }

    }
  }

  void _showDialog(BuildContext context, String errMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!"),
          content: Text(errMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
