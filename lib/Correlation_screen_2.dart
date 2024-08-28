// ignore_for_file: file_names, camel_case_types, must_be_immutable, non_constant_identifier_names, no_logic_in_create_state, unused_local_variable

import 'package:correlation_and_regression/Karl_p_Correlation_answer_scren.dart';
import 'package:correlation_and_regression/Spearman_man_correlation_answer_screen.dart';
import 'package:flutter/material.dart';

class Correlation_screen_2 extends StatefulWidget {
  int n = 1;
  int operation = 1;
  Correlation_screen_2(this.n, this.operation, {super.key});

  @override
  State<StatefulWidget> createState() => _Correlation_screen_2(n, operation);
}

class _Correlation_screen_2 extends State<Correlation_screen_2> {
  int n = 1;
  int operation = 1;
  List<TextEditingController> x_Controller = [];
  List<FocusNode> x = [];
  List<TextEditingController> y_Controller = [];
  List<FocusNode> y = [];

  _Correlation_screen_2(this.n, this.operation);

  Future<bool> exit_permission() async {
    bool confirmExit = false;
    confirmExit = (await _showExitConfirmationDialog(context))!;
    return confirmExit;
  }

  show_answers() {
    bool check = true;
    for (int i = 0; i < n; i++) {
      if (x_Controller[i].text == "") {
        check = false;
        FocusScope.of(context).requestFocus(x[i]);
        break;
      } else {
        if (y_Controller[i].text == "") {
          check = false;
          FocusScope.of(context).requestFocus(y[i]);
          break;
        }
      }
    }
    if (check == true) {
      if(operation == 1)
      {
        Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return Karl_p_Correlation_answer_screen(n,x_Controller,y_Controller);
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
      else if(operation == 2)
      {
        Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return Spearman_man_correlation_answer_screen(n,x_Controller,y_Controller);
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
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < n; i++) {
      x_Controller.add(TextEditingController());
      y_Controller.add(TextEditingController());
      x.add(FocusNode());
      y.add(FocusNode());
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
      body: WillPopScope(
        onWillPop: () async {
          return exit_permission();
        },
        child: ListView.builder(
          itemCount: n + 4,
          itemBuilder: (contax, index) {
            if (index == 0) {
              return Center(
                child: Text(
                  "n = $n",
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
              );
            } else if (index == 1) {
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: .5)),
                    ),
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: .5)),
                    ),
                  ],
                ),
              );
            } else if (index == 2) {
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: const Center(
                        child: Text(
                          "x",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: const Center(
                        child: Text(
                          "y",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (index == n + 3) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: (screenWidth - 250) / 2,
                  right: (screenWidth - 250) / 2,
                  bottom: 80,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    show_answers();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    shape: const StadiumBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Calculate",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextField(
                            controller: x_Controller[index - 3],
                            focusNode: x[index - 3],
                            onEditingComplete: () {
                              if (y_Controller[index - 3].text == "") {
                                FocusScope.of(context)
                                    .requestFocus(y[index - 3]);
                              } else {
                                x[index - 3].unfocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  x_Controller[index - 3].clear();
                                },
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 230),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "x${index - 2}",
                              // errorBorder: InputBorder.none,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextField(
                            controller: y_Controller[index - 3],
                            focusNode: y[index - 3],
                            onEditingComplete: () {
                              // if (password_Controller.text == "") {
                              //   FocusScope.of(context).requestFocus(password);
                              // } else {
                              y[index - 3].unfocus();
                              // }
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  y_Controller[index - 3].clear();
                                },
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 230),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "y${index - 2}",
                              // errorBorder: InputBorder.none,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<bool?> _showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text(
            'Do you want to leave this screen? (ALL data will lost)'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true); // Allow navigation
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel navigation
            },
          ),
        ],
      );
    },
  );
}
