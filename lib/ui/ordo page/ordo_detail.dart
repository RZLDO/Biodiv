import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/ui/ordo%20page/add_ordo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BloC/class/class_bloc.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_button.dart';
import '../class page/class_detail_page.dart';

class OrdoDetail extends StatefulWidget {
  final int idOrdo;
  const OrdoDetail({super.key, required this.idOrdo});

  @override
  State<OrdoDetail> createState() => _OrdoDetailState();
}

class _OrdoDetailState extends State<OrdoDetail> {
  late OrdoBloc _ordoBloc;
  @override
  void initState() {
    _ordoBloc = OrdoBloc(repository: OrdoRepository());
    _ordoBloc.add(GetDetailOrdoEvent(idOrdo: widget.idOrdo));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // appBar: const CustomAppBar(text: ""),
        body: BlocProvider<OrdoBloc>(
          create: (context) => _ordoBloc,
          child: BlocBuilder<OrdoBloc, OrdoState>(
            builder: (context, state) {
              if (state is ClassLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is DetailStateSuccess) {
                final OrdoModel? data = state.response.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Image.network(
                        '$baseUrl/image/${data!.gambar}',
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
                                      text: data.namaUmum,
                                      style: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextStyling(
                                      title: "Latin Name",
                                      text: data.namaLatin,
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
                                    ReadMoreCustom(text: data.ciriCiri),
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
                                    ReadMoreCustom(text: data.keterangan)
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddOrdoScreen(
                                                      idClass: data.idClass,
                                                      idOrdo: data.idOrdo,
                                                      commonName: data.namaUmum,
                                                      latinName: data.namaLatin,
                                                      description:
                                                          data.keterangan,
                                                      character: data.ciriCiri,
                                                      image: data.gambar,
                                                      isEdit: true)));
                                    },
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
                                              title: "Delete Data",
                                              desc:
                                                  "Are you sure delete the data?",
                                              dialogType: DialogType.warning,
                                              autoDismiss: false,
                                              onDismissCallback: (type) {
                                                Navigator.pop(context);
                                              },
                                              btnOkOnPress: () {
                                                _ordoBloc.add(DeleteOrdoEvent(
                                                    idOrdo: data.idOrdo));
                                                if (state
                                                    is DeleteOrdoStateSuccess) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    title: "Delete Data",
                                                    desc: "Delete Data Success",
                                                    dialogType:
                                                        DialogType.success,
                                                    autoDismiss: false,
                                                    onDismissCallback: (type) {
                                                      Navigator.pop(context);
                                                    },
                                                    btnOkOnPress: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Navigation(
                                                                      pageId:
                                                                          0)));
                                                    },
                                                  ).show();
                                                }
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Navigation(
                                                                pageId: 0)));
                                              },
                                              btnCancelOnPress: () {})
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
