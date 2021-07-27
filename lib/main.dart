import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/constants.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import 'layout/home_layout.dart';
import 'shared/cubit/news_cubit.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsCubit()..getBuisness(),
        child: BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              NewsCubit cubit = NewsCubit.get(context);
              return MaterialApp(
                theme: ThemeData(
                  textTheme: TextTheme(
                    subhead: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    title: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20,
                  ),
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                  ),
                ),
                darkTheme: ThemeData(
                  textTheme: TextTheme(
                    subhead: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    title: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  dividerColor: Colors.white38,
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Color(0xff333739),
                  iconTheme: IconThemeData(color: Colors.white),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20,
                    backgroundColor: Color(0xff333739),
                  ),
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    backgroundColor: Color(0xff333739),
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff333739),
                        statusBarIconBrightness: Brightness.light),
                  ),
                ),
                themeMode:
                    cubit.isDark == true ? ThemeMode.dark : ThemeMode.light,
                home: Directionality(
                    child: SafeArea(child: NewsHome()),
                    textDirection: TextDirection.ltr),
              );
            }));
  }
}
