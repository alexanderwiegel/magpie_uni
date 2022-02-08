import 'package:flutter/material.dart';
import 'package:magpie_uni/services/http_service.dart';
import 'package:magpie_uni/services/validators.dart';
import 'package:magpie_uni/widgets/atoms/buttons/magpie_button.dart';
import 'package:magpie_uni/widgets/atoms/buttons/magpie_text_button.dart';
import 'package:magpie_uni/widgets/magpie.form.field.dart';
import '../../../../constants.dart';
import '../../../profile.dart';

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
            Align(
                alignment: Alignment.bottomRight,
                child: MagpieTextButton.primary(
                  color: Colors.black,
                  onPressed: () {},
                  label: "Forgot Password?",
                )),
            SizedBox(
              width: double.infinity,
              child: MagpieButton.primary(
                loading: isLoading,
                label: "Login",
                color: formFieldColor,
                textColor: textColor,
                onPressed: _onLoginPressed,
              ),
            ),
          ],
        ));
  }

  _onLoginPressed() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Map data = {
        'email': _email.trim(),
        'password': _password.trim(),
      };
      setState(() {
        isLoading = true;
      });
      final statusCode = await httpService.signIn(data);
      if (statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Profile()),
            (route) => false);
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
