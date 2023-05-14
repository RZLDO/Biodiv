import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/model/get_ordo_model.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/card_view.dart';
import '../../utils/constant.dart';

class OrdoScreen extends StatefulWidget {
  const OrdoScreen({super.key});

  @override
  State<OrdoScreen> createState() => _OrdoScreenState();
}

class _OrdoScreenState extends State<OrdoScreen> {
  late OrdoBloc ordoBloc;
  @override
  void initState() {
    super.initState();
    ordoBloc = OrdoBloc(repository: OrdoRepository());
    ordoBloc.add(GetOrdoData());
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
        appBar: const CustomAppBar(text: "text"),
        body: BlocProvider(
            create: (context) => ordoBloc,
            child: BlocBuilder<OrdoBloc, OrdoState>(
                bloc: ordoBloc,
                builder: (context, state) {
                  if (state is OrdoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  } else if (state is Success) {
                    List<OrdoData> data = state.response.data;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          OrdoData? dataAnimal;
                          OrdoData? dataAnimalDua;
                          if (index % 2 == 0 && index + 1 < data.length) {
                            dataAnimal = data[index];
                            dataAnimalDua = data[index + 1];
                          } else if (data.length > 2) {
                            if (index == data.length - 1) {
                              dataAnimal = data[index];
                            }
                          }
                          return Row(
                            children: [
                              if (dataAnimal != null)
                                Expanded(
                                    child: CustomCard(
                                        namaUmum: dataAnimal.namaUmum,
                                        namaLatin: dataAnimal.namaLatin,
                                        image:
                                            "$baseUrl/image/${dataAnimal.gambar}")),
                              if (dataAnimalDua != null)
                                Expanded(
                                    child: CustomCard(
                                        namaUmum: dataAnimalDua.namaUmum,
                                        namaLatin: dataAnimalDua.namaLatin,
                                        image:
                                            "$baseUrl/image/${dataAnimalDua.gambar}"))
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
