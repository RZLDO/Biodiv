import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/verification/verif_bloc.dart';
import 'package:biodiv/repository/verification_repository.dart';
import 'package:biodiv/ui/verifikasi%20data/class/verified_item_class.dart';
import 'package:biodiv/ui/verifikasi%20data/famili/famili_unverif.dart';
import 'package:biodiv/ui/verifikasi%20data/genus/genus_verif.dart';
import 'package:biodiv/ui/verifikasi%20data/ordo/ordo_verif.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String> taxon = [
    "Unverified Class",
    "Unverified Ordo",
    "Unverified Genus",
    "Unverified Family",
    "Unverified Species"
  ];
  List pageDirection = [
    const UnverifiedClassScreen(),
    const OrdoUnverif(),
    const GenusUnverif(),
    const FamiliUnverif()
  ];
  late VerifBloc _verifBloc;
  @override
  void initState() {
    super.initState();
    _verifBloc = VerifBloc(repository: VerificationRepository());
    _verifBloc.add(GetUnverifiedData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: BlocProvider(
            create: (context) => _verifBloc,
            child: BlocBuilder<VerifBloc, VerifState>(
                bloc: _verifBloc,
                builder: (context, state) {
                  if (state is VerifLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
                    );
                  } else if (state is GetUnverifiedDataSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: state.data.length - 1,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              pageDirection[index]));
                                },
                                child: Card(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "asset/image/backgroundBanner.png"),
                                            fit: BoxFit.fill)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${state.data[index]}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.mainColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          taxon[index].toUpperCase(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.mainColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  } else {
                    return Center();
                  }
                })));
  }
}
