// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Map_screen extends StatefulWidget {
  const Map_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Map_screen();
}

class _Map_screen extends State<Map_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SlideAction(onSubmit: () {
        return null;
      },),),
    );
  }
}
