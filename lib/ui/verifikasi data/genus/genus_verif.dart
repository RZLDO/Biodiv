import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/card_view.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/custom_app_bar.dart';
import '../../../utils/custom_textfield.dart';
import '../../../utils/state_screen.dart';
import '../verif_data.dart';

class GenusUnverif extends StatefulWidget {
  const GenusUnverif({super.key});

  @override
  State<GenusUnverif> createState() => _GenusUnverifState();
}

class _GenusUnverifState extends State<GenusUnverif> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifGenus());
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
                } else if (state is GetUnverifiedGenusSuccess) {
                  List<GenusData> data = state.result.data;

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
                            GenusData? dataAnimal = data[index];
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
                                          onTap: () {
                                            _verifBloc.add(VerifClassEvent(
                                                id: dataAnimal.idGenus,
                                                path: "genus"));
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
                                                                  .idGenus,
                                                              path: "genus"));
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
                              builder: (context) => const GenusUnverif()));
                    },
                  ).show();
                } else if (state is VerificationFailure) {
                  AwesomeDialog(
                    context: context,
                    title: "Verif Data",
                    desc: "Verification Failed",
                    dialogType: DialogType.success,
                    autoDismiss: false,
                    onDismissCallback: (type) {
                      Navigator.pop(context);
                    },
                    btnOkOnPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Navigation(pageId: 1)));
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
                              builder: (context) => const GenusUnverif()));
                    },
                  ).show();
                }
              })),
    );
  }
}
