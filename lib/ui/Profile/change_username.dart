import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/repository/profile_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BloC/profile/profile_bloc.dart';
import '../navigation/curved_navigation_bar.dart';

class ChangeUsernameScreen extends StatefulWidget {
  final int idUser;
  const ChangeUsernameScreen({super.key, required this.idUser});

  @override
  State<ChangeUsernameScreen> createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final oldUsername = TextEditingController();
  final newUsername = TextEditingController();
  late ProfileBloc _profileBloc;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    _profileBloc = ProfileBloc(repository: ProfileRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(text: ""),
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider<ProfileBloc>(
        create: (context) => _profileBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Change Useraname",
                  style: GoogleFonts.poppins(
                      color: AppColor.mainColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                    "Your new username must be different from the previous one.",
                    style: GoogleFonts.montserrat(
                      color: AppColor.mainColor,
                      fontSize: 16,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      CustomTextField(
                          hintText: "New Username",
                          controller: newUsername,
                          validator: Validator.basicValidate,
                          obsecure: true),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  )),
              BlocConsumer(
                  bloc: _profileBloc,
                  builder: (context, state) {
                    return CustomButton(
                        text: "Change Username",
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            _profileBloc.add(ChangeUsernameEvent(
                                idUser: widget.idUser,
                                username: newUsername.toString()));
                          }
                        });
                  },
                  listener: (context, state) {
                    if (state is StateFailure) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              autoDismiss: false,
                              title: "Change Username",
                              desc: state.message,
                              onDismissCallback: (type) =>
                                  Navigator.pop(context),
                              btnOkOnPress: () {})
                          .show();
                    } else if (state is ChangePasswordAndUsernameSuccess) {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          autoDismiss: false,
                          title: "Change Username Success",
                          desc: state.result.message,
                          onDismissCallback: (type) => Navigator.pop(context),
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Navigation(pageId: 0)));
                          }).show();
                    } else if (state is ProfileLoading) {
                      const Center(
                        child: LinearProgressIndicator(
                          color: AppColor.secondaryColor,
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
