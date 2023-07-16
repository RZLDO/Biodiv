import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/model/spesies/get_spesies_data.dart';
import 'package:biodiv/ui/scarcity/detail_scarcity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/colors.dart';
import '../class page/class_detail_page.dart';

class GoogleMapsScreen extends StatefulWidget {
  final List<Location> location;
  final Species spesies;
  final DetailScarcityData singkatan;
  const GoogleMapsScreen(
      {super.key,
      required this.location,
      required this.spesies,
      required this.singkatan});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  List<Marker> markers = [];
  Set<Circle> circles = {};
  @override
  void initState() {
    setLocation();
    super.initState();
  }

  void setLocation() async {
    for (int i = 0; i < widget.location.length; i++) {
      double latitude = widget.location[i].latitude;
      double longitude = widget.location[i].longitude;
      Marker marker = Marker(
        markerId: MarkerId('marker$i'),
        position: LatLng(latitude, longitude),
        onTap: () {
          _showBottomSheet(
              context, widget.spesies, widget.location[i], widget.singkatan);
        },
        infoWindow: InfoWindow(title: widget.spesies.commonName),
      );

      Circle circle = Circle(
        circleId: CircleId('circle$i'),
        center: LatLng(latitude, longitude),
        radius: widget.location[i].radius.toDouble(), // Radius in meters
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      );

      markers.add(marker);
      circles.add(circle);
    }
  }

  static const CameraPosition _cameraPosition =
      CameraPosition(zoom: 9, target: LatLng(4.509551, 96.931655));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.secondaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: GoogleMap(
          markers: Set<Marker>.from(markers),
          circles: circles,
          initialCameraPosition: _cameraPosition),
    );
  }
}

void _showBottomSheet(context, Species spesiesData, Location location,
    DetailScarcityData scarcity) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScarcityDetailScreen(
                                    idScarcity: scarcity.idKategori)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.secondaryColor.withOpacity(0.8)),
                        child: Center(
                          child: Text(
                            scarcity.singkatan,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextStyling(
                title: "Nama Spesies",
                text: spesiesData.latinName,
                style: false,
                size: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              TextStyling(
                title: "Habitat",
                text: spesiesData.habitat,
                style: false,
                size: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              TextStyling(
                title: "Daerah Penyebaran",
                text: location.namaLokasi,
                style: false,
                size: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              TextStyling(
                title: "Characteristics",
                text: spesiesData.characteristics,
                style: false,
                size: 16,
              ),
            ],
          ),
        );
      });
}
