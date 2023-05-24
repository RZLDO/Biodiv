import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/model/Class%20Model/get_class_model.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/card_view.dart';
import '../../../utils/constant.dart';

class UnverifiedClassScreen extends StatefulWidget {
  const UnverifiedClassScreen({super.key});

  @override
  State<UnverifiedClassScreen> createState() => _UnverifiedClassScreenState();
}

class _UnverifiedClassScreenState extends State<UnverifiedClassScreen> {
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifClass());
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
              } else if (state is GetUnverifiedClassSuccess) {
                List<ClassData> data = state.result.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        ClassData? dataAnimal;
                        ClassData? dataAnimalDua;
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
