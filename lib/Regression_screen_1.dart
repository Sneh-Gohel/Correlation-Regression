// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, must_be_immutable, no_logic_in_create_state

import 'package:correlation_and_regression/Regression_screen_2.dart';
import 'package:flutter/material.dart';

class Regression_screen_1 extends StatefulWidget {
  Regression_screen_1( {super.key});

  @override
  State<StatefulWidget> createState() => _Regression_screen_1();
}

class _Regression_screen_1 extends State<Regression_screen_1> {
  final n_Controller = TextEditingController();
  final n = FocusNode();

  _Regression_screen_1();

  next_press() {
    int number = 1;
    if (n_Controller.text == "") {
      FocusScope.of(context).requestFocus(n);
    } else {
      bool is_valid_number = false;
      try {
        number = int.parse(n_Controller.text);
        is_valid_number = true;
      } catch (e) {
        FocusScope.of(context).requestFocus(n);
      }
      if (is_valid_number) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return Regression_screen_2(number);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
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
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight / 3),
              child: const Text(
                "Enter The Value...",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: screenWidth,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "n = ",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            // const EdgeInsets.only(top: 44, left: 40, right: 40),
                            const EdgeInsets.only(left: 4, right: 40),
                        child: TextField(
                          controller: n_Controller,
                          focusNode: n,
                          onEditingComplete: () {
                            // if (password_Controller.text == "") {
                            //   FocusScope.of(context).requestFocus(password);
                            // } else {
                            n.unfocus();
                            // }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.onetwothree_rounded),
                            suffix: GestureDetector(
                              child: const Icon(Icons.clear),
                              onTap: () {
                                n_Controller.clear();
                              },
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 230, 230, 230),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Total number of the observations",
                            // errorBorder: InputBorder.none,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 80,
                bottom: 80,
                left: (screenWidth - 175) / 2,
                right: (screenWidth - 175) / 2),
            child: ElevatedButton(
              onPressed: () {
                next_press();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                shape: const StadiumBorder(),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 25,
                      weight: BorderSide.strokeAlignOutside,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
