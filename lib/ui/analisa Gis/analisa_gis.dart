import 'package:biodiv/BloC/analysa/analysa_bloc.dart';
import 'package:biodiv/repository/analysa_repository.dart';
import 'package:biodiv/ui/analisa%20Gis/add_kemunculan.dart';
import 'package:biodiv/ui/species/detail_species.dart';
import 'package:biodiv/utils/chart.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/card_view.dart';

class AnalisaGIS extends StatefulWidget {
  final int idSpesies;
  final int idKelangkaan;
  const AnalisaGIS(
      {super.key, required this.idSpesies, required this.idKelangkaan});

  @override
  State<AnalisaGIS> createState() => _AnalisaGISState();
}

class _AnalisaGISState extends State<AnalisaGIS> {
  late AnalysaBloc _analysaBloc;
  @override
  void initState() {
    _analysaBloc = AnalysaBloc(repository: AnalysaRepository());
    _analysaBloc.add(GetAnalysaEvent(idSpesies: widget.idSpesies));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black45,
                          )),
                      ItemsAdmin(
                          icon: Icons.info_outline,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailSpesiesScreen(
                                        idSpesies: widget.idSpesies,
                                        idKelangkaan: widget.idKelangkaan)));
                          },
                          text: "See Detail Of This Animal"),
                      const Divider(
                        thickness: 1,
                      ),
                      ItemsAdmin(
                          icon: Icons.add,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddKemunculanPage(
                                          idSpesies: widget.idSpesies,
                                        )));
                          },
                          text: "add appearance"),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Icons.admin_panel_settings,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      appBar: const CustomAppBar(text: ""),
      body: BlocProvider<AnalysaBloc>(
        create: (context) => _analysaBloc,
        child: BlocBuilder(
            bloc: _analysaBloc,
            builder: (context, state) {
              if (state is GetAnalysaStateFailure) {
                return Center(
                  child: FailureState(textMessage: state.message),
                );
              } else if (state is GetAnalysaStateSuccess) {
                return SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: ChartAnalytic(
                          analyticData: state.result,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              }
            }),
      ),
    );
  }
}
