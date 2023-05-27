import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../navigation/curved_navigation_bar.dart';

class AddDataClass extends StatefulWidget {
  final int? idClass;
  final String? common;
  final String? latin;
  final String? chara;
  final String? desc;
  final String? image;
  final bool isEdit;
  const AddDataClass(
      {super.key,
      this.idClass = 0,
      this.common,
      this.latin,
      this.chara,
      this.desc,
      this.image,
      required this.isEdit});

  @override
  State<AddDataClass> createState() => _AddDataClassState();
}

class _AddDataClassState extends State<AddDataClass> {
  TextEditingController latinName = TextEditingController();
  TextEditingController commonName = TextEditingController();
  TextEditingController characteristics = TextEditingController();
  TextEditingController description = TextEditingController();
  XFile? _imagePicker;
  XFile? image;
  final ClassBloc _classBloc = ClassBloc(repository: ClassRepository());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    latinName = TextEditingController(text: widget.latin);
    commonName = TextEditingController(text: widget.common);
    characteristics = TextEditingController(text: widget.chara);
    description = TextEditingController(text: widget.desc);
    if (widget.isEdit) {
      getImageFileFromNetwork(widget.image.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          text: widget.isEdit ? "Edit Data Class" : "Add Data Class",
        ),
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
                      child: image != null
                          ? Image.file(File(image!.path))
                          : _imagePicker == null
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
                  if (widget.isEdit) {
                    return CustomButton(
                        text: state is ClassLoading ? "Loading" : "Edit Data",
                        onTap: () {
                          _classBloc.add(EditClass(
                              idClass: widget.idClass.toString(),
                              commonName: commonName.text,
                              latinName: latinName.text,
                              characteristics: characteristics.text,
                              description: description.text,
                              image: _imagePicker));
                        });
                  } else {
                    return CustomButton(
                        text: state is ClassLoading ? "Loading" : "Add Data",
                        onTap: () {
                          if (_key.currentState!.validate() &&
                              _imagePicker != null) {
                            _classBloc.add(
                              PostDataClass(
                                  latinName: latinName.text,
                                  commonName: commonName.text,
                                  characteristics: characteristics.text,
                                  description: description.text,
                                  image: _imagePicker),
                            );
                          }
                        });
                  }
                }, listener: (context, state) {
                  if (state is AddDataSuccess) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        autoDismiss: false,
                        title: "Add Data Success",
                        body: const Text(
                          "Silahkan tunggu Admin untuk memverivikasi data",
                        ),
                        onDismissCallback: (type) => Navigator.pop(context),
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Navigation(pageId: 0)));
                        }).show();
                  } else if (state is EditSuccess) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        autoDismiss: false,
                        title: "EditData Success",
                        onDismissCallback: (type) => Navigator.pop(context),
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Navigation(pageId: 0)));
                        }).show();
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
      image = null;
    });
  }

  Future getImageFileFromNetwork(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/image/$imageUrl'));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/$imageUrl');

        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _imagePicker = XFile(file.path);
        });
      } else {
        throw Exception('Failed to download image');
      }
    } catch (error) {
      throw Exception('Error converting image URL to file: $error');
    }
  }
}
