import 'package:biodiv/ui/home/home_screen.dart';
import 'package:biodiv/ui/scarcity/scarcity.dart';
import 'package:biodiv/ui/verifikasi%20data/verif_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Navigation extends StatefulWidget {
  final int pageId;
  const Navigation({super.key, required this.pageId});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int page = 0;
  List navigation = [
    const HomeScreen(),
    const ScarcityScreen(),
    const VerificationScreen(),
  ];
  @override
  void initState() {
    super.initState();
    page = widget.pageId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: AppColor.secondaryColor,
        items: const [
          Icon(
            Icons.home_sharp,
            size: 30,
            color: AppColor.mainColor,
          ),
          Icon(
            Icons.list_alt,
            size: 30,
            color: AppColor.mainColor,
          ),
          Icon(
            Icons.verified_user,
            size: 30,
            color: AppColor.mainColor,
          ),
          Icon(
            IconData(0xe9c9, fontFamily: 'MaterialIcons'),
            size: 30,
            color: AppColor.mainColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
      body: navigation[page],
    );
  }
}
