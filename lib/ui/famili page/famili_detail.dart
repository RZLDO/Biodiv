import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/BloC/genus/genus_bloc.dart';
import 'package:biodiv/model/famili%20model/detai_famili_mode.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:biodiv/ui/famili%20page/add_famili.dart';
import 'package:biodiv/ui/genus/add_data_genus.dart';
import 'package:biodiv/ui/genus/detail_genus.dart';
import 'package:biodiv/ui/genus/genus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/state_screen.dart';
import '../class page/class_detail_page.dart';
import '../navigation/curved_navigation_bar.dart';

class DetailFamili extends StatefulWidget {
  final int idFamili;
  const DetailFamili({super.key, required this.idFamili});

  @override
  State<DetailFamili> createState() => _DetailFamiliState();
}

class _DetailFamiliState extends State<DetailFamili> {
  late FamiliBloc _familiBloc;
  late GenusBloc _genusBloc;
  bool? isUserCanEdit;
  @override
  void initState() {
    super.initState();
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    _familiBloc.add(GetFamiliDetailevent(idFamili: widget.idFamili));
    _genusBloc = GenusBloc(repository: GenusRepository());
    _genusBloc.add(GetGenusByFamili(idFamili: widget.idFamili, page: 5));
    getUserPreference();
  }

  void getUserPreference() async {
    final SharedPreferences userPreference =
        await SharedPreferences.getInstance();

    final userLevel = userPreference.getInt("UserLevel");
    if (userLevel == 3) {
      isUserCanEdit = false;
    } else {
      isUserCanEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _familiBloc),
        BlocProvider(create: (context) => _genusBloc)
      ],
      child: BlocBuilder<GenusBloc, GenusState>(
        builder: (context, genusState) {
          return BlocBuilder<FamiliBloc, FamiliState>(
            builder: (context, state) {
              if (state is FailureFamili) {
                return const Scaffold(
                  body: FailureState(
                    textMessage: "An error Occured",
                  ),
                );
              } else if (state is GetDetailFamiliSuccess &&
                  genusState is GetGenusDataSuccess) {
                final FamilyDetail? data = state.result.data;
                final List<GenusData> genusData = genusState.result.data;
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
                                                          AddDataGenusScreen(
                                                            isEdit: false,
                                                            idFamili:
                                                                data!.idFamili,
                                                          )));
                                            },
                                            text: "Add Genus Data"),
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
                                                          AddFamili(
                                                            idFamili:
                                                                data!.idFamili,
                                                            idOrdo: data.idOrdo,
                                                            latinName:
                                                                data.latinName,
                                                            commonName:
                                                                data.commonName,
                                                            character: data
                                                                .characteristics,
                                                            description: data
                                                                .description,
                                                            image: data.image,
                                                            isEdit: true,
                                                          )));
                                            },
                                            text: "Edit this Family"),
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
                                                        _familiBloc.add(
                                                            DeleteFamiliEvent(
                                                                idFamili: data!
                                                                    .idFamili));
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
                          '$baseUrl/image/${data!.image}',
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
                                    ? const EdgeInsets.only(bottom: 50, top: 40)
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
                                      ReadMoreCustom(text: data.description),
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
                                      ReadMoreCustom(
                                          text: data.characteristics),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Genus from this class",
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
                                                          GenusScreen(
                                                            isByFamili: true,
                                                            idFamili:
                                                                data.idFamili,
                                                            appBarText:
                                                                "Genus Of ${data.commonName}",
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
                                                  0.3
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: genusData.isEmpty
                                              ? const Center(
                                                  child: EmptyData(
                                                      textMessage:
                                                          "Sorry, no available data. Please wait for updates."),
                                                )
                                              : ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: genusData.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    GenusData? dataAnimal;
                                                    GenusData? dataAnimalDua;
                                                    if (index % 2 == 0 &&
                                                        index + 1 <
                                                            genusData.length) {
                                                      dataAnimal =
                                                          genusData[index];
                                                      dataAnimalDua =
                                                          genusData[index + 1];
                                                    } else if (genusData
                                                            .length >=
                                                        2) {
                                                      if (index ==
                                                          genusData.length -
                                                              2) {
                                                        dataAnimal = genusData[
                                                            index + 1];
                                                      }
                                                    } else {
                                                      dataAnimal =
                                                          genusData[index];
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
                                                                                DetailGenusScreen(idGenus: dataAnimal!.idGenus)));
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
                                                                        builder:
                                                                            (context) =>
                                                                                DetailGenusScreen(idGenus: dataAnimalDua!.idGenus)));
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
                                    data.commonName,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    data.latinName,
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
