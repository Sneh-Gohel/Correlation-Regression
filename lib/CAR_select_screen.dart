// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names

import 'package:correlation_and_regression/Correlation_operation_select_scren.dart';
import 'package:correlation_and_regression/Regression_screen_1.dart';
import 'package:flutter/material.dart';

class CAR_select_screen extends StatefulWidget {
  const CAR_select_screen({super.key});

  @override
  State<StatefulWidget> createState() => _CAR_select_screen();
}

class _CAR_select_screen extends State<CAR_select_screen> {
  final PageController _pageController = PageController(initialPage: 0);
  var operations_details = {0: "Correlation", 1: "Regression"};

  screen_loader(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // return const COA_screen_1();
            return const Correlation_operation_select_screen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            var scaleAnimation =
                Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            return SlideTransition(
              // opacity: animation,
              // scale: scaleAnimation,
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // return const COA_screen_1();
            return Regression_screen_1();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            var scaleAnimation =
                Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            return SlideTransition(
              // opacity: animation,
              // scale: scaleAnimation,
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
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
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          OrientationBuilder(
            builder: (context, orientation) {
              final int itemCount =
                  orientation == Orientation.landscape ? 3 : 2;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: itemCount,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        screen_loader(index);
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        shadowColor: Colors.green,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double width = constraints.maxWidth;
                              double hight = constraints.maxHeight;
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  operations_details[index]!,
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 20),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
