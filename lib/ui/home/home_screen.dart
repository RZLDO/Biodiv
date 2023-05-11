import 'package:biodiv/ui/login/login_screen.dart';
import 'package:biodiv/utils/text_style.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _taksonomiItems = [
    'Kingdom Data',
    'Filum Data',
    'Class Data',
    'Ordo Data',
    'Family Data'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.backgroundColor,
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    "asset/image/LogoBiodiversity.png",
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen())),
                    title: const Text("Logout"),
                    leading: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: AppColor.secondaryColor,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "BIODIV-INFORMATICS",
                style: ReusableTextStyle.basicWhiteBold,
              ),
            ),
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
                setState(() {});
              },
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                    ),
                    Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: AppColor.secondaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                    const Positioned(
                        left: 20,
                        child: Text(
                          "Hi, Rizaldo",
                          style: ReusableTextStyle.basicWhiteBold,
                        )),
                    const Positioned(
                        top: 20,
                        left: 20,
                        child: Text("BKSDA",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white))),
                    Positioned(
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search_sharp,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        left: 40,
                        right: 40,
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: AppColor.thirdColor.withOpacity(0.5),
                                    offset: const Offset(2, 2))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "1204",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainColor),
                                  ),
                                  Text(
                                    "Taksonomi Data",
                                    style: ReusableTextStyle.title,
                                  )
                                ],
                              ),
                              Container(
                                width: 3,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColor.secondaryColor),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    size: 35,
                                    color: AppColor.mainColor,
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Detail Taksonomi Data: ",
                            style: ReusableTextStyle.title,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    margin: const EdgeInsets.only(
                                        right: 20, bottom: 5),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(0.3, 0.3),
                                              color: AppColor.thirdColor,
                                              blurRadius: 2)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "1",
                                                style: ReusableTextStyle
                                                    .basicMainColorBold,
                                              ),
                                              Text(
                                                _taksonomiItems[index],
                                                style: ReusableTextStyle.title,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Biodiversity Graphic",
                    style: ReusableTextStyle.title,
                  ),
                ),
                const Center(),
              ],
            )));
  }
}
