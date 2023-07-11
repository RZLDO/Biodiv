import 'package:biodiv/BloC/spesies/spesies_bloc.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/ui/species/add_spesies.dart';
import 'package:biodiv/ui/species/detail_species.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/spesies/get_spesies_data.dart';
import '../../utils/card_view.dart';
import '../../utils/constant.dart';

class SpeciesScreen extends StatefulWidget {
  final bool isByGenus;
  final int? idGenus;
  final String appBarText;
  const SpeciesScreen(
      {super.key,
      this.idGenus,
      this.isByGenus = false,
      this.appBarText = "Spesies Data"});

  @override
  State<SpeciesScreen> createState() => _SpeciesScreenState();
}

class _SpeciesScreenState extends State<SpeciesScreen> {
  late SpesiesBloc _spesiesBloc;
  @override
  void initState() {
    super.initState();
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    _spesiesBloc.add(GetSpesiesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: widget.appBarText),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddSpesiesScreen( 
                        isEdit: false,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider(
        create: (context) => _spesiesBloc,
        child: BlocBuilder<SpesiesBloc, SpesiesState>(
            bloc: _spesiesBloc,
            builder: (context, state) {
              if (state is SpesiesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is GetSpesiciesSuccess) {
                List<SpeciesData> data = state.result.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      SpeciesData? dataAnimal;
                      SpeciesData? dataAnimalDua;
                      if (index % 2 == 0 && index + 1 < data.length) {
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
                                              idSpesies: dataAnimal!.idSpesies,
                                            )));
                              },
                              child: CustomCard(
                                  namaUmum: dataAnimal.namaUmum,
                                  namaLatin: dataAnimal.namaLatin,
                                  image: "$baseUrl/image/${dataAnimal.gambar}"),
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
                                                  dataAnimalDua!.idSpesies,
                                            )));
                              },
                              child: CustomCard(
                                  namaUmum: dataAnimalDua.namaUmum,
                                  namaLatin: dataAnimalDua.namaLatin,
                                  image:
                                      "$baseUrl/image/${dataAnimalDua.gambar}"),
                            ))
                        ],
                      );
                    });
              } else {
                return const Center(
                  child: FailureState(textMessage: "Oops, something error"),
                );
              }
            }),
      ),
    );
  }
}
