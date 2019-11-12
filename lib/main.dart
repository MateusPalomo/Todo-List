import 'package:flutter/material.dart';
import 'package:todo_list2/views/home_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.teal)));
}
