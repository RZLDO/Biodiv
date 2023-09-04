import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/ui/ordo%20page/add_ordo.dart';
import 'package:biodiv/ui/ordo%20page/ordo_detail.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/card_view.dart';
import '../../utils/constant.dart';

class OrdoScreen extends StatefulWidget {
  final bool isByClass;
  final int? idClass;
  final String appBarText;
  const OrdoScreen(
      {super.key,
      this.isByClass = false,
      this.idClass,
      this.appBarText = "Ordo Data"});

  @override
  State<OrdoScreen> createState() => _OrdoScreenState();
}

class _OrdoScreenState extends State<OrdoScreen> {
  late OrdoBloc ordoBloc;
  bool? isFabVisible;
  @override
  void initState() {
    super.initState();
    ordoBloc = OrdoBloc(repository: OrdoRepository());
    if (widget.isByClass) {
      if (widget.idClass != null) {
        ordoBloc.add(GetOrdoByClassEvent(idClass: widget.idClass!, page: 0));
      }
    } else {
      ordoBloc.add(GetOrdoData());
    }
    getUserLevel();
  }

  void getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? level = preferences.getInt("UserLevel");
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
                          builder: (context) => const AddOrdoScreen(
                                isEdit: false,
                              )));
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
            create: (context) => ordoBloc,
            child: BlocBuilder<OrdoBloc, OrdoState>(
                bloc: ordoBloc,
                builder: (context, state) {
                  if (state is FailureOrdo) {
                    return const Center(
                        child: FailureState(textMessage: "an error occured"));
                  } else if (state is Success) {
                    List<OrdoData> ordoData = state.response.data;
                    return ListView.builder(
                        itemCount: ordoData.length,
                        itemBuilder: (BuildContext context, int index) {
                          OrdoData? dataAnimal;
                          OrdoData? dataAnimalDua;

                          if (index % 2 == 0 && index + 1 < ordoData.length) {
                            dataAnimal = ordoData[index];
                            dataAnimalDua = ordoData[index + 1];
                          } else if (ordoData.length >= 2) {
                            if (index == ordoData.length - 2) {
                              dataAnimal = ordoData[index + 1];
                            }
                          } else {
                            dataAnimal = ordoData[index];
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
                                            builder: (context) => OrdoDetail(
                                                idOrdo: dataAnimal!.idOrdo)));
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
                                            builder: (context) => OrdoDetail(
                                                idOrdo:
                                                    dataAnimalDua!.idOrdo)));
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
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  }
                })));
  }
}
