import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.5, vertical: 10),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (v) {
                        if (v.isEmpty) {
                          return 'Search must not be empty';
                        }
                      },
                      onChange: (String v) {
                        cubit.getSearch(v);
                        print(cubit.search);
                      },
                      label: "Search",
                      prefix: Icons.search,
                    ),
                    Expanded(child: articleBuilder(cubit.search, context)),
                  ],
                )),
          );
        });
  }
}
