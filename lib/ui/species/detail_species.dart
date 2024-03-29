import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/spesies/spesies_bloc.dart';
import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/ui/analisa%20Gis/analisa_gis.dart';
import 'package:biodiv/ui/maps/maps_screen.dart';
import 'package:biodiv/ui/scarcity/detail_scarcity.dart';
import 'package:biodiv/ui/species/add_spesies.dart';
import 'package:biodiv/ui/species/add_spesies_location.dart';
import 'package:biodiv/utils/card_view.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../BloC/scarcity/scarcity_bloc.dart';
import '../class page/class_detail_page.dart';
import '../navigation/curved_navigation_bar.dart';

class DetailSpesiesScreen extends StatefulWidget {
  final int idSpesies;
  final int idKelangkaan;
  const DetailSpesiesScreen(
      {super.key, required this.idSpesies, required this.idKelangkaan});

  @override
  State<DetailSpesiesScreen> createState() => _DetailSpesiesScreenState();
}

class _DetailSpesiesScreenState extends State<DetailSpesiesScreen> {
  bool? isUserCanEdit;
  late SpesiesBloc _spesiesBloc;
  late ScarcityBloc _scarcityBloc;
  @override
  void initState() {
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    _spesiesBloc.add(GetDetailSpecies(idSpesies: widget.idSpesies));
    _scarcityBloc = ScarcityBloc(repository: ScarcityRepository());
    _scarcityBloc.add(GetScarcityById(idScarcity: widget.idKelangkaan));
    getUserPreference();
    super.initState();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _scarcityBloc),
          BlocProvider(create: (context) => _spesiesBloc)
        ],
        child: BlocBuilder<ScarcityBloc, ScarcityState>(
            bloc: _scarcityBloc,
            builder: (context, scarcityState) {
              return BlocBuilder<SpesiesBloc, SpesiesState>(
                  bloc: _spesiesBloc,
                  builder: (context, state) {
                    if (state is SpesiesFailure &&
                        scarcityState is ScarcityFailure) {
                      return Scaffold(
                        body: Center(
                            child: FailureState(
                                textMessage: state.errorMessage.toString())),
                      );
                    } else if (state is GetDetailSpesiciesSuccess &&
                        scarcityState is GetDetailScarcityByIdState) {
                      final Species? data = state.result.data;
                      final DetailScarcityData? scarcityData =
                          scarcityState.result.data;

                      return Scaffold(
                        floatingActionButton:
                            isUserCanEdit != null && isUserCanEdit!
                                ? FloatingActionButton(
                                    backgroundColor: AppColor.secondaryColor,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(30))),
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
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  ItemsAdmin(
                                                      icon: Icons.map,
                                                      ontap: () {
                                                        state.result.lokasi
                                                                .isNotEmpty
                                                            ? Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            GoogleMapsScreen(
                                                                              location: state.result.lokasi,
                                                                              spesies: data!,
                                                                              singkatan: scarcityData!,
                                                                            )))
                                                            : AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .infoReverse,
                                                                title:
                                                                    "Location",
                                                                btnOkOnPress:
                                                                    () {},
                                                                desc:
                                                                    "Sorry, the location of this species hasn't been updated yet.",
                                                              ).show();
                                                      },
                                                      text: "location"),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  ItemsAdmin(
                                                      icon: Icons.analytics,
                                                      ontap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AnalisaGIS(
                                                                          idSpesies:
                                                                              data!.id,
                                                                          idKelangkaan:
                                                                              data.idScarcity,
                                                                        )));
                                                      },
                                                      text: "GIS Analysis"),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  ItemsAdmin(
                                                      icon: Icons.add,
                                                      ontap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddLocationSpesies(
                                                                          idSpesies: state
                                                                              .result
                                                                              .data!
                                                                              .id,
                                                                          spesiesName: state
                                                                              .result
                                                                              .data!
                                                                              .latinName,
                                                                        )));
                                                      },
                                                      text:
                                                          "add this spesies location"),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  ItemsAdmin(
                                                      icon: Icons.edit,
                                                      ontap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddSpesiesScreen(
                                                                          isEdit:
                                                                              true,
                                                                          latinName:
                                                                              data!.latinName,
                                                                          commonName:
                                                                              data.commonName,
                                                                          statusScarcity:
                                                                              data.status,
                                                                          habitat:
                                                                              data.habitat,
                                                                          character:
                                                                              data.characteristics,
                                                                          description:
                                                                              data.description,
                                                                          idSpesies:
                                                                              data.id,
                                                                          image:
                                                                              data.image,
                                                                          idGenus:
                                                                              data.idGenus,
                                                                          idScarcity:
                                                                              data.idScarcity,
                                                                        )));
                                                      },
                                                      text: "Edit Data"),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  ItemsAdmin(
                                                      icon: Icons.delete,
                                                      ontap: () {
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
                                                                  _spesiesBloc.add(
                                                                      DeleteSpesiesEvent(
                                                                          idSpesies:
                                                                              data!.id));
                                                                  AwesomeDialog(
                                                                          context:
                                                                              context,
                                                                          dialogType: DialogType
                                                                              .warning,
                                                                          autoDismiss:
                                                                              false,
                                                                          onDismissCallback:
                                                                              (type) {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          btnOkOnPress:
                                                                              () {
                                                                            Navigator.pushReplacement(context,
                                                                                MaterialPageRoute(builder: (context) => const Navigation(pageId: 0)));
                                                                          },
                                                                          btnCancelOnPress:
                                                                              () {},
                                                                          desc:
                                                                              "Success delete data",
                                                                          title:
                                                                              "Delete Data")
                                                                      .show();
                                                                },
                                                                btnCancelOnPress:
                                                                    () {},
                                                                desc:
                                                                    "Are you sure to delete this data?",
                                                                title:
                                                                    "Delete Data")
                                                            .show();
                                                      },
                                                      text: "Delete Data"),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Icon(Icons.info_outline),
                                  )
                                : FloatingActionButton(
                                    backgroundColor: AppColor.secondaryColor,
                                    onPressed: () {
                                      state.result.lokasi.isNotEmpty
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GoogleMapsScreen(
                                                        location:
                                                            state.result.lokasi,
                                                        spesies: data!,
                                                        singkatan:
                                                            scarcityData!,
                                                      )))
                                          : AwesomeDialog(
                                              context: context,
                                              dialogType:
                                                  DialogType.infoReverse,
                                              title: "Location",
                                              btnOkOnPress: () {},
                                              desc:
                                                  "Sorry, the location of this species hasn't been updated yet.",
                                            ).show();
                                    },
                                    child: const Icon(Icons.map),
                                  ),
                        body: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Image.network(
                                '$baseUrl/image/${data!.image}',
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    child: Container(
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
                                            TextStyling(
                                              title: "Status",
                                              text: data.status,
                                              style: false,
                                              size: 14,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextStyling(
                                              title: "Habitat",
                                              text: data.habitat,
                                              style: false,
                                              size: 14,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Characteristics",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: AppColor
                                                          .secondaryColor)),
                                            ),
                                            ReadMoreCustom(
                                                text: data.characteristics),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Description",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: AppColor
                                                          .secondaryColor)),
                                            ),
                                            ReadMoreCustom(
                                                text: data.description)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.25,
                                  left: 20,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(2, 2),
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.2))
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScarcityDetailScreen(
                                                            idScarcity:
                                                                scarcityData
                                                                    .idKategori)));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: AppColor.secondaryColor
                                                    .withOpacity(0.8)),
                                            child: Center(
                                              child: Text(
                                                scarcityData!.singkatan,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
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
                  });
            }));
  }
}
