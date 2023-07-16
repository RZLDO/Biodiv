import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/genus/genus_bloc.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/ui/genus/add_data_genus.dart';
import 'package:biodiv/ui/species/detail_species.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../BloC/spesies/spesies_bloc.dart';
import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_button.dart';
import '../../utils/state_screen.dart';
import '../class page/class_detail_page.dart';
import '../navigation/curved_navigation_bar.dart';
import '../species/species.dart';

class DetailGenusScreen extends StatefulWidget {
  final int idGenus;
  const DetailGenusScreen({super.key, required this.idGenus});

  @override
  State<DetailGenusScreen> createState() => _DetailGenusScreenState();
}

class _DetailGenusScreenState extends State<DetailGenusScreen> {
  late GenusBloc _genusBloc;
  late SpesiesBloc _spesiesBloc;
  bool? isUserCanEdit;
  @override
  void initState() {
    super.initState();
    _genusBloc = GenusBloc(repository: GenusRepository());
    _genusBloc.add(GetDetailGenusEvent(idGenus: widget.idGenus));
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    _spesiesBloc.add(GetSpesiesByGenus(idGenus: widget.idGenus, page: 5));
    getUserPreference();
  }

  void getUserPreference() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final level = preferences.getInt("UserLevel");
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
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // appBar: const CustomAppBar(text: ""),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _genusBloc),
            BlocProvider(create: (context) => _spesiesBloc)
          ],
          child: BlocBuilder<SpesiesBloc, SpesiesState>(
            builder: (context, spesiesState) {
              return BlocBuilder<GenusBloc, GenusState>(
                builder: (context, state) {
                  if (spesiesState is SpesiesFailure) {
                    return Center(
                      child: FailureState(
                        textMessage: spesiesState.errorMessage,
                      ),
                    );
                  } else if (state is GetGenusDetailDataSuccess &&
                      spesiesState is GetSpesiciesSuccess) {
                    final GenusData? data = state.result.data;
                    final List<SpeciesData> spesiesData =
                        spesiesState.result.data;
                    return SizedBox(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
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
                                      ? const EdgeInsets.only(
                                          bottom: 50, top: 40)
                                      : const EdgeInsets.only(top: 40),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            SpeciesScreen(
                                                              idGenus:
                                                                  data.idGenus,
                                                              isByGenus: true,
                                                              appBarText:
                                                                  "Spesies Of ${data.namaUmum}",
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: spesiesData.isEmpty
                                                ? const Center(
                                                    child: EmptyData(
                                                        textMessage: ""),
                                                  )
                                                : ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount:
                                                        spesiesData.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      SpeciesData? dataAnimal;
                                                      SpeciesData?
                                                          dataAnimalDua;
                                                      if (index % 2 == 0 &&
                                                          index + 1 <
                                                              spesiesData
                                                                  .length) {
                                                        dataAnimal =
                                                            spesiesData[index];
                                                        dataAnimalDua =
                                                            spesiesData[
                                                                index + 1];
                                                      } else if (spesiesData
                                                              .length >=
                                                          2) {
                                                        if (index ==
                                                            spesiesData.length -
                                                                2) {
                                                          dataAnimal =
                                                              spesiesData[
                                                                  index + 1];
                                                        }
                                                      } else {
                                                        dataAnimal =
                                                            spesiesData[index];
                                                      }
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                                          builder: (context) => DetailSpesiesScreen(
                                                                              idKelangkaan: dataAnimal!.idKategori,
                                                                              idSpesies: dataAnimal.idSpesies)));
                                                                },
                                                                child: CustomCard(
                                                                    textSize:
                                                                        16,
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
                                                                          builder: (context) => DetailSpesiesScreen(
                                                                                idSpesies: dataAnimalDua!.idSpesies,
                                                                                idKelangkaan: dataAnimalDua.idKategori,
                                                                              )));
                                                                },
                                                                child: CustomCard(
                                                                    textSize:
                                                                        16,
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
                                padding: const EdgeInsets.all(20),
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
                          Positioned(
                              bottom: 20,
                              child: Visibility(
                                visible: isUserCanEdit!,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                                        AddDataGenusScreen(
                                                          idFamili:
                                                              data.idFamili,
                                                          idGenus: data.idGenus,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          setText: false),
                                      const Spacer(),
                                      CustomButtonExtended(
                                          color: AppColor.redColorAccent,
                                          icon: Icons.delete,
                                          onTap: () {
                                            AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.warning,
                                                    autoDismiss: false,
                                                    onDismissCallback: (type) {
                                                      Navigator.pop(context);
                                                    },
                                                    btnOkOnPress: () {
                                                      _genusBloc.add(
                                                          DeleteGenusEvent(
                                                              idGenus: data
                                                                  .idGenus));
                                                      AwesomeDialog(
                                                              context: context,
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
                                                              btnOkOnPress: () {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          setText: true),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ));
  }
}
