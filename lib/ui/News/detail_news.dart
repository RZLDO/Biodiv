import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biodiv/BloC/news/news_bloc.dart';
import 'package:biodiv/repository/news_repository.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../navigation/curved_navigation_bar.dart';

class DetailNews extends StatefulWidget {
  final String judul;
  final String webUrl;
  final int idBerita;
  const DetailNews(
      {required this.judul,
      required this.webUrl,
      required this.idBerita,
      super.key});

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  late final WebViewController controller;
  bool? isFabVisible;
  late NewsBloc _newsBloc;
  @override
  void initState() {
    controller = WebViewController()..loadRequest(Uri.parse(widget.webUrl));
    getUserPreference();
    _newsBloc = NewsBloc(newsRepository: NewsRepository());
    super.initState();
  }
  void getUserPreference() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final level = preferences.getInt("UserLevel");
    if (level == 3) {
      setState(() {
        isFabVisible = false;
      });
    } else {
      setState(() {
        isFabVisible = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) => _newsBloc,
      child: Scaffold(
        appBar: CustomAppBar(text: widget.judul),
        backgroundColor: AppColor.backgroundColor,
        floatingActionButton: isFabVisible != null && isFabVisible!
            ? BlocConsumer<NewsBloc, NewsState>(
                listener: (context, state) {
                  if (state is NewsDeleteState) {
                    if (state.result) {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              title: "delete news",
                              desc: "Error Happens Sowwy",
                              btnOkOnPress: () {})
                          .show();
                    } else {}
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "Delete Success",
                        btnOkOnPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Navigation(pageId: 0)));
                        }).show();
                  } else if (state is NewsLoading) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                builder: (context, state) {
                  return FloatingActionButton(
                    backgroundColor: AppColor.secondaryColor,
                    onPressed: () {
                      _newsBloc.add(DeleteNewsEvent(idBerita: widget.idBerita));
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  );
                },
              )
            : null,
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
