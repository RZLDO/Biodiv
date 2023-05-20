import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:biodiv/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_button.dart';
import '../class page/class_detail_page.dart';

class DetailFamili extends StatefulWidget {
  final int idFamili;
  const DetailFamili({super.key, required this.idFamili});

  @override
  State<DetailFamili> createState() => _DetailFamiliState();
}

class _DetailFamiliState extends State<DetailFamili> {
  late FamiliBloc _familiBloc;
  @override
  void initState() {
    super.initState();
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    _familiBloc.add(GetFamiliDetailevent(idFamili: widget.idFamili));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // appBar: const CustomAppBar(text: ""),
        body: BlocProvider<FamiliBloc>(
          create: (context) => _familiBloc,
          child: BlocBuilder<FamiliBloc, FamiliState>(
            builder: (context, state) {
              if (state is FamiliLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is GetDetailFamiliSuccess) {
                final FamilyDetail? data = state.result.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Image.network(
                        '$baseUrl/image/${data!.image}',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.fill,
                      )),
                      Positioned(
                          top: 50,
                          left: 15,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.65,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 50),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextStyling(
                                      title: "Common Name",
                                      text: data.commonName,
                                      style: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextStyling(
                                      title: "Latin Name",
                                      text: data.latinName,
                                      style: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Characteristics",
                                      style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: AppColor.secondaryColor)),
                                    ),
                                    ReadMoreCustom(text: data.characteristics),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description",
                                      style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: AppColor.secondaryColor)),
                                    ),
                                    ReadMoreCustom(text: data.description)
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                CustomButtonExtended(
                                    text: "Edit Data",
                                    onTap: () {},
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    setText: false),
                                const Spacer(),
                                CustomButtonExtended(
                                    color: AppColor.redColorAccent,
                                    icon: Icons.delete,
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              autoDismiss: false,
                                              onDismissCallback: (type) {
                                                Navigator.pop(context);
                                              },
                                              btnOkOnPress: () {
                                                _familiBloc.add(
                                                    DeleteFamiliEvent(
                                                        idFamili: data.id));
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.warning,
                                                        autoDismiss: false,
                                                        onDismissCallback:
                                                            (type) {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        btnOkOnPress: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const HomeScreen()));
                                                        },
                                                        btnCancelOnPress: () {},
                                                        desc:
                                                            "Success delete data",
                                                        title: "Delete Data")
                                                    .show();
                                              },
                                              btnCancelOnPress: () {},
                                              desc:
                                                  "Are you sure to delete this data?",
                                              title: "Delete Data")
                                          .show();
                                    },
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    setText: true),
                                const SizedBox(
                                  width: 24,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("an error occured"),
                );
              }
            },
          ),
        ));
  }
}
