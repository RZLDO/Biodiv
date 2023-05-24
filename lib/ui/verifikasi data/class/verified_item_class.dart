import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/card_view.dart';
import '../../../utils/constant.dart';

class UnverifiedClassScreen extends StatefulWidget {
  const UnverifiedClassScreen({super.key});

  @override
  State<UnverifiedClassScreen> createState() => _UnverifiedClassScreenState();
}

class _UnverifiedClassScreenState extends State<UnverifiedClassScreen> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifClass());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: ""),
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider(
        create: (context) => _verifBloc,
        child: BlocBuilder<VerifBloc, VerifState>(
            bloc: _verifBloc,
            builder: (context, state) {
              if (state is VerifLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is GetUnverifiedClassSuccess) {
                List<ClassData> data = state.result.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        ClassData? dataAnimal = data[index];
                        return Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "$baseUrl/image/${dataAnimal!.gambar}"),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextSpan(
                                              text: "Latin : ",
                                              data: dataAnimal.namaLatin),
                                          CustomTextSpan(
                                              text: "Common: ",
                                              data: dataAnimal.namaUmum),
                                          CustomTextSpan(
                                              text: "Character: ",
                                              data: dataAnimal.ciriCiri),
                                          CustomTextSpan(
                                              text: "Description: ",
                                              data: dataAnimal.keterangan),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Verivikasi",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.mainColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.redColorAccent),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: Text("an error occured"),
                );
              }
            }),
      ),
    );
  }
}
