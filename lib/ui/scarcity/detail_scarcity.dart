import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/ui/species/detail_species.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BloC/scarcity/scarcity_bloc.dart';
import '../../BloC/spesies/spesies_bloc.dart';
import '../../utils/card_view.dart';
import '../../utils/constant.dart';

class ScarcityDetailScreen extends StatefulWidget {
  final int idScarcity;
  const ScarcityDetailScreen({super.key, required this.idScarcity});

  @override
  State<ScarcityDetailScreen> createState() => _ScarcityDetailScreenState();
}

class _ScarcityDetailScreenState extends State<ScarcityDetailScreen> {
  late ScarcityBloc _scarcityBloc;
  late SpesiesBloc _spesiesBloc;
  @override
  void initState() {
    _scarcityBloc = ScarcityBloc(repository: ScarcityRepository());
    _scarcityBloc.add(GetScarcityById(idScarcity: widget.idScarcity));
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    _spesiesBloc.add(GetSpesiesByScarcity(idScarcity: widget.idScarcity));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: "",
        color: Colors.white,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _scarcityBloc),
          BlocProvider(create: (context) => _spesiesBloc)
        ],
        child: BlocBuilder<SpesiesBloc, SpesiesState>(
          bloc: _spesiesBloc,
          builder: (context, spesiesState) {
            return BlocBuilder<ScarcityBloc, ScarcityState>(
                builder: (context, scarcityState) {
              if (spesiesState is SpesiesFailure) {
                return Center(
                  child: FailureState(textMessage: spesiesState.errorMessage),
                );
              } else if (spesiesState is GetSpesiciesSuccess &&
                  scarcityState is GetDetailScarcityByIdState) {
                final DetailScarcityData? scarcityData =
                    scarcityState.result.data;
                final List<SpeciesData> data = spesiesState.result.data;
                return SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ${scarcityData!.nama} ?",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: AppColor.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text:
                                '\t \t \t ${scarcityData.keterangan}', // Ganti dengan teks yang ingin Anda tampilkan
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.black87)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "spesies included from this category:",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: AppColor.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: AppColor.secondaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      data.isEmpty
                          ? const Expanded(
                              child: Center(
                                child: EmptyData(
                                    textMessage:
                                        "Sorry, no available data. Please wait for updates."),
                              ),
                            )
                          : Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      SpeciesData? dataAnimal;
                                      SpeciesData? dataAnimalDua;
                                      if (index % 2 == 0 &&
                                          index + 1 < data.length) {
                                        dataAnimal = data[index];
                                        dataAnimalDua = data[index + 1];
                                      } else if (data.length >= 2) {
                                        if (index == data.length - 2) {
                                          dataAnimal = data[index + 1];
                                        }
                                      } else {
                                        dataAnimal = data[index];
                                      }
                                      return Row(
                                        children: [
                                          if (dataAnimal != null)
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailSpesiesScreen(
                                                                idSpesies:
                                                                    dataAnimal!
                                                                        .idSpesies,
                                                                idKelangkaan:
                                                                    dataAnimal
                                                                        .idKategori)));
                                              },
                                              child: CustomCard(
                                                  namaUmum: dataAnimal.namaUmum,
                                                  namaLatin:
                                                      dataAnimal.namaLatin,
                                                  image:
                                                      "$baseUrl/image/${dataAnimal.gambar}"),
                                            )),
                                          if (dataAnimalDua != null)
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailSpesiesScreen(
                                                                idSpesies:
                                                                    dataAnimalDua!
                                                                        .idSpesies,
                                                                idKelangkaan:
                                                                    dataAnimalDua
                                                                        .idKategori)));
                                              },
                                              child: CustomCard(
                                                  namaUmum:
                                                      dataAnimalDua.namaUmum,
                                                  namaLatin:
                                                      dataAnimalDua.namaLatin,
                                                  image:
                                                      "$baseUrl/image/${dataAnimalDua.gambar}"),
                                            ))
                                        ],
                                      );
                                    }),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ));
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
