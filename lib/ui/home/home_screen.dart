import 'package:biodiv/BloC/home/home_bloc.dart';
import 'package:biodiv/repository/home_repository.dart';
import 'package:biodiv/repository/user_preferences.dart';
import 'package:biodiv/ui/class%20page/class_page.dart';
import 'package:biodiv/ui/famili%20page/famili.dart';
import 'package:biodiv/ui/genus/genus.dart';
import 'package:biodiv/ui/login/login_screen.dart';
import 'package:biodiv/ui/ordo%20page/ordo.dart';
import 'package:biodiv/ui/search_page/search_page.dart';
import 'package:biodiv/ui/species/species.dart';
import 'package:biodiv/utils/chart.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:biodiv/utils/text_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PieChartSectionData> showingSections =
      List<PieChartSectionData>.empty(growable: true);

  int touchedIndex = -1;
  final List<String> _taksonomiItems = [
    'class',
    'ordo',
    'famili',
    'genus',
    'spesies'
  ];
  final List<Color> colors = [
    AppColor.mainColor,
    AppColor.secondaryColor,
    AppColor.thirdColor,
    Colors.blueGrey,
    Colors.lightGreen,
  ];
  final List listNavigation = [
    const ClassScreen(),
    const OrdoScreen(),
    const FamiliScreen(),
    const GenusScreen(),
    const SpeciesScreen()
  ];
  late HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(homeRepository: HomeRepository());
    _homeBloc.add(GetTotalData());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
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
      body: BlocProvider(
          create: (context) => _homeBloc,
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAllSuccess) {
                return Center(
                  child: Column(
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
                          Positioned(
                              left: 20,
                              child: Text(
                                "Hi, ${state.userModel.name}",
                                style: ReusableTextStyle.basicWhiteBold,
                              )),
                          Positioned(
                              top: 20,
                              left: 20,
                              child: Text(state.userModel.level.toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          Positioned(
                              right: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchingPage()));
                                  },
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
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color: AppColor.thirdColor
                                              .withOpacity(0.5),
                                          offset: const Offset(2, 2))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.response.data!.totalDataCount
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.mainColor),
                                        ),
                                        const Text(
                                          "Taksonomi Data",
                                          style: ReusableTextStyle.title,
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 3,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: AppColor.secondaryColor),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          UserPreferences
                                              .deleteUserPreferences();
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
                                  height: 5,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height: 3,
                                  decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: 50,
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
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            listNavigation[
                                                                index]));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      state.taksonData[index]
                                                          .toString(),
                                                      style: ReusableTextStyle
                                                          .basicMainColorBold,
                                                    ),
                                                    Text(
                                                      _taksonomiItems[index],
                                                      style: ReusableTextStyle
                                                          .title,
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
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ShowPieChart(itemList: state.taksonData),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Indicator(
                                    color: colors[0],
                                    text: _taksonomiItems[0].toString()),
                                Indicator(
                                    color: colors[1],
                                    text: _taksonomiItems[1].toString()),
                                Indicator(
                                    color: colors[2],
                                    text: _taksonomiItems[2].toString()),
                                Indicator(
                                    color: colors[3],
                                    text: _taksonomiItems[3].toString()),
                                Indicator(
                                    color: colors[4],
                                    text: _taksonomiItems[4].toString()),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: FailureState(textMessage: "Maaf ada error"),
                );
              }
            },
          )),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  const Indicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: ReusableTextStyle.basic,
          ),
        ],
      ),
    );
  }
}
