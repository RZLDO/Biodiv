import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/BloC/ordo/ordo_bloc.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/repository/image_repository.dart';
import 'package:biodiv/repository/ordo_repository.dart';
import 'package:biodiv/ui/class%20page/add_data_class.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../navigation/curved_navigation_bar.dart';

class AddOrdoScreen extends StatefulWidget {
  final int? idOrdo;
  final String? latinName;
  final String? commonName;
  final String? character;
  final String? description;
  final int? idClass;
  final bool isEdit;
  final String? image;
  const AddOrdoScreen({
    super.key,
    this.character,
    this.commonName,
    this.description,
    this.idClass,
    this.idOrdo,
    this.latinName,
    this.image,
    required this.isEdit,
  });

  @override
  State<AddOrdoScreen> createState() => _AddOrdoScreenState();
}

class _AddOrdoScreenState extends State<AddOrdoScreen> {
  TextEditingController latinName = TextEditingController();
  TextEditingController commonName = TextEditingController();
  TextEditingController characteristics = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController idClass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  XFile? _imagePicker;
  XFile? imagefromUrl;
  late ClassBloc _classBloc;
  late OrdoBloc _ordoBloc;
  int? id;
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _ordoBloc = OrdoBloc(repository: OrdoRepository());
    _classBloc.add(GetIdClass());
    if (widget.isEdit) {
      latinName = TextEditingController(text: widget.latinName);
      commonName = TextEditingController(text: widget.commonName);
      description = TextEditingController(text: widget.description);
      id = widget.idClass;
      characteristics = TextEditingController(text: widget.character);
      getImageFromNetwork(widget.image.toString());
    } else if (widget.idClass != null) {
      id = widget.idClass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomAppBar(text: ""),
      body: MultiProvider(
        providers: [
          Provider<OrdoBloc>(create: (context) => _ordoBloc),
          Provider<ClassBloc>(create: (context) => _classBloc),
        ],
        child: SingleChildScrollView(
          child: BlocBuilder<ClassBloc, ClassState>(
            bloc: _classBloc,
            builder: (context, state) {
              if (state is GetIdClassSucces) {
                final List<DropdownMenuEntry<dynamic>> latin =
                    <DropdownMenuEntry<dynamic>>[];
                for (final String namaLatin in state.latinName) {
                  final index = state.latinName.indexOf(namaLatin);
                  latin.add(DropdownMenuEntry<dynamic>(
                      value: state.idClass[index], label: namaLatin));
                }
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: AppColor.secondaryColor.withOpacity(0.7)),
                        child: Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "if the class data not avaible please  ",
                                style: GoogleFonts.poppins()),
                            TextSpan(
                                text: "Press here!",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddDataClass(
                                                    isEdit: false)));
                                  }),
                          ])),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          getImage();
                        },
                        child: Card(
                          elevation: 4,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: imagefromUrl != null
                                ? Image.file(File(imagefromUrl!.path))
                                : _imagePicker == null
                                    ? Icon(
                                        Icons.image_search,
                                        size: 100,
                                        color: Colors.black45.withOpacity(0.5),
                                      )
                                    : Image.file(File(_imagePicker!.path)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _key,
                          child: Column(
                            children: [
                              DropdownMenu(
                                menuHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.85,
                                initialSelection: id,
                                dropdownMenuEntries: latin,
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                ),
                                onSelected: (latin) {
                                  setState(() {
                                    id = latin;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                  hintText: "Latin Name",
                                  controller: latinName,
                                  validator: Validator.basicValidate,
                                  obsecure: false),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                  hintText: "Common Name",
                                  controller: commonName,
                                  validator: Validator.basicValidate,
                                  obsecure: false),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                  hintText: "Characteristics",
                                  controller: characteristics,
                                  validator: Validator.basicValidate,
                                  obsecure: false),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomTextField(
                                  hintText: "Description",
                                  controller: description,
                                  validator: Validator.basicValidate,
                                  obsecure: false),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          )),
                      BlocConsumer<OrdoBloc, OrdoState>(
                          bloc: _ordoBloc,
                          builder: (context, state) {
                            return CustomButton(
                                text: widget.isEdit
                                    ? "Edit Data Ordo"
                                    : "Add Data Ordo",
                                onTap: () {
                                  if (_key.currentState!.validate()) {
                                    if (widget.isEdit) {
                                      _ordoBloc.add(UpdateOrdoEvent(
                                          idOrdo: widget.idOrdo!.toInt(),
                                          latinName: latinName.text,
                                          commonName: commonName.text,
                                          character: characteristics.text,
                                          description: description.text,
                                          idClass: id!.toInt(),
                                          image: _imagePicker));
                                    } else {
                                      if (_imagePicker != null) {
                                        _ordoBloc.add(AddOrdoEvent(
                                            idClass: id!.toInt(),
                                            latinName: latinName.text,
                                            commonName: commonName.text,
                                            character: characteristics.text,
                                            description: description.text,
                                            image: _imagePicker));
                                      } else {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                title: "Add Ordo Data",
                                                desc: "Please add the Image",
                                                btnOkOnPress: () {})
                                            .show();
                                      }
                                    }
                                  }
                                });
                          },
                          listener: (context, state) {
                            if (state is AddOrdoSuccess) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  autoDismiss: false,
                                  title: "Add Ordo Data",
                                  desc:
                                      "Please wait admin to verification your data",
                                  onDismissCallback: (type) =>
                                      Navigator.pop(context),
                                  btnOkOnPress: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Navigation(pageId: 0)));
                                  }).show();
                            } else if (state is UpdateOrdoStateSuccess) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  autoDismiss: false,
                                  title: "Update Ordo Data",
                                  desc: "Update Data Success",
                                  onDismissCallback: (type) =>
                                      Navigator.pop(context),
                                  btnOkOnPress: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Navigation(pageId: 0)));
                                  }).show();
                            } else if (state is FailureOrdo) {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      title: "Update Ordo Data",
                                      desc: widget.isEdit
                                          ? "Edit Data Failed "
                                          : "Add Data Failed",
                                      btnOkOnPress: () {})
                                  .show();
                            }
                          })
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final imageData = await ImageResource.getImageData();
    setState(() {
      _imagePicker = imageData;
    });
  }

  Future<void> getImageFromNetwork(String image) async {
    final imageData = await ImageResource.getImageFileFromNetwork(image);
    setState(() {
      _imagePicker = imageData;
    });
  }
}
