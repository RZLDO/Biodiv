import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(),
      ),
    );
  }
}
