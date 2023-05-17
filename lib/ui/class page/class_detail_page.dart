import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/class/class_bloc.dart';
import 'package:biodiv/model/Class%20Model/detail_class_model.dart';
import 'package:biodiv/repository/class_repository.dart';
import 'package:biodiv/ui/home/home_screen.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/constant.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class DetailClass extends StatefulWidget {
  final String idClass;
  const DetailClass({super.key, required this.idClass});

  @override
  State<DetailClass> createState() => _DetailClassState();
}

class _DetailClassState extends State<DetailClass> {
  late ClassBloc _classBloc;
  @override
  void initState() {
    super.initState();
    _classBloc = ClassBloc(repository: ClassRepository());
    _classBloc.add(GetDetailClass(idClass: widget.idClass));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // appBar: const CustomAppBar(text: ""),
        body: BlocProvider<ClassBloc>(
          create: (context) => _classBloc,
          child: BlocBuilder<ClassBloc, ClassState>(
            builder: (context, state) {
              if (state is ClassLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                );
              } else if (state is DetailSuccess) {
                final ClassDataDetail? data = state.detail.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Image.network(
                        '$baseUrl/image/${data!.gambar}',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        fit: BoxFit.fill,
                      )),
                      Positioned(
                          top: 50,
                          left: 15,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.65,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 50),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextStyling(
                                      title: "Common Name",
                                      text: data.namaUmum,
                                      style: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextStyling(
                                      title: "Latin Name",
                                      text: data.namaLatin,
                                      style: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Characteristics",
                                      style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: AppColor.secondaryColor)),
                                    ),
                                    ReadMoreCustom(text: data.ciriCiri),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description",
                                      style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: AppColor.secondaryColor)),
                                    ),
                                    ReadMoreCustom(text: data.keterangan)
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                CustomButtonExtended(
                                    text: "Edit Data",
                                    onTap: () {},
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    setText: false),
                                const Spacer(),
                                CustomButtonExtended(
                                    color: AppColor.redColorAccent,
                                    icon: Icons.delete,
                                    onTap: () {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              autoDismiss: false,
                                              onDismissCallback: (type) {
                                                Navigator.pop(context);
                                              },
                                              btnOkOnPress: () {
                                                _classBloc.add(DeleteClass(
                                                    idClass: data.idClass));
                                                AwesomeDialog(
                                                        context: context,
                                                        autoDismiss: false,
                                                        onDismissCallback:
                                                            (type) {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        dialogType:
                                                            DialogType.success,
                                                        btnOkOnPress: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const HomeScreen()));
                                                        },
                                                        title:
                                                            "Data Berhasil di hapus")
                                                    .show();
                                              },
                                              btnCancelOnPress: () {},
                                              title:
                                                  "Are you sure to delete this data?")
                                          .show();
                                    },
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    setText: true),
                                const SizedBox(
                                  width: 24,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("an error occured"),
                );
              }
            },
          ),
        ));
  }
}

class TextStyling extends StatelessWidget {
  final String title;
  final String text;
  final bool style;
  const TextStyling(
      {super.key,
      required this.title,
      required this.text,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.secondaryColor))),
        Text(text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontStyle: style ? FontStyle.italic : FontStyle.normal))),
      ],
    );
  }
}

class ReadMoreCustom extends StatefulWidget {
  final String text;
  const ReadMoreCustom({super.key, required this.text});

  @override
  State<ReadMoreCustom> createState() => _ReadMoreCustomState();
}

class _ReadMoreCustomState extends State<ReadMoreCustom> {
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      widget.text,
      trimLines: 3,
      trimMode: TrimMode.Line,
      trimCollapsedText: '  Show more',
      trimExpandedText: '   Show less',
      style: GoogleFonts.poppins(
          textStyle: const TextStyle(
        fontSize: 14,
      )),
      moreStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.mainColor),
      lessStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.mainColor),
    );
  }
}
