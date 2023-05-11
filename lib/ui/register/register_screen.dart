import 'package:biodiv/BloC/register/register_bloc.dart';
import 'package:biodiv/repository/auth_repository.dart';
import 'package:biodiv/ui/login/login_screen.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterBlock _registerBlock =
      RegisterBlock(authRepository: AuthRepository());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBlock>(
      create: (context) => _registerBlock,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColor.mainColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset(
                "asset/image/LogoBiodiversity.png",
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          hintText: "name",
                          controller: _nameController,
                          validator: Validator.basicValidate,
                          obsecure: false),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          hintText: "address",
                          controller: _addressController,
                          validator: Validator.basicValidate,
                          obsecure: false),
                      const SizedBox(
                        height: 30,
                      ),
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
                          obsecure: true),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer(
                  bloc: _registerBlock,
                  builder: (context, state) {
                    return CustomButton(
                        text: "Register",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _registerBlock.add(RegisterButtonPressed(
                                name: _nameController.text,
                                address: _addressController.text,
                                username: _usernameController.text,
                                password: _passwordController.text));
                          }
                        });
                  },
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.mainColor,
                        content: Text(state.errorMessage),
                        duration: const Duration(seconds: 1),
                      ));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
