import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/repository/spesies_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  double? radiusCircle;
  Marker _draggableMarker = const Marker(
      draggable: true,
      position: LatLng(4.509551, 96.931655),
      markerId: MarkerId("1"));
  Circle circle = Circle(
    circleId: const CircleId('1'),
    center: const LatLng(4.509551, 96.931655),
    radius: 0,
    fillColor: Colors.redAccent.withOpacity(0.5),
    strokeColor: Colors.redAccent,
    strokeWidth: 2,
  );
  @override
  void initState() {
    _spesiesBloc = SpesiesBloc(repository: SpesiesRepository());
    super.initState();
  }

  Future<void> _getLatlongFromAddress(String locationName) async {
    try {
      List<Location> latLong = await locationFromAddress(locationName);
      if (latLong.isNotEmpty) {
        latitude.text = latLong[0].latitude.toString();
        longitude.text = latLong[0].longitude.toString();
        _draggableMarker = Marker(
          markerId: const MarkerId('draggable_marker'),
          position: LatLng(latLong[0].latitude, latLong[0].longitude),
          draggable: true,
        );
        circle = circle.copyWith(
            fillColorParam: Colors.redAccent.withOpacity(0.5),
            strokeColorParam: Colors.redAccent,
            strokeWidthParam: 2,
            centerParam: LatLng(latLong[0].latitude, latLong[0].longitude),
            radiusParam: radiusCircle); // Return the location name (address)
      }
    } catch (e) {}
  }

  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.name.toString(); // Return the location name (address)
      }
      return "no name";
    } catch (e) {
      return e.toString();
    }
  }

  static const CameraPosition _cameraPosition =
      CameraPosition(zoom: 7.3, target: LatLng(4.509551, 96.931655));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(text: widget.spesiesName),
      resizeToAvoidBottomInset: false,
      body: BlocProvider<SpesiesBloc>(
        create: (context) => _spesiesBloc,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: GoogleMap(
                markers: {_draggableMarker},
                circles: {circle},
                initialCameraPosition: _cameraPosition,
                onTap: (LatLng latLng) async {
                  // When the map is tapped, update the position of the draggable marker
                  final lokasiResult = await _getAddressFromLatLng(latLng);
                  setState(() {
                    latitude.text = latLng.latitude.toString();
                    longitude.text = latLng.longitude.toString();
                    location.text = lokasiResult.toString();
                    circle = circle.copyWith(
                        fillColorParam: Colors.redAccent.withOpacity(0.5),
                        strokeColorParam: Colors.redAccent,
                        strokeWidthParam: 2,
                        radiusParam: radiusCircle ?? 0,
                        centerParam: LatLng(latLng.latitude, latLng.longitude));
                    _draggableMarker = Marker(
                      markerId: const MarkerId('draggable_marker'),
                      position: latLng,
                      draggable: true,
                    );
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: location,
                        onEditingComplete: () {
                          setState(() {
                            _getLatlongFromAddress(location.text);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Location",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: longitude,
                        keyboardType: TextInputType.number,
                        onEditingComplete: () {
                          setState(() {
                            if (latitude.text.isNotEmpty &&
                                longitude.text.isNotEmpty) {
                              double? parseLatitude =
                                  double.tryParse(latitude.text);
                              double? parseLongitude =
                                  double.tryParse(latitude.text);
                              if (parseLatitude != null &&
                                  parseLongitude != null) {
                                _draggableMarker = Marker(
                                  markerId: const MarkerId('draggable_marker'),
                                  position: LatLng(parseLatitude.toDouble(),
                                      parseLongitude.toDouble()),
                                  draggable: true,
                                );
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Longitude",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: longitude,
                        keyboardType: TextInputType.number,
                        onEditingComplete: () {
                          setState(() {
                            if (latitude.text.isNotEmpty &&
                                longitude.text.isNotEmpty) {
                              double? parseLatitude =
                                  double.tryParse(latitude.text);
                              double? parseLongitude =
                                  double.tryParse(latitude.text);
                              if (parseLatitude != null &&
                                  parseLongitude != null) {
                                _draggableMarker = Marker(
                                  markerId: const MarkerId('draggable_marker'),
                                  position: LatLng(parseLatitude.toDouble(),
                                      parseLongitude.toDouble()),
                                  draggable: true,
                                );
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Longitude",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: radius,
                        keyboardType: TextInputType.number,
                        onEditingComplete: () {
                          setState(() {
                            double? parse = double.tryParse(radius.text);
                            radiusCircle = parse;
                            circle = circle.copyWith(
                                fillColorParam:
                                    Colors.redAccent.withOpacity(0.5),
                                strokeColorParam: Colors.redAccent,
                                strokeWidthParam: 2,
                                radiusParam: radiusCircle);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Radius",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ],
                  )),
            ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomButton(
                        text: "Add Location",
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            _spesiesBloc.add(AddLocationSpesiesEvent(
                                locationName: location.text,
                                latitude: double.parse(latitude.text),
                                longitude: double.parse(longitude.text),
                                radius: int.parse(radius.text),
                                idSpesies: widget.idSpesies));
                          }
                        }),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
