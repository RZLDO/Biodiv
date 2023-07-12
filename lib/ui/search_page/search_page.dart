import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/search%20model/search_model.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';
import 'package:biodiv/repository/search_repository.dart';
import 'package:biodiv/ui/class%20page/class_detail_page.dart';
import 'package:biodiv/ui/famili%20page/famili_detail.dart';
import 'package:biodiv/ui/genus/detail_genus.dart';
import 'package:biodiv/ui/ordo%20page/ordo_detail.dart';
import 'package:biodiv/ui/species/detail_species.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BloC/searching/search_bloc.dart';
import '../../utils/card_view.dart';
import '../../utils/constant.dart';
import '../../utils/text_style.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  late SearchBloc _searchBloc;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final searchTextEditingController = TextEditingController();
  final List<String> titleText = [
    "Class",
    "Ordo",
    "Famili",
    "Genus",
    "Spesies"
  ];
  @override
  void initState() {
    _searchBloc = SearchBloc(repository: SearchingRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: AppColor.secondaryColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "BIODIV-INFORMATICS",
            style: ReusableTextStyle.basicWhiteBold,
          ),
        ),
        body: BlocProvider(
            create: (context) => _searchBloc,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35)),
                      color: AppColor.secondaryColor),
                  child: TextFormField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: AppColor.mainColor,
                        ),
                        onPressed: () {
                          searchTextEditingController.clear();
                        },
                      ),
                    ),
                    onEditingComplete: () => {
                      _searchBloc.add(GetSearchEvent(
                          query: searchTextEditingController.text))
                    },
                  ),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                    bloc: _searchBloc,
                    builder: (context, state) {
                      if (state is SearchResultStateFailure) {
                        return const Expanded(
                          child: Center(
                            child:
                                FailureState(textMessage: "An error occured"),
                          ),
                        );
                      } else if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.mainColor,
                          ),
                        );
                      } else if (state is SearchResultStateSuccess) {
                        final SearchResult? data = state.result.data;
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Search Result For ${searchTextEditingController.text}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.secondaryColor),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.secondaryColor),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Visibility(
                                          visible: data!.dataClass.isEmpty
                                              ? false
                                              : true,
                                          child: SizedBox(
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Class",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .secondaryColor),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: data
                                                            .dataClass.length,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          ClassData?
                                                              animalData =
                                                              data.dataClass[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DetailClass(
                                                                          idClass: animalData
                                                                              .idClass
                                                                              .toString(),
                                                                          idClassGet:
                                                                              animalData.idClass)));
                                                            },
                                                            child: SearchingCard(
                                                                height: 70,
                                                                namaUmum:
                                                                    animalData
                                                                        .namaUmum,
                                                                namaLatin:
                                                                    animalData
                                                                        .namaLatin,
                                                                image:
                                                                    '$baseUrl/image/${animalData.gambar}'),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          )),
                                      Visibility(
                                          visible: data.dataOrdo.isEmpty
                                              ? false
                                              : true,
                                          child: SizedBox(
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ordo",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .secondaryColor),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: data
                                                            .dataOrdo.length,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          OrdoData? animalData =
                                                              data.dataOrdo[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          OrdoDetail(
                                                                              idOrdo: animalData.idOrdo)));
                                                            },
                                                            child: SearchingCard(
                                                                height: 100,
                                                                namaUmum:
                                                                    animalData
                                                                        .namaUmum,
                                                                namaLatin:
                                                                    animalData
                                                                        .namaLatin,
                                                                image:
                                                                    '$baseUrl/image/${animalData.gambar}'),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          )),
                                      Visibility(
                                          visible: data.dataFamili.isEmpty
                                              ? false
                                              : true,
                                          child: SizedBox(
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Famili",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .secondaryColor),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: data
                                                            .dataFamili.length,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          Family? animalData =
                                                              data.dataFamili[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          DetailFamili(
                                                                              idFamili: animalData.idFamili)));
                                                            },
                                                            child: SearchingCard(
                                                                height: 100,
                                                                namaUmum: animalData
                                                                    .commonName,
                                                                namaLatin:
                                                                    animalData
                                                                        .latinName,
                                                                image:
                                                                    '$baseUrl/image/${animalData.image}'),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          )),
                                      Visibility(
                                          visible: data.dataGenus.isEmpty
                                              ? false
                                              : true,
                                          child: SizedBox(
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Genus",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .secondaryColor),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: data
                                                            .dataOrdo.length,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          GenusData?
                                                              animalData =
                                                              data.dataGenus[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          DetailGenusScreen(
                                                                              idGenus: animalData.idGenus)));
                                                            },
                                                            child: SearchingCard(
                                                                height: 100,
                                                                namaUmum:
                                                                    animalData
                                                                        .namaUmum,
                                                                namaLatin:
                                                                    animalData
                                                                        .namaLatin,
                                                                image:
                                                                    '$baseUrl/image/${animalData.gambar}'),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          )),
                                      Visibility(
                                          visible: data.dataSpesies.isEmpty
                                              ? false
                                              : true,
                                          child: SizedBox(
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Spesies",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .secondaryColor),
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: data
                                                            .dataSpesies.length,
                                                        itemBuilder: (context,
                                                            int index) {
                                                          SpeciesData?
                                                              animalData =
                                                              data.dataSpesies[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DetailSpesiesScreen(
                                                                          idSpesies: animalData
                                                                              .idGenus,
                                                                          idKelangkaan:
                                                                              animalData.idKategori)));
                                                            },
                                                            child: SearchingCard(
                                                                height: 100,
                                                                namaUmum:
                                                                    animalData
                                                                        .namaUmum,
                                                                namaLatin:
                                                                    animalData
                                                                        .namaLatin,
                                                                image:
                                                                    '$baseUrl/image/${animalData.gambar}'),
                                                          );
                                                        })),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                      } else {
                        return Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search_sharp,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Searching Page",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    })
              ],
            )));
  }
}
