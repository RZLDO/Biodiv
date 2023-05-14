import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddDataClass extends StatefulWidget {
  const AddDataClass({super.key});

  @override
  State<AddDataClass> createState() => _AddDataClassState();
}

class _AddDataClassState extends State<AddDataClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
    );
  }
}
