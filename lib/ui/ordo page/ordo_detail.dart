import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/ui/famili%20page/add_famili.dart';
import 'package:biodiv/ui/famili%20page/famili.dart';
import 'package:biodiv/ui/famili%20page/famili_detail.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/ui/ordo%20page/add_ordo.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../class page/class_detail_page.dart';

class OrdoDetail extends StatefulWidget {
  final int idOrdo;
  const OrdoDetail({super.key, required this.idOrdo});

  @override
  State<OrdoDetail> createState() => _OrdoDetailState();
}

class _OrdoDetailState extends State<OrdoDetail> {
  late OrdoBloc _ordoBloc;
  late FamiliBloc _familiBloc;
  bool? isUserCanEdit;
  @override
  void initState() {
    _ordoBloc = OrdoBloc(repository: OrdoRepository());
    _ordoBloc.add(GetDetailOrdoEvent(idOrdo: widget.idOrdo));
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    _familiBloc.add(GetFamiliByOrdo(idOrdo: widget.idOrdo, page: 5));
    getUserLevel();
    super.initState();
  }

  void getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? level = preferences.getInt("UserLevel");
    if (level == 3) {
      setState(() {
        isUserCanEdit = false;
      });
    } else {
      setState(() {
        isUserCanEdit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _ordoBloc),
        BlocProvider(create: (context) => _familiBloc)
      ],
      child: BlocBuilder<FamiliBloc, FamiliState>(
        builder: (context, familiState) {
          return BlocBuilder<OrdoBloc, OrdoState>(
            builder: (context, state) {
              if (state is FailureOrdo) {
                return const Scaffold(
                  backgroundColor: AppColor.backgroundColor,
                  body: Center(
                      child: FailureState(textMessage: "An error Occured")),
                );
              } else if (state is DetailStateSuccess &&
                  familiState is GetDataFamiliSuccess) {
                final List<Family> familiData = familiState.result.data;
                final OrdoModel? data = state.response.data;
                return Scaffold(
                  backgroundColor: AppColor.backgroundColor,
                  floatingActionButton: isUserCanEdit != null && isUserCanEdit!
                      ? FloatingActionButton(
                          backgroundColor: AppColor.secondaryColor,
                          child: const Icon(Icons.info_outline),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30))),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.black45,
                                            )),
                                        ItemsAdmin(
                                            icon: Icons.add,
                                            ontap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddFamili(
                                                            isEdit: false,
                                                            idOrdo:
                                                                data!.idOrdo,
                                                          )));
                                            },
                                            text: "Add Family Data"),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        ItemsAdmin(
                                            icon: Icons.edit_document,
                                            ontap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddOrdoScreen(
                                                            idClass:
                                                                data!.idClass,
                                                            idOrdo: data.idOrdo,
                                                            latinName:
                                                                data.namaLatin,
                                                            commonName:
                                                                data.namaUmum,
                                                            character:
                                                                data.ciriCiri,
                                                            description:
                                                                data.keterangan,
                                                            image: data.gambar,
                                                            isEdit: true,
                                                          )));
                                            },
                                            text: "Edit this ordo"),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        ItemsAdmin(
                                            icon: Icons.delete_forever,
                                            ontap: () {
                                              AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.warning,
                                                      autoDismiss: false,
                                                      onDismissCallback:
                                                          (type) {
                                                        Navigator.pop(context);
                                                      },
                                                      btnOkOnPress: () {
                                                        AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .warning,
                                                                autoDismiss:
                                                                    false,
                                                                onDismissCallback:
                                                                    (type) {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                btnOkOnPress:
                                                                    () {
                                                                  _ordoBloc.add(
                                                                      DeleteOrdoEvent(
                                                                          idOrdo:
                                                                              data!.idOrdo));
                                                                  AwesomeDialog(
                                                                          context:
                                                                              context,
                                                                          autoDismiss:
                                                                              false,
                                                                          onDismissCallback:
                                                                              (type) {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          dialogType: DialogType
                                                                              .success,
                                                                          btnOkOnPress:
                                                                              () {
                                                                            Navigator.pushReplacement(context,
                                                                                MaterialPageRoute(builder: (context) => const Navigation(pageId: 0)));
                                                                          },
                                                                          title:
                                                                              "Data Berhasil di hapus")
                                                                      .show();
                                                                },
                                                                btnCancelOnPress:
                                                                    () {},
                                                                title:
                                                                    "Are you sure to delete this data?")
                                                            .show();
                                                      },
                                                      btnCancelOnPress: () {},
                                                      title:
                                                          "Are you sure to delete this data?")
                                                  .show();
                                            },
                                            text: "Delete Data "),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          })
                      : null,
                  body: SizedBox(
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
                            top: 30,
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25))),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                margin: isUserCanEdit!
                                    ? const EdgeInsets.only(top: 40)
                                    : const EdgeInsets.only(top: 40),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Characteristics",
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color:
                                                    AppColor.secondaryColor)),
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
                                                color:
                                                    AppColor.secondaryColor)),
                                      ),
                                      ReadMoreCustom(text: data.keterangan),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Famili from this Ordo",
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: AppColor
                                                        .secondaryColor)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FamiliScreen(
                                                            idOrdo: data.idOrdo,
                                                            isByOrdo: true,
                                                            appBarText:
                                                                "Famili Of ${data.namaUmum}",
                                                          )));
                                            },
                                            child: Text(
                                              "lihat semua",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor
                                                          .secondaryColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          height: isUserCanEdit!
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: familiData.isEmpty
                                              ? const Center(
                                                  child: EmptyData(
                                                      textMessage:
                                                          "Sorry, no available data. Please wait for updates."),
                                                )
                                              : ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: familiData.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    Family? dataAnimal;
                                                    Family? dataAnimalDua;
                                                    if (index % 2 == 0 &&
                                                        index + 1 <
                                                            familiData.length) {
                                                      dataAnimal =
                                                          familiData[index];
                                                      dataAnimalDua =
                                                          familiData[index + 1];
                                                    } else if (familiData
                                                            .length >=
                                                        2) {
                                                      if (index ==
                                                          familiData.length -
                                                              2) {
                                                        dataAnimal = familiData[
                                                            index + 1];
                                                      }
                                                    } else {
                                                      dataAnimal =
                                                          familiData[index];
                                                    }
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          if (dataAnimal !=
                                                              null)
                                                            Expanded(
                                                                child:
                                                                    GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DetailFamili(idFamili: dataAnimal!.idFamili)));
                                                              },
                                                              child: CustomCard(
                                                                  textSize: 16,
                                                                  height: 120,
                                                                  namaUmum:
                                                                      dataAnimal
                                                                          .commonName,
                                                                  namaLatin:
                                                                      dataAnimal
                                                                          .latinName,
                                                                  image:
                                                                      "$baseUrl/image/${dataAnimal.image}"),
                                                            )),
                                                          if (dataAnimalDua !=
                                                              null)
                                                            Expanded(
                                                                child:
                                                                    GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            DetailFamili(
                                                                              idFamili: dataAnimalDua!.idFamili,
                                                                            )));
                                                              },
                                                              child: CustomCard(
                                                                  textSize: 16,
                                                                  height: 120,
                                                                  namaUmum:
                                                                      dataAnimalDua
                                                                          .commonName,
                                                                  namaLatin:
                                                                      dataAnimalDua
                                                                          .latinName,
                                                                  image:
                                                                      "$baseUrl/image/${dataAnimalDua.image}"),
                                                            ))
                                                        ],
                                                      ),
                                                    );
                                                  }))
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.25,
                            left: 20,
                            right: 20,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 2,
                                        color: Colors.black.withOpacity(0.2))
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.namaUmum,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    data.namaLatin,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              } else {
                return const Scaffold(
                  backgroundColor: AppColor.backgroundColor,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.secondaryColor,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
