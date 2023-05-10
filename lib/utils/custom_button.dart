import 'package:biodiv/utils/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  bool isLoading;
  CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
          color: AppColor.mainColor, borderRadius: BorderRadius.circular(10)),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          splashColor: AppColor.secondaryColor,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    text,
                    style: ReusableTextStyle.buttonTextStyle,
                  ),
          ),
        ),
      ),
    );
  }
}
