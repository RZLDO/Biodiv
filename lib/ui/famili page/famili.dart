import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/model/famili%20model/famili_model.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/card_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/custom_app_bar.dart';

class FamiliScreen extends StatefulWidget {
  const FamiliScreen({super.key});

  @override
  State<FamiliScreen> createState() => _FamiliScreenState();
}

class _FamiliScreenState extends State<FamiliScreen> {
  late FamiliBloc _familiBloc;
  @override
  void initState() {
    super.initState();
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    _familiBloc.add(GetFamiliEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.secondaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
        appBar: const CustomAppBar(text: ""),
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
                        });
                  } else {
                    return const Center(
                      child: Text('An error Occured'),
                    );
                  }
                })));
  }
}
