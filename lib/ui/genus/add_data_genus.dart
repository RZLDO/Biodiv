import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/famili/famili_bloc.dart';
import 'package:biodiv/BloC/genus/genus_bloc.dart';
import 'package:biodiv/repository/famili_repository.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../repository/image_repository.dart';
import '../../utils/colors.dart';
import '../../utils/custom_app_bar.dart';
import '../../utils/custom_button.dart';
import '../../utils/custom_textfield.dart';
import '../../utils/validation.dart';
import '../home/home_screen.dart';

class AddDataGenusScreen extends StatefulWidget {
  final int? idGenus;
  final String? latinName;
  final String? commonName;
  final String? character;
  final String? description;
  final int? idFamili;
  final bool isEdit;
  final String? image;
  const AddDataGenusScreen({
    super.key,
    this.character,
    this.commonName,
    this.description,
    this.idFamili,
    this.idGenus,
    this.latinName,
    this.image,
    required this.isEdit,
  });

  @override
  State<AddDataGenusScreen> createState() => _AddDataGenusScreenState();
}

class _AddDataGenusScreenState extends State<AddDataGenusScreen> {
  TextEditingController latinName = TextEditingController();
  TextEditingController commonName = TextEditingController();
  TextEditingController characteristics = TextEditingController();
  TextEditingController description = TextEditingController();
  // TextEditingController id = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  late GenusBloc _genusBloc;
  late FamiliBloc _familiBloc;
  XFile? _imagePicker;
  int? idFamili;
  @override
  void initState() {
    _familiBloc = FamiliBloc(repository: FamiliRepository());
    _genusBloc = GenusBloc(repository: GenusRepository());
    _familiBloc.add(GetIdLatinFamiliEvent());
    if (widget.isEdit) {
      latinName = TextEditingController(text: widget.latinName);
      commonName = TextEditingController(text: widget.commonName);
      characteristics = TextEditingController(text: widget.character);
      description = TextEditingController(text: widget.description);
      idFamili = widget.idFamili;
      getImageFromNetwork(widget.image.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomAppBar(text: ""),
      body: MultiProvider(
        providers: [
          Provider(create: (context) => _genusBloc),
          Provider(create: (context) => _familiBloc)
        ],
        child: BlocBuilder<FamiliBloc, FamiliState>(
          bloc: _familiBloc,
          builder: (context, state) {
            if (state is GetIdLatinSuccess) {
              final List<DropdownMenuEntry<dynamic>> latin =
                  <DropdownMenuEntry<dynamic>>[];
              for (final String namaLatin in state.namaLatin) {
                final index = state.namaLatin.indexOf(namaLatin);
                latin.add(DropdownMenuEntry<dynamic>(
                    value: state.idFamili[index], label: namaLatin));
              }
              return SingleChildScrollView(
                child: Padding(
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
                                  ..onTap = () {}),
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
                            child: _imagePicker != null
                                ? Image.file(File(_imagePicker!.path))
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
                                initialSelection: idFamili,
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
                                    idFamili = latin;
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
                      BlocConsumer<GenusBloc, GenusState>(
                          bloc: _genusBloc,
                          builder: (context, state) {
                            return CustomButton(
                                text: widget.isEdit
                                    ? "Edit Data Genus"
                                    : "Add Data Genus",
                                onTap: () {
                                  if (_key.currentState!.validate()) {
                                    if (widget.isEdit == true) {
                                      _genusBloc.add(UpdateDataGenusEvent(
                                          idFamili: idFamili!.toInt(),
                                          latinName: latinName.text,
                                          commonName: commonName.text,
                                          characterteristics:
                                              characteristics.text,
                                          description: description.text,
                                          idGenus: widget.idGenus!.toInt(),
                                          image: _imagePicker));
                                    } else {
                                      if (_imagePicker != null) {
                                        _genusBloc.add(AddDataGenusEvent(
                                            idFamili: idFamili!.toInt(),
                                            latinName: latinName.text,
                                            commonName: commonName.text,
                                            characterteristics:
                                                characteristics.text,
                                            description: description.text,
                                            image: _imagePicker));
                                      } else {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                title: "Add Genus Data",
                                                desc: "Please add the Image",
                                                btnOkOnPress: () {})
                                            .show();
                                      }
                                    }
                                  }
                                });
                          },
                          listener: (context, state) {
                            if (state is AddDataGenusSuccess) {
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  }).show();
                            } else if (state is UpdateGenusSuccess) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  autoDismiss: false,
                                  title: "Update Genus Data",
                                  desc: "Update Data Success",
                                  onDismissCallback: (type) =>
                                      Navigator.pop(context),
                                  btnOkOnPress: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  }).show();
                            } else if (state is GenusFailure) {
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
                ),
              );
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
