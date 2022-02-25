import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/view/auth/register/ui/register_form.dart';
import 'package:magpie_uni/view/auth/register/ui/widgets/register_page_description.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                theme.iconTheme.copyWith(color: theme.colorScheme.primary),
          ),
          body: Center(
            child: SizedBox(
              width: min(SizeConfig.screenWidth * 0.9, 500),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: textStyle?.copyWith(
                              color: Colors.black,
                              fontSize: SizeConfig.iconSize / 2.25,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              "Login here",
                              style: TextStyle(
                                color: color,
                                fontSize: SizeConfig.iconSize / 2.25,
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
      ),
    );
  }
}
