// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:correlation_and_regression/Correlation_screen_1.dart';
import 'package:flutter/material.dart';

class Correlation_operation_select_screen extends StatefulWidget {
  const Correlation_operation_select_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Correlation_operation_select_screen();
}

class _Correlation_operation_select_screen
    extends State<Correlation_operation_select_screen> {
  screen_loder(int number) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return Correlation_screen_1(number);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.brown,
        elevation: 10,
        title: const Text("Correlation And Regression"),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              screen_loder(1);
            },
            child: Material(
              elevation: 2,
              shadowColor: Colors.green,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.green,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Karl pearson's Coefficient of Correlation",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              screen_loder(2);
            },
            child: Material(
              elevation: 2,
              shadowColor: Colors.green,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.green,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Spearman's Rank Correlation Coefficient",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
