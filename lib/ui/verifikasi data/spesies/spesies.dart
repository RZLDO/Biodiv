import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/verification/verif_bloc.dart';

import 'package:biodiv/model/spesies/get_spesies_data.dart';

import 'package:biodiv/repository/verification_repository.dart';
import 'package:biodiv/ui/verifikasi%20data/verif_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/custom_app_bar.dart';
import '../../../utils/custom_textfield.dart';
import '../../../utils/state_screen.dart';

class SpesiesUnverif extends StatefulWidget {
  const SpesiesUnverif({super.key});

  @override
  State<SpesiesUnverif> createState() => _SpesiesUnverifState();
}

class _SpesiesUnverifState extends State<SpesiesUnverif> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifSpesies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: ""),
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider(
          create: (context) => _verifBloc,
          child: BlocConsumer<VerifBloc, VerifState>(
              bloc: _verifBloc,
              builder: (context, state) {
                if (state is VerifLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  );
                } else if (state is GetUnverifiedSpesies) {
                  List<SpeciesData> data = state.result.data;
                  if (data.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: EmptyData(
                          textMessage: "No data to verified Here",
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            SpeciesData? dataAnimal = data[index];
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
                                                      "$baseUrl/image/${dataAnimal.gambar}"),
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
                                                  data:
                                                      dataAnimal.karakteristik),
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
                                          onTap: () {
                                            _verifBloc.add(VerifClassEvent(
                                                id: dataAnimal.idSpesies,
                                                path: "spesies"));
                                          },
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
                                          onTap: () {
                                            AwesomeDialog(
                                                    context: context,
                                                    title: "Verif Data",
                                                    desc:
                                                        "this action will delete this data",
                                                    dialogType:
                                                        DialogType.warning,
                                                    autoDismiss: false,
                                                    onDismissCallback: (type) {
                                                      Navigator.pop(context);
                                                    },
                                                    btnOkOnPress: () {
                                                      _verifBloc.add(
                                                          DeleteUnverifEvent(
                                                              id: dataAnimal
                                                                  .idSpesies,
                                                              path: "spesies"));
                                                    },
                                                    btnCancelOnPress: () {})
                                                .show();
                                          },
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
                  }
                } else {
                  return const Center(
                    child: Text("an error occured"),
                  );
                }
              },
              listener: (context, state) {
                if (state is VerifSuccess) {
                  AwesomeDialog(
                    context: context,
                    title: "Verif Data",
                    desc: "Verification Data Success",
                    dialogType: DialogType.success,
                    autoDismiss: false,
                    onDismissCallback: (type) {
                      Navigator.pop(context);
                    },
                    btnOkOnPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpesiesUnverif()));
                    },
                  ).show();
                } else if (state is VerificationFailure) {
                  AwesomeDialog(
                    context: context,
                    title: "Verif Data",
                    desc: "Verification Failed",
                    dialogType: DialogType.error,
                    autoDismiss: false,
                    onDismissCallback: (type) {
                      Navigator.pop(context);
                    },
                    btnOkOnPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VerificationScreen()));
                    },
                  ).show();
                } else if (state is DeleteUnverifSuccess) {
                  AwesomeDialog(
                    context: context,
                    title: "Verif Data",
                    desc: "Delete Data Success",
                    dialogType: DialogType.success,
                    autoDismiss: false,
                    onDismissCallback: (type) {
                      Navigator.pop(context);
                    },
                    btnOkOnPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpesiesUnverif()));
                    },
                  ).show();
                }
              })),
    );
  }
}
