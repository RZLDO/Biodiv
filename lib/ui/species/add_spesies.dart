import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/genus/genus_bloc.dart';
import 'package:biodiv/BloC/scarcity/scarcity_bloc.dart';
import 'package:biodiv/BloC/spesies/spesies_bloc.dart';
import 'package:biodiv/repository/genus_repository.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../repository/image_repository.dart';
import '../../utils/custom_app_bar.dart';
import '../../utils/custom_button.dart';
import '../../utils/custom_textfield.dart';
import '../../utils/validation.dart';

class AddSpesiesScreen extends StatefulWidget {
  final int? idGenus;
  final int? idScarcity;
  final int? idSpesies;
  final String? latinName;
  final String? commonName;
  final String? statusScarcity;
  final String? habitat;
  final String? description;
  final String? character;
  final String? image;
  final bool isEdit;
  const AddSpesiesScreen(
      {super.key,
      required this.isEdit,
      this.idSpesies,
      this.idScarcity,
      this.idGenus,
      this.latinName,
      this.commonName,
      this.description,
      this.habitat,
      this.character,
      this.statusScarcity,
      this.image});

  @override
  State<AddSpesiesScreen> createState() => _AddSpesiesScreenState();
}

class _AddSpesiesScreenState extends State<AddSpesiesScreen> {
  late GenusBloc _genusBloc;
  late SpesiesBloc _spesiesBloc;
  late ScarcityBloc _scarcityBloc;
  TextEditingController latinName = TextEditingController();
  TextEditingController commonName = TextEditingController();
  TextEditingController characteristics = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController habitat = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  XFile? _imagePicker;
  int? idGenus;
  int? idScarcity;
  String? statusScarcity;

  @override
  void initState() {
    super.initState();
    _genusBloc = GenusBloc(repository: GenusRepository());
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    _scarcityBloc = ScarcityBloc(repository: ScarcityRepository());
    _genusBloc.add(GetIdLatinGenusEvent());
    _scarcityBloc.add(GetScarcityId());

    if (widget.isEdit) {
      latinName = TextEditingController(text: widget.latinName);
      commonName = TextEditingController(text: widget.commonName);
      description = TextEditingController(text: widget.description);
      characteristics = TextEditingController(text: widget.character);
      idGenus = widget.idGenus;
      idScarcity = widget.idScarcity;
      statusScarcity = widget.statusScarcity;
      habitat = TextEditingController(text: widget.habitat);
      getImageFromNetwork(widget.image.toString());
    }
  }

