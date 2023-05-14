import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String namaUmum;
  final String namaLatin;
  final String image;
  const CustomCard(
      {super.key,
      required this.namaUmum,
      required this.namaLatin,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 8.0),
                Text(
                  namaUmum,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  namaLatin,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ],
        ));
  }
}
