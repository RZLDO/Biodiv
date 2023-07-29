import 'package:biodiv/BloC/login/login_bloc.dart';
import 'package:biodiv/repository/auth_repository.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/ui/register/register_screen.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final AuthRepository repository = AuthRepository();
  final LoginBloc _loginBloc = LoginBloc(authRepository: AuthRepository());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(authRepository: AuthRepository()),
      child: Scaffold(
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
              BlocConsumer<LoginBloc, LoginState>(
                  bloc: _loginBloc,
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Navigation(pageId: 0)));
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.mainColor,
                        content: Text(state.errorMessage),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        text: state is LoginLoading ? "Loading" : "login",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _loginBloc.add(LoginButtonPressed(
                                username: _usernameController.text,
                                password: _passwordController.text));
                          }
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Not Have Account ? ",
                      style: ReusableTextStyle.basic),
                  TextSpan(
                      text: "Register Here!",
                      style: ReusableTextStyle.basicMainColorBold,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                        })
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
