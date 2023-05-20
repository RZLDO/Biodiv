import 'package:biodiv/utils/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool isLoading;
  const CustomButton(
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

class CustomButtonExtended extends StatelessWidget {
  final Function() onTap;
  final String? text;
  final double width;
  final IconData? icon;
  final bool setText;
  final Color? color;
  const CustomButtonExtended(
      {super.key,
      this.text,
      required this.onTap,
      required this.width,
      this.icon,
      this.color,
      required this.setText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
          color: color ?? AppColor.mainColor,
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          splashColor: AppColor.secondaryColor,
          child: Center(
              // ignore: unnecessary_null_comparison
              child: setText
                  ? Icon(icon)
                  : Text(
                      text.toString(),
                      style: ReusableTextStyle.buttonTextStyle,
                    )),
        ),
      ),
    );
  }
}
