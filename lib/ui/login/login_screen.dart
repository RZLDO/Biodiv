import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/LogoBiodiversity.png",
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            const SizedBox(
              height: 35,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        hintText: "username",
                        controller: _usernameController,
                        validator: Validator.basicValidate,
                        obsecure: false),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        hintText: "password",
                        controller: _passwordController,
                        validator: Validator.validatePassword,
                        obsecure: true)
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            CustomButton(text: "Login", onTap: () {}),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(children: <TextSpan>[
                const TextSpan(
                    text: "Not Have Account ? ",
                    style: ReusableTextStyle.basic),
                TextSpan(
                    text: "Register!",
                    style: ReusableTextStyle.basicMainColorBold,
                    recognizer: TapGestureRecognizer()..onTap = () {})
              ]),
            )
          ],
        ),
      ),
    );
  }
}
