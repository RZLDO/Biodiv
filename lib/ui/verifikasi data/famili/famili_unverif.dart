import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';

import 'package:biodiv/repository/verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/card_view.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/custom_app_bar.dart';
import '../../../utils/custom_textfield.dart';

class FamiliUnverif extends StatefulWidget {
  const FamiliUnverif({super.key});

  @override
  State<FamiliUnverif> createState() => _FamiliUnverifState();
}

class _FamiliUnverifState extends State<FamiliUnverif> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifFamili());
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
              } else if (state is GetUnverifiedFamili) {
                List<Family> data = state.result.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Family? dataAnimal = data[index];
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
                                                  "$baseUrl/image/${dataAnimal.image}"),
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
                                              data: dataAnimal.latinName),
                                          CustomTextSpan(
                                              text: "Common: ",
                                              data: dataAnimal.commonName),
                                          CustomTextSpan(
                                              text: "Character: ",
                                              data: dataAnimal.characteristics),
                                          CustomTextSpan(
                                              text: "Description: ",
                                              data: dataAnimal.description),
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
