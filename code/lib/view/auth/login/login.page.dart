import 'package:flutter/material.dart';
import 'package:magpie_uni/view/auth/login/ui/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const LoginForm(),
      ),
    );
  }
}


// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   AppBar _buildAppBar(BuildContext context) {
//     final theme = Theme.of(context);
//     final textStyle = theme.textTheme.headline1;
//     final iconTheme = theme.iconTheme;

//     return AppBar(
//       title: Text(
//         'Login',
//         style: textStyle?.copyWith(color: kPrimaryColor),
//       ),
//       backgroundColor: Colors.transparent,
//       iconTheme: iconTheme.copyWith(color: kPrimaryColor),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: kBackgroundGradient,
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: _buildAppBar(context),
//           body: Padding(
//             padding: EdgeInsets.all(PaddingValue.medium),
//             child: SingleChildScrollView(
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     KeyboardVisibilityBuilder(
//                       builder: (context, isKeyboardVisible) {
//                         return isKeyboardVisible
//                             ? const SizedBox.shrink()
//                             : Padding(
//                                 padding: EdgeInsets.all(PaddingValue.large),
//                                 child: const _LoginPageLogo(),
//                               );
//                       },
//                     ),
//                     KeyboardVisibilityBuilder(
//                       builder: (context, isKeyboardVisible) {
//                         return isKeyboardVisible
//                             ? const SizedBox.shrink()
//                             : Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: PaddingValue.medium),
//                                 child: const _LoginPageDescription(),
//                               );
//                       },
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: PaddingValue.medium),
//                       child: const LoginForm(),
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _LoginPageLogo extends StatelessWidget {
//   const _LoginPageLogo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image(
//       image: AssetImages.logoWhiteTransparent,
//       width: IconSize.extraLarge,
//     );
//   }
// }

// class _LoginPageDescription extends HookWidget {
//   const _LoginPageDescription({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final l10n = useLocalization();
//     final theme = Theme.of(context);
//     final textStyle = theme.textTheme.bodyText1;
//     final color = theme.primaryColor;

//     return Column(
//       children: [
//         Text(
//           l10n.loginPageFirst,
//           style: textStyle?.copyWith(color: color),
//         ),
//         Text(l10n.loginPageSecond, style: textStyle?.copyWith(color: color)),
//       ],
//     );
//   }
// }
