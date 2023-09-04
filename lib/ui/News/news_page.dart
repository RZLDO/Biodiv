import 'package:biodiv/BloC/news/news_bloc.dart';
import 'package:biodiv/model/News%20Model/news_model.dart';
import 'package:biodiv/repository/news_repository.dart';
import 'package:biodiv/ui/News/add_news.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:biodiv/utils/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late NewsBloc _newsBloc;
  bool? isFabVisible;
  @override
  void initState() {
    _newsBloc = NewsBloc(newsRepository: NewsRepository());
    _newsBloc.add(GetNewsDataEvent());
    getUserPreference();
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
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        floatingActionButton: isFabVisible != null && isFabVisible!
            ? FloatingActionButton(
                backgroundColor: AppColor.secondaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewsPage()));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null,
        body: BlocProvider<NewsBloc>(
          create: (context) => _newsBloc,
          child: BlocBuilder(
              bloc: _newsBloc,
              builder: (context, state) {
                if (state is NewsSuccess) {
                  if (state.response.newsResult.isEmpty) {
                    return const Center(
                      child: EmptyData(
                          textMessage:
                              "No data News Here, we'll update it later"),
                    );
                  } else {
                    final List<NewsResult> data = state.response.newsResult;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {});
                  }
                } else if (state is NewsFailure) {
                  return FailureState(textMessage: state.errorMessage);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.mainColor,
                    ),
                  );
                }
              }),
        ));
  }
}
