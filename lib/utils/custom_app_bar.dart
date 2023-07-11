import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? color;
  const CustomAppBar({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppColor.secondaryColor,
      backgroundColor: color ?? AppColor.backgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.mainColor),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: Text(
        text,
        style: ReusableTextStyle.basicMainColorBold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
