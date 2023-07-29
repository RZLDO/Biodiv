import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/model/Class%20Model/detail_class_model.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/ui/class%20page/add_data_class.dart';
import 'package:biodiv/ui/ordo%20page/add_ordo.dart';
import 'package:biodiv/ui/ordo%20page/ordo.dart';
import 'package:biodiv/ui/ordo%20page/ordo_detail.dart';

import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../navigation/curved_navigation_bar.dart';

class DetailClass extends StatefulWidget {
  final String idClass;
  final int idClassGet;
  const DetailClass(
      {super.key, required this.idClass, required this.idClassGet});

  @override
  State<DetailClass> createState() => _DetailClassState();
}

class _DetailClassState extends State<DetailClass> {
  late ClassBloc _classBloc;
  late OrdoBloc _ordoBloc;
  bool? isUserCanEdit;
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _classBloc.add(GetDetailClass(idClass: widget.idClass));
    _ordoBloc = OrdoBloc(repository: OrdoRepository());
    _ordoBloc.add(GetOrdoByClassEvent(idClass: widget.idClassGet, page: 5));
    getUserLevel();
  }

  void getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? level = preferences.getInt("UserLevel");
    if (level == 3) {
      setState(() {
        isUserCanEdit = false;
      });
    } else {
      isUserCanEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClassBloc>(create: (context) => _classBloc),
        BlocProvider<OrdoBloc>(create: (context) => _ordoBloc)
      ],
      child: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          return BlocBuilder<OrdoBloc, OrdoState>(
            builder: (context, ordoState) {
              if (state is Failure) {
                return const Scaffold(
                  body: Center(
                    child: FailureState(textMessage: "an error occured"),
                  ),
                );
              } else if (state is DetailSuccess && ordoState is Success) {
                final ClassDataDetail? data = state.detail.data;
                final List<OrdoData> ordoData = ordoState.response.data;
                return Scaffold(
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
                                                          AddOrdoScreen(
                                                            isEdit: false,
                                                            idClass:
                                                                data!.idClass,
                                                          )));
                                            },
                                            text: "Add Ordo Data"),
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
                                                          AddDataClass(
                                                            idClass:
                                                                data!.idClass,
                                                            latin:
                                                                data.namaLatin,
                                                            common:
                                                                data.namaUmum,
                                                            chara:
                                                                data.ciriCiri,
                                                            desc:
                                                                data.keterangan,
                                                            image: data.gambar,
                                                            isEdit: true,
                                                          )));
                                            },
                                            text: "Edit Spesies"),
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
                                                        _classBloc.add(
                                                            DeleteClass(
                                                                idClass: data!
                                                                    .idClass));
                                                        AwesomeDialog(
                                                                context:
                                                                    context,
                                                                autoDismiss:
                                                                    false,
                                                                onDismissCallback:
                                                                    (type) {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                dialogType:
                                                                    DialogType
                                                                        .success,
                                                                btnOkOnPress:
                                                                    () {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const Navigation(pageId: 0)));
                                                                },
                                                                title:
                                                                    "Data Berhasil di hapus")
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
                          fit: BoxFit.cover,
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
                                            "Ordo from this class",
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
                                                          OrdoScreen(
                                                            isByClass: true,
                                                            idClass:
                                                                data.idClass,
                                                            appBarText:
                                                                "Ordo Of ${data.namaUmum}",
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
                                          margin:
                                              const EdgeInsets.only(top: 10),
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
                                          child: ordoData.isEmpty
                                              ? const Center(
                                                  child: EmptyData(
                                                      textMessage:
                                                          "Sorry, no available data. Please wait for updates."),
                                                )
                                              : ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: ordoData.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    OrdoData? dataAnimal;
                                                    OrdoData? dataAnimalDua;
                                                    if (index % 2 == 0 &&
                                                        index + 1 <
                                                            ordoData.length) {
                                                      dataAnimal =
                                                          ordoData[index];
                                                      dataAnimalDua =
                                                          ordoData[index + 1];
                                                    } else if (ordoData
                                                            .length >=
                                                        2) {
                                                      if (index ==
                                                          ordoData.length - 2) {
                                                        dataAnimal =
                                                            ordoData[index + 1];
                                                      }
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
                                                                        builder: (context) =>
                                                                            OrdoDetail(
                                                                              idOrdo: dataAnimal!.idOrdo,
                                                                            )));
                                                              },
                                                              child: CustomCard(
                                                                  textSize: 16,
                                                                  height: 120,
                                                                  namaUmum:
                                                                      dataAnimal
                                                                          .namaUmum,
                                                                  namaLatin:
                                                                      dataAnimal
                                                                          .namaLatin,
                                                                  image:
                                                                      "$baseUrl/image/${dataAnimal.gambar}"),
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
                                                                            OrdoDetail(
                                                                              idOrdo: dataAnimalDua!.idOrdo,
                                                                            )));
                                                              },
                                                              child: CustomCard(
                                                                  textSize: 16,
                                                                  height: 120,
                                                                  namaUmum:
                                                                      dataAnimalDua
                                                                          .namaUmum,
                                                                  namaLatin:
                                                                      dataAnimalDua
                                                                          .namaLatin,
                                                                  image:
                                                                      "$baseUrl/image/${dataAnimalDua.gambar}"),
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
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    data.namaLatin,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
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
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
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

class TextStyling extends StatelessWidget {
  final String title;
  final String text;
  final bool style;
  final double size;
  const TextStyling(
      {super.key,
      required this.title,
      required this.text,
      required this.style,
      this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.secondaryColor))),
        Text(text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: size,
                    fontStyle: style ? FontStyle.italic : FontStyle.normal))),
      ],
    );
  }
}

class ReadMoreCustom extends StatefulWidget {
  final String text;
  const ReadMoreCustom({super.key, required this.text});

  @override
  State<ReadMoreCustom> createState() => _ReadMoreCustomState();
}

class _ReadMoreCustomState extends State<ReadMoreCustom> {
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      widget.text,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Show more',
      trimExpandedText: '   Show less',
      textAlign: TextAlign.justify,
      style: GoogleFonts.poppins(
          textStyle: const TextStyle(
        fontSize: 14,
      )),
      moreStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.mainColor),
      lessStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.mainColor),
    );
  }
}
