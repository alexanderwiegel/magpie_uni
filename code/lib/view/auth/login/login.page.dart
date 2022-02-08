import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:magpie_uni/view/auth/login/ui/login_form.dart';
import 'ui/widgets/login_page_description.dart';
import 'ui/widgets/login_page_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;
    final color = theme.primaryColor;

    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 50.0),
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: LoginPageLogo(),
                            );
                    },
                  ),
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: LoginPageDescription(),
                            );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: LoginForm(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: textStyle?.copyWith(color: Colors.black)),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
