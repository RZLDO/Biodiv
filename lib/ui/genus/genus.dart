import 'package:biodiv/BloC/genus/genus_bloc.dart';
import 'package:biodiv/model/genus/get_data_genus.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:biodiv/ui/genus/add_data_genus.dart';
import 'package:biodiv/ui/genus/detail_genus.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_app_bar.dart';

class GenusScreen extends StatefulWidget {
  final bool isByFamili;
  final int? idFamili;
  const GenusScreen({super.key, this.idFamili, this.isByFamili = false});

  @override
  State<GenusScreen> createState() => _GenusScreen();
}

class _GenusScreen extends State<GenusScreen> {
  late GenusBloc _genusBloc;
  bool? isFabVisible;
  @override
  void initState() {
    super.initState();
    _genusBloc = GenusBloc(repository: GenusRepository());
    _genusBloc.add(GetDataGenusEvent());
    getUserPreference();
  }

  void getUserPreference() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final level = preferences.getInt("UserLevel");
    if (level == 3) {
      setState(() {
        isFabVisible = false;
      });
    } else {
      setState(() {
        isFabVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: isFabVisible != null && isFabVisible!
            ? FloatingActionButton(
                backgroundColor: AppColor.secondaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddDataGenusScreen(isEdit: false)));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        backgroundColor: AppColor.backgroundColor,
        appBar: const CustomAppBar(text: ""),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
              create: (context) => _genusBloc,
              child: BlocBuilder<GenusBloc, GenusState>(
                  bloc: _genusBloc,
                  builder: (context, state) {
                    if (state is GenusLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.mainColor,
                        ),
                      );
                    } else if (state is GetGenusDataSuccess) {
                      List<GenusData> data = state.result.data;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            GenusData? dataAnimal;
                            GenusData? dataAnimalDua;
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
                                                  DetailGenusScreen(
                                                      idGenus: dataAnimal!
                                                          .idGenus)));
                                    },
                                    child: CustomCard(
                                        namaUmum: dataAnimal.namaUmum,
                                        namaLatin: dataAnimal.namaLatin,
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
                                                  DetailGenusScreen(
                                                      idGenus: dataAnimalDua!
                                                          .idGenus)));
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
                        child:
                            FailureState(textMessage: "Oops, Something Error"),
                      );
                    }
                  })),
        ));
  }
}
