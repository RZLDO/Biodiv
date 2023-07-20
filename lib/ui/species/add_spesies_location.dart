import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BloC/spesies/spesies_bloc.dart';
import '../navigation/curved_navigation_bar.dart';

class AddLocationSpesies extends StatefulWidget {
  final int idSpesies;
  final String spesiesName;
  const AddLocationSpesies(
      {super.key, required this.idSpesies, required this.spesiesName});

  @override
  State<AddLocationSpesies> createState() => _AddLocationSpesiesState();
}

class _AddLocationSpesiesState extends State<AddLocationSpesies> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late SpesiesBloc _spesiesBloc;
  final location = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final radius = TextEditingController();

  @override
  void initState() {
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(text: widget.spesiesName),
      resizeToAvoidBottomInset: false,
      body: BlocProvider<SpesiesBloc>(
        create: (context) => _spesiesBloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          hintText: 'Location Name',
                          controller: location,
                          validator: Validator.basicValidate,
                          obsecure: false),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Latitude',
                          controller: latitude,
                          isNumber: true,
                          validator: Validator.basicValidate,
                          obsecure: false),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Longitude',
                          controller: longitude,
                          isNumber: true,
                          validator: Validator.basicValidate,
                          obsecure: false),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Radius',
                          controller: radius,
                          isNumber: true,
                          validator: Validator.validateRadius,
                          obsecure: false),
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<SpesiesBloc, SpesiesState>(
                  bloc: _spesiesBloc,
                  listener: (context, state) {
                    if (state is AddLocationSuccess) {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          title: "Add Location",
                          desc: "add Location Success",
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Navigation(pageId: 0)));
                          }).show();
                    } else if (state is SpesiesFailure) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              title: "Add Location",
                              desc:
                                  "add Location for${widget.spesiesName}Failure",
                              btnOkOnPress: () {})
                          .show();
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        text: "Add Location",
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            print("DOR");
                            _spesiesBloc.add(AddLocationSpesiesEvent(
                                locationName: location.text,
                                latitude: double.parse(latitude.text),
                                longitude: double.parse(longitude.text),
                                radius: int.parse(radius.text),
                                idSpesies: widget.idSpesies));
                          }
                        });
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
