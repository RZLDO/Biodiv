import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/BloC/home/home_bloc.dart';
import 'package:biodiv/model/get_class_model.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/card_view.dart';
import '../../utils/custom_app_bar.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  late ClassBloc _classBloc;
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _classBloc.add(GetDataClassEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const CustomAppBar(text: "TEXT"),
        body: BlocProvider(
          create: (context) => _classBloc,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<ClassBloc, ClassState>(
              bloc: _classBloc,
              builder: (context, state) {
                if (state is ClassLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  );
                } else if (state is GetDataSuccess) {
                  List<ClassData> data = state.dataClass;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        ClassData? dataAnimal;
                        ClassData? dataAnimalDua;
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
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
