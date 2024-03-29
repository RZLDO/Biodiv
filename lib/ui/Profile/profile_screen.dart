import 'package:biodiv/model/profile%20model/profile.dart';
import 'package:biodiv/repository/profile_repository.dart';
import 'package:biodiv/ui/Profile/change_password.dart';
import 'package:biodiv/ui/Profile/change_username.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../BloC/profile/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  int? idInstitusi;
  @override
  void initState() {
    _profileBloc = ProfileBloc(repository: ProfileRepository());
    getUserPreference();
    super.initState();
  }

  void getUserPreference() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    idInstitusi = preferences.getInt('id');
    if (idInstitusi != null) {
      _profileBloc.add(GetProfileEvent(idUser: idInstitusi!.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: BlocProvider(
        create: (context) => _profileBloc,
        child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: _profileBloc,
            builder: (context, state) {
              if (state is GetProfileStateFailure) {
                return const Center(
                  child: FailureState(textMessage: "error occured"),
                );
              } else if (state is GetProfileStateSuccess) {
                ProfileData? data = state.result.data;
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer,
                                color: Colors.black.withOpacity(0.6))
                          ]),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "asset/image/LogoBiodiversity.png")),
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data!.nama,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                data.alamat,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ProfileButton(
                      text: "Change username",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeUsernameScreen(
                                      idUser: idInstitusi!.toInt(),
                                    )));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ProfileButton(
                      text: "Change password ",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(
                                      idUser: idInstitusi!.toInt(),
                                    )));
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.secondaryColor,
                  ),
                );
              }
            }),
      )),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final Function() ontap;
  const ProfileButton({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black.withOpacity(0.6))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColor.mainColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
