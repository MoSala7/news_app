import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/buisness.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Buisness'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    BuisnessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) getBuisness();
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNav());
  }

  List<dynamic> buisness = [];

  void getBuisness() {
    emit(GetNewsBuisnessLoading());
    if (buisness.length < 1) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '6fe28c946c4a4bf6b421de50515333cf',
      }).then((value) {
        buisness = value.data['articles'];
        print(value);
        emit(GetBuisnessNewsSuccess());
      }).catchError((e) {
        GetBuisnessNewsError(e.toString());
      });
    } else {
      emit(GetSportsNewsSuccess());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(GetNewsSportsLoading());
    if (sports.length < 1) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6fe28c946c4a4bf6b421de50515333cf',
      }).then((value) {
        sports = value.data['articles'];
        print(value);
        emit(GetSportsNewsSuccess());
      }).catchError((e) {
        GetSportsNewsError(e.toString());
      });
    } else {
      emit(GetSportsNewsSuccess());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(GetNewsScienceLoading());
    if (science.length < 1) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6fe28c946c4a4bf6b421de50515333cf',
      }).then((value) {
        science = value.data['articles'];
        print(value);
        emit(GetScienceNewsSuccess());
      }).catchError((e) {
        GetScienceNewsError(e.toString());
      });
    } else {
      emit(GetScienceNewsSuccess());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(GetNewsSearchLoading());
    DioHelper.getData(url: 'v2/everything', query: {
      'sortBy': 'popularity',
      'q': value,
      'apiKey': '6fe28c946c4a4bf6b421de50515333cf',
    }).then((value) {
      search = value.data['articles'];
      print(value);
      emit(GetSearchNewsSuccess());
    }).catchError((e) {
      GetSearchNewsError(e.toString());
    });
  }

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  void switchTheme() {
    isDark = !isDark;
    CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
      print(CacheHelper.getData(key: 'isDark'));
      emit(SwithThemeApp());
    });
  }
}
