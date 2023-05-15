import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailClass extends StatefulWidget {
  final String idClass;
  const DetailClass({super.key, required this.idClass});

  @override
  State<DetailClass> createState() => _DetailClassState();
}

class _DetailClassState extends State<DetailClass> {
  late ClassBloc _classBloc;
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _classBloc.add(GetDetailClass(idClass: widget.idClass));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const CustomAppBar(text: ""),
        body: BlocProvider<ClassBloc>(
          create: (context) => _classBloc,
          child: BlocBuilder<ClassBloc, ClassState>(
            builder: (context, state) {
              if (state is ClassLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is DetailSuccess) {
                return Container();
              } else {
                return const Center(
                  child: Text("an error occured"),
                );
              }
            },
          ),
        ));
  }
}