  List<String> statusData = ['Tidak Dilindungi', 'Dilindungi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomAppBar(text: ""),
      body: MultiProvider(
        providers: [
          Provider<GenusBloc>(create: (context) => _genusBloc),
          Provider<ScarcityBloc>(create: (context) => _scarcityBloc),
        ],
        child: SingleChildScrollView(
          child: BlocBuilder<GenusBloc, GenusState>(
              bloc: _genusBloc,
              builder: (context, stateGenus) {
                return BlocBuilder<ScarcityBloc, ScarcityState>(
                    bloc: _scarcityBloc,
                    builder: (context, state) {
                      if (stateGenus is GenusLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.mainColor,
                          ),
                        );
                      } else if (state is GetIdScarcity &&
                          stateGenus is GetIdLatinGenusSuccess) {
                        final List<DropdownMenuEntry<dynamic>> latin =
                            <DropdownMenuEntry<dynamic>>[];
                        for (final String namaLatin in stateGenus.latinName) {
                          final index = stateGenus.latinName.indexOf(namaLatin);
                          latin.add(DropdownMenuEntry<dynamic>(
                              value: stateGenus.idGenus[index],
                              label: namaLatin));
                        }
                        final List<DropdownMenuEntry<dynamic>> scarcity =
                            <DropdownMenuEntry<dynamic>>[];
                        for (final String scarcityName in state.nameScarcity) {
                          final index =
                              state.nameScarcity.indexOf(scarcityName);
                          scarcity.add(DropdownMenuEntry<dynamic>(
                              value: state.idScarcity[index],
                              label: scarcityName));
                        }
                        final List<DropdownMenuEntry<dynamic>> status =
                            <DropdownMenuEntry<dynamic>>[];
                        for (final String statusName in statusData) {
                          status.add(DropdownMenuEntry<dynamic>(
                              value: statusName, label: statusName));
                        }
                        return Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: AppColor.secondaryColor
                                        .withOpacity(0.7)),
                                child: Center(
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "if the class data not avaible please  ",
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
                                                color: Colors.black45
                                                    .withOpacity(0.5),
                                              )
                                            : Image.file(
                                                File(_imagePicker!.path)),
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
                                        hintText: "Genus",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        initialSelection: idGenus,
                                        dropdownMenuEntries: latin,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.7),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 14),
                                        ),
                                        onSelected: (latin) {
                                          setState(() {
                                            idGenus = latin;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      DropdownMenu(
                                        hintText: "Scarcity",
                                        menuHeight: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        initialSelection: idGenus,
                                        dropdownMenuEntries: scarcity,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.7),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 14),
                                        ),
                                        onSelected: (scarcity) {
                                          setState(() {
                                            idScarcity = scarcity;
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
                                      DropdownMenu(
                                        hintText: "Status Scarcity",
                                        menuHeight: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        initialSelection: statusScarcity,
                                        dropdownMenuEntries: status,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.7),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 14),
                                        ),
                                        onSelected: (statusOfScarcity) {
                                          setState(() {
                                            statusScarcity = statusOfScarcity;
                                          });
                                        },
                                      ),
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
                                          hintText: "Habitat",
                                          controller: habitat,
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
                              BlocConsumer<SpesiesBloc, SpesiesState>(
                                  bloc: _spesiesBloc,
                                  builder: (context, state) {
                                    return CustomButton(
                                        text: widget.isEdit
                                            ? "Edit Data Ordo"
                                            : "Add Data Ordo",
                                        onTap: () {
                                          if (_key.currentState!.validate()) {
                                            if (widget.isEdit) {
                                              _spesiesBloc.add(
                                                  UpdateSpesiesDataEvent(
                                                      idGenus: idGenus!.toInt(),
                                                      idCategory:
                                                          idScarcity!.toInt(),
                                                      latinName: latinName.text,
                                                      commonName:
                                                          commonName.text,
                                                      habitat: habitat.text,
                                                      status: statusScarcity
                                                          .toString(),
                                                      character:
                                                          characteristics.text,
                                                      description:
                                                          description.text,
                                                      image: _imagePicker,
                                                      idSpesies: widget
                                                          .idSpesies!
                                                          .toInt()));
                                            } else {
                                              if (_imagePicker != null) {
                                                _spesiesBloc
                                                    .add(AddSpesiesDataEvent(
                                                  idGenus: idGenus!.toInt(),
                                                  idCategory:
                                                      idScarcity!.toInt(),
                                                  latinName: latinName.text,
                                                  commonName: commonName.text,
                                                  habitat: habitat.text,
                                                  status:
                                                      statusScarcity.toString(),
                                                  character:
                                                      characteristics.text,
                                                  description: description.text,
                                                  image: _imagePicker,
                                                ));
                                              } else {
                                                AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.error,
                                                        title: "Add Ordo Data",
                                                        desc:
                                                            "Please add the Image",
                                                        btnOkOnPress: () {})
                                                    .show();
                                              }
                                            }
                                          }
                                        });
                                  },
                                  listener: (context, state) {
                                    if (state is AddDataSuccess) {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          autoDismiss: false,
                                          title: "Add Spesies Data",
                                          desc:
                                              "Please wait admin to verification your data",
                                          onDismissCallback: (type) =>
                                              Navigator.pop(context),
                                          btnOkOnPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Navigation(
                                                            pageId: 0)));
                                          }).show();
                                    } else if (state is UpdateDataSuccess) {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          autoDismiss: false,
                                          title: "Update Spesies Data",
                                          desc: "Update Data Success",
                                          onDismissCallback: (type) =>
                                              Navigator.pop(context),
                                          btnOkOnPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Navigation(
                                                            pageId: 0)));
                                          }).show();
                                    } else if (state is SpesiesFailure) {
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
                        return const FailureState(
                            textMessage: "Sorry General Failure happen :()");
                      }
                    });
              }),
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
