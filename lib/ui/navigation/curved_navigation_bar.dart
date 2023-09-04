import 'package:biodiv/ui/News/news_page.dart';
import 'package:biodiv/ui/Profile/profile_screen.dart';
import 'package:biodiv/ui/home/home_screen.dart';
import 'package:biodiv/ui/scarcity/scarcity.dart';
import 'package:biodiv/ui/verifikasi%20data/verif_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';

class Navigation extends StatefulWidget {
  final int pageId;
  const Navigation({super.key, required this.pageId});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int? page;
  bool? isAdmin;
  List navigation = [];
  @override
  void initState() {
    page = widget.pageId;
    getUserLevel();
    super.initState();
  }

  Future<void> getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? level = preferences.getInt("UserLevel");
    if (level == 3) {
      setState(() {
        isAdmin = false;
        navigation = [
          const HomeScreen(),
          const ScarcityScreen(),
          const NewsPage(),
          const ProfileScreen()
        ];
      });
    } else {
      setState(() {
        isAdmin = true;
        navigation = [
          const HomeScreen(),
          const ScarcityScreen(),
          const NewsPage(),
          const VerificationScreen()
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: AppColor.backgroundColor,
        buttonBackgroundColor: Colors.white,
        backgroundColor: AppColor.secondaryColor.withOpacity(0.7),
        animationCurve: Curves.decelerate,
        items: [
          const Icon(Icons.home_sharp, size: 30, color: AppColor.mainColor),
          const Icon(
            Icons.list_alt,
            size: 30,
            color: AppColor.mainColor,
          ),
          const Icon(Icons.newspaper, size: 30, color: AppColor.mainColor),
          isAdmin != null && isAdmin!
              ? const Icon(
                  Icons.verified_user,
                  size: 30,
                  color: AppColor.mainColor,
                )
              : const Icon(
                  Icons.person_3,
                  size: 30,
                  color: AppColor.mainColor,
                ),
        ],
        index: page!.toInt(),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
      body: navigation.isEmpty && page != null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : navigation[page!.toInt()],
    );
  }
}
