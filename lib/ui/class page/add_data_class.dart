import 'dart:io';

import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/ui/home/home_screen.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddDataClass extends StatefulWidget {
  const AddDataClass({super.key});

  @override
  State<AddDataClass> createState() => _AddDataClassState();
}

class _AddDataClassState extends State<AddDataClass> {
  final latinName = TextEditingController();
  final commonName = TextEditingController();
  final characteristics = TextEditingController();
  final description = TextEditingController();
  XFile? _imagePicker;
  final ClassBloc _classBloc = ClassBloc(repository: ClassRepository());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(text: "Add Class Data"),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocProvider<ClassBloc>(
            create: (context) => _classBloc,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    getImage();
                  },
                  child: Card(
                    elevation: 4,
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: _imagePicker == null
                          ? Icon(
                              Icons.image_search,
                              size: 100,
                              color: Colors.black45.withOpacity(0.5),
                            )
                          : Image.file(
                              File(_imagePicker!.path),
                            ),
                    ),
                  ),
                ),
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                            hintText: "Latin Name",
                            controller: latinName,
                            validator: Validator.basicValidate,
                            obsecure: false),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                            hintText: "Common Name",
                            controller: commonName,
                            validator: Validator.basicValidate,
                            obsecure: false),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                            hintText: "Characteristics",
                            controller: characteristics,
                            validator: Validator.basicValidate,
                            obsecure: false),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                            hintText: "Description",
                            controller: description,
                            validator: Validator.basicValidate,
                            obsecure: false),
                      ],
                    )),
                const SizedBox(
                  height: 24,
                ),
                BlocConsumer<ClassBloc, ClassState>(builder: (context, state) {
                  return CustomButton(
                      text: state is ClassLoading ? "Loading" : "Add Data",
                      onTap: () {
                        _classBloc.add(
                          PostDataClass(
                              latinName: latinName.text,
                              commonName: commonName.text,
                              characteristics: characteristics.text,
                              description: description.text,
                              image: _imagePicker),
                        );
                      });
                }, listener: (context, state) {
                  if (state is AddDataSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } else if (state is Failure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColor.mainColor,
                      content: Text(state.errorMessage),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                })
              ],
            ),
          ),
        ));
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePicker = imagePicked;
    });
  }
}
