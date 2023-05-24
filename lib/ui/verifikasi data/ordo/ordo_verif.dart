import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/model/ordo%20model/detail_ordo_model.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/card_view.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class OrdoUnverif extends StatefulWidget {
  const OrdoUnverif({super.key});

  @override
  State<OrdoUnverif> createState() => _OrdoUnverifState();
}

class _OrdoUnverifState extends State<OrdoUnverif> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifOrdo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _verifBloc,
        child: BlocBuilder<VerifBloc, VerifState>(
            bloc: _verifBloc,
            builder: (context, state) {
              if (state is VerifLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is GetUnverifiedOrdoSuccess) {
                List<OrdoData> data = state.result.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrdoData? dataAnimal;
                        OrdoData? dataAnimalDua;
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
                                onTap: () {},
                                child: CustomCard(
                                    namaUmum: dataAnimal.namaUmum,
                                    namaLatin: dataAnimal.namaLatin,
                                    image:
                                        "$baseUrl/image/${dataAnimal.gambar}"),
                              )),
                            if (dataAnimalDua != null)
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {},
                                child: CustomCard(
                                    namaUmum: dataAnimalDua.namaUmum,
                                    namaLatin: dataAnimalDua.namaLatin,
                                    image:
                                        "$baseUrl/image/${dataAnimalDua.gambar}"),
                              ))
                          ],
                        );
                      }),
                );
              } else {
                return const Center(
                  child: Text("an error occured"),
                );
              }
            }),
      ),
    );
  }
}
