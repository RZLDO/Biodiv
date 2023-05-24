import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';

import 'package:biodiv/repository/verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/card_view.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class FamiliUnverif extends StatefulWidget {
  const FamiliUnverif({super.key});

  @override
  State<FamiliUnverif> createState() => _FamiliUnverifState();
}

class _FamiliUnverifState extends State<FamiliUnverif> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifFamili());
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
              } else if (state is GetUnverifiedFamili) {
                List<Family> data = state.result.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
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
                                    namaUmum: dataAnimal.commonName,
                                    namaLatin: dataAnimal.latinName,
                                    image:
                                        "$baseUrl/image/${dataAnimal.image}"),
                              )),
                            if (dataAnimalDua != null)
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {},
                                child: CustomCard(
                                    namaUmum: dataAnimalDua.commonName,
                                    namaLatin: dataAnimalDua.latinName,
                                    image:
                                        "$baseUrl/image/${dataAnimalDua.image}"),
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
