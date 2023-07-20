import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? maxLines;
  final bool isNumber;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obsecure;

  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isNumber = false,
      this.maxLines,
      required this.controller,
      required this.validator,
      required this.obsecure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      obscureText: obsecure,
      validator: validator,
      maxLines: maxLines ?? 1,
    );
  }
}

class CustomTextSpan extends StatelessWidget {
  final String text;
  final String data;
  const CustomTextSpan({super.key, required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: text,
            style: GoogleFonts.poppins(
                color: AppColor.mainColor, fontWeight: FontWeight.bold)),
        TextSpan(
          text: data,
          style: GoogleFonts.poppins(color: Colors.black),
        )
      ]),
    );
  }
}
