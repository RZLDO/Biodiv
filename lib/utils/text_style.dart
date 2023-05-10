import 'package:flutter/material.dart';

import 'colors.dart';

class ReusableTextStyle {
  static const TextStyle buttonTextStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static const TextStyle title = TextStyle(
      color: AppColor.mainColor, fontSize: 14, fontWeight: FontWeight.bold);

  static const TextStyle basic = TextStyle(color: Colors.grey, fontSize: 16);

  static const TextStyle basicMainColorBold = TextStyle(
      color: AppColor.mainColor, fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle basicWhiteBold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
}
