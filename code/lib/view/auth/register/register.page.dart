import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/view/auth/register/ui/register_form.dart';
import 'package:magpie_uni/view/auth/register/ui/widgets/register_page_description.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

AppBar _buildAppBar(BuildContext context) {
  final theme = Theme.of(context);
  final iconTheme = theme.iconTheme;
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: iconTheme.copyWith(color: theme.colorScheme.primary),
  );
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;
    final color = theme.primaryColor;

    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: RegisterPageDescription(),
                            );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: RegisterForm(),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: textStyle?.copyWith(color: Colors.black)),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen(),
                              ),
                              (route) => false),
                          child: Text(
                            "Login here",
                            style: TextStyle(
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
