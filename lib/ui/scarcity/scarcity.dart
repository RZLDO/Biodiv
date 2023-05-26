import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScarcityScreen extends StatefulWidget {
  const ScarcityScreen({super.key});

  @override
  State<ScarcityScreen> createState() => _ScarcityScreenState();
}

class _ScarcityScreenState extends State<ScarcityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
    );
  }
}
