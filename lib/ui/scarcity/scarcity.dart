import 'package:biodiv/BloC/scarcity/scarcity_bloc.dart';
import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:biodiv/repository/scarcity_repository.dart';
import 'package:biodiv/utils/chart.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ScarcityScreen extends StatefulWidget {
  const ScarcityScreen({super.key});

  @override
  State<ScarcityScreen> createState() => _ScarcityScreenState();
}

class _ScarcityScreenState extends State<ScarcityScreen> {
  late ScarcityBloc _scarcityBloc;
  @override
  void initState() {
    super.initState();
    _scarcityBloc = ScarcityBloc(repository: ScarcityRepository());
    _scarcityBloc.add(GetTotalScarcity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => _scarcityBloc,
          child: BlocBuilder<ScarcityBloc, ScarcityState>(
            builder: (context, state) {
              if (state is ScarcityLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is GetTotalScarcitySuccess) {
                List<ScarcityModelChart> data = state.result;
                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chart Of Scarcity",
                        style: GoogleFonts.poppins(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                            textBaseline: TextBaseline.ideographic,
                            fontSize: 18),
                      ),
                      Container(
                        height: 3,
                        width: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColor.mainColor),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ShowLineChart(data: data))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child:
                      FailureState(textMessage: "sorry Something get wrong :("),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
