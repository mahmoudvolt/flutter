// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:first/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function?
      function, //put your func in VoidCallback type to avoid function void error
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String? val)? validate,
  required String lable,
  required IconData prefix,
  Function(String value)? onFieldSubmitted,
  Function(String value)? onChanged,
  Function? onTap,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (String value) {
        onFieldSubmitted!(value);
      },
      onChanged: (String value) {
        onChanged!(value);
      },
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
      validator: validate,
      onTap: () {
        onTap!();
      },
      enabled: isClickable,
      obscureText: isPassword,
    );

Widget builTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateDatabase(
                status: "done",
                id: model['id'],
              );
            },
            icon: Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateDatabase(
                status: "archived",
                id: model['id'],
              );
            },
            icon: Icon(Icons.archive),
            color: Colors.black45,
          ),
        ],
      ),
    );
