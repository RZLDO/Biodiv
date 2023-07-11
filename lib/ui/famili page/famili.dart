import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:biodiv/ui/famili%20page/add_famili.dart';
import 'package:biodiv/ui/famili%20page/famili_detail.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_app_bar.dart';

class FamiliScreen extends StatefulWidget {
  final bool isByOrdo;
  final int? idOrdo;
  final String appBarText;
  const FamiliScreen(
      {super.key,
      this.isByOrdo = false,
      this.idOrdo,
      this.appBarText = "Famili Data"});

  @override
  State<FamiliScreen> createState() => _FamiliScreenState();
}

class _FamiliScreenState extends State<FamiliScreen> {
  late FamiliBloc _familiBloc;
  bool? isFabVisible;
  @override
  void initState() {
    super.initState();
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    if (widget.isByOrdo) {
      if (widget.idOrdo != null) {
        _familiBloc.add(GetFamiliByOrdo(idOrdo: widget.idOrdo!, page: 0));
      }
    } else {
      _familiBloc.add(GetFamiliEvent());
    }
    getUserPreference();
  }

  void getUserPreference() async {
    final SharedPreferences userPreference =
        await SharedPreferences.getInstance();

    final userLevel = userPreference.getInt("UserLevel");
    if (userLevel == 3) {
      isFabVisible = false;
    } else {
      isFabVisible = true;
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
                              const AddFamili(isEdit: false)));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        backgroundColor: AppColor.backgroundColor,
        appBar: CustomAppBar(text: widget.appBarText),
        body: BlocProvider(
            create: (context) => _familiBloc,
            child: BlocBuilder<FamiliBloc, FamiliState>(
                bloc: _familiBloc,
                builder: (context, state) {
                  if (state is FamiliLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  } else if (state is GetDataFamiliSuccess) {
                    List<Family> data = state.result.data;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Family? dataAnimal;
                          Family? dataAnimalDua;
                          if (index % 2 == 0 && index + 1 < data.length) {
                            dataAnimal = data[index];
                            dataAnimalDua = data[index + 1];
                          } else if (data.length >= 2) {
                            if (index == data.length - 2) {
                              dataAnimal = data[index + 1];
                            }
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
                                            builder: (context) => DetailFamili(
                                                idFamili:
                                                    dataAnimal!.idFamili)));
                                  },
                                  child: CustomCard(
                                      namaUmum: dataAnimal.commonName,
                                      namaLatin: dataAnimal.latinName,
                                      image:
                                          "$baseUrl/image/${dataAnimal.image}"),
                                )),
                              if (dataAnimalDua != null)
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailFamili(
                                                idFamili:
                                                    dataAnimalDua!.idFamili)));
                                  },
                                  child: CustomCard(
                                      namaUmum: dataAnimalDua.commonName,
                                      namaLatin: dataAnimalDua.latinName,
                                      image:
                                          "$baseUrl/image/${dataAnimalDua.image}"),
                                ))
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: FailureState(
                          textMessage: "Oops, Something error happen"),
                    );
                  }
                })));
  }
}
