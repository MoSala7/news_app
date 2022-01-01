import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_rounded),
                onPressed: () {
                  cubit.switchTheme();
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.5),
            child: cubit.screens[cubit.currentIndex],
          ),
        );
      },
    );
  }
}
