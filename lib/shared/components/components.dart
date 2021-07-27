import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';

Widget buildArticleItem(articel, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(articel['url']));
    },
    child: ListTile(
      leading: Container(
        height: 90,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage('${articel['urlToImage']}'),
              fit: BoxFit.cover),
        ),
      ),
      title: Text(
        "${articel['title']}",
        style: Theme.of(context).textTheme.subhead,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "${articel['publishedAt']}",
        style: Theme.of(context).textTheme.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

Widget articleBuilder(list, context) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) => buildArticleItem(list[i], context),
        separatorBuilder: (context, i) =>
            Divider(color: Colors.grey[20], thickness: 1),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()),
  );
}

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context, MaterialPageRoute(builder: (BuildContext context) => widget));
