import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/news/news_bloc.dart';
import 'package:biodiv/repository/news_repository.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:biodiv/utils/custom_button.dart';
import 'package:biodiv/utils/custom_textfield.dart';
import 'package:biodiv/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../repository/image_repository.dart';

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({super.key});

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  TextEditingController judulBerita = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController webUrl = TextEditingController();
  XFile? _imagePicker;
  late NewsBloc _newsBloc;
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    _newsBloc = NewsBloc(newsRepository: NewsRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(text: "Add News"),
        backgroundColor: AppColor.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: BlocProvider<NewsBloc>(
          create: (context) => _newsBloc,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  getImage();
                },
                child: Card(
                  elevation: 4,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: _imagePicker != null
                        ? Image.file(File(_imagePicker!.path))
                        : _imagePicker == null
                            ? Icon(
                                Icons.image_search,
                                size: 100,
                                color: Colors.black45.withOpacity(0.5),
                              )
                            : Image.file(File(_imagePicker!.path)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextField(
                            hintText: "Judul Berita",
                            controller: judulBerita,
                            validator: Validator.basicValidate,
                            obsecure: false),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                            hintText: "Deskripsi Singkat",
                            controller: deskripsi,
                            validator: Validator.basicValidate,
                            obsecure: false),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                            hintText: "Web Url",
                            controller: webUrl,
                            validator: Validator.basicValidate,
                            obsecure: false),
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer(
                bloc: _newsBloc,
                builder: (BuildContext context, state) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                          text: "Add News",
                          onTap: () {
                            if (_imagePicker != null) {
                              if (_key.currentState!.validate()) {
                                _newsBloc.add(AddNewsEvent(
                                    judul: judulBerita.text,
                                    deskripsi: deskripsi.text,
                                    webUrl: webUrl.text,
                                    image: _imagePicker));
                              }
                            } else {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      title: "add news",
                                      desc: "Please provide the Image",
                                      btnOkOnPress: () {})
                                  .show();
                            }
                          }));
                },
                listener: (BuildContext context, state) {
                  if (state is NewsAddState) {
                    if (state.result) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              title: "add news",
                              desc: "Error Happens Sowwy",
                              btnOkOnPress: () {})
                          .show();
                    } else {}
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "add news",
                        desc: "add News Success",
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Navigation(pageId: 0)));
                        }).show();
                  }
                },
              )
            ],
          )),
        ));
  }

  Future<void> getImage() async {
    final imageData = await ImageResource.getImageData();
    setState(() {
      _imagePicker = imageData;
    });
  }
}
