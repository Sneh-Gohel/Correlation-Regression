// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Spearman_man_correlation_answer_screen extends StatefulWidget {
  int n = 1;
  List<TextEditingController> x_Controller = [];
  List<TextEditingController> y_Controller = [];
  Spearman_man_correlation_answer_screen(
      this.n, this.x_Controller, this.y_Controller,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Spearman_man_correlation_answer_screen(n, x_Controller, y_Controller);
}

class _Spearman_man_correlation_answer_screen
    extends State<Spearman_man_correlation_answer_screen> {
  int radVal = 0;

  late TeXViewRenderingEngine renderingEngine;

  int n = 1;
  List<TextEditingController> x_Controller = [];
  List<TextEditingController> y_Controller = [];
  List x = [];
  List y = [];
  List d = [];
  List dd = [];
  double sum_x = 0;
  double sum_y = 0;
  double sum_dd = 0;
  double nn = 0;
  double sum_xy = 0;
  double ff_2_1 = 0;
  double ff_2_2 = 0;
  double ff_3_1 = 0;
  double r = 0;
  late double ax = double.parse(x_Controller[(n / 2).round() - 1].text);
  late double ay = double.parse(y_Controller[(n / 2).round() - 1].text);
  bool loading_screen = true;

  _Spearman_man_correlation_answer_screen(
    this.n,
    this.x_Controller,
    this.y_Controller,
  );

  fill_table() {
    for (int i = 0; i < n; i++) {
      setState(() {
        x.add(int.parse(x_Controller[i].text));
        y.add(int.parse(y_Controller[i].text));
        d.add(x[i] - y[i]);
        dd.add(d[i] * d[i]);
      });
    }
  }

  generate_answer() {
    setState(() {
      loading_screen = true;
    });
    fill_table();
    for (int i = 0; i < n; i++) {
      setState(() {
        sum_x += x[i];
        sum_y += y[i];
        sum_dd += dd[i];
      });
    }

    nn = n.toDouble() * n.toDouble();

    ff_2_1 = 6 * sum_dd;
    ff_2_2 = nn - 1;

    ff_3_1 = ff_2_1 / (n * ff_2_2);

    r = 1 - ff_3_1;

    setState(() {
      loading_screen = false;
    });
  }

  String generateFormula() {
    return r'\(\therefore r = \frac{{' +
        '$n \\cdot \\sum(XY) - \\sum(X) \\cdot \\sum(Y)' +
        '}}{{' +
        '\\sqrt{{' +
        '(n \\cdot \\sum(X^2) - (\\sum(X))^2) \\cdot (n \\cdot \\sum(Y^2) - (\\sum(Y))^2)' +
        '}}' +
        r'}}\)';
  }

  String fill_formula_1() {
    String formula = r'\(\therefore r = 1- \frac{6(' +
        sum_dd.toStringAsFixed(4) +
        ')}{' +
        n.toString() +
        '((' +
        n.toString() +
        ')^2-1)}\\)';

    return formula;
  }

  String fill_formula_2() {
    String formula = r'\(\therefore r = 1- \frac{' +
        ff_2_1.toString() +
        '}{' +
        n.toString() +
        '(' +
        ff_2_2.toString() +
        ')}\\)';

    return formula;
  }

  String fill_formula_3() {
    String formula =
        r'\(\therefore r = 1- ' + ff_3_1.toStringAsFixed(4) + '\\)';

    return formula;
  }

  String print_answer() {
    String formula = r'\(\therefore r = ' + r.toStringAsFixed(4) + '\\)';

    return formula;
  }

  @override
  void initState() {
    super.initState();
    late Timer _timer;
    setState(() {
      loading_screen = true;
    });
    generate_answer();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        loading_screen = false;
        _timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    renderingEngine = radVal == 0
        ? const TeXViewRenderingEngine.katex()
        : const TeXViewRenderingEngine.mathjax();

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.brown,
        elevation: 10,
        title: const Text("Answer"),
      ),
      body: loading_screen
          ? const Center(
              child: SpinKitWave(
                color: Colors.green,
                size: 35.0,
              ),
              // child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: n + 13,
              itemBuilder: (contax, index) {
                if (index == 0) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "n = $n",
                        style:
                            const TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: .5)),
                        ),
                        Container(
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: .5)),
                        ),
                      ],
                    ),
                  );
                } else if (index == 2) {
                  return Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "x",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "y",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "d = x - y",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "d^2",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (index == n + 3) {
                  return Row(
                    children: [
                      Container(
                        width: screenWidth / 4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_dd.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (index == n + 4) {
                  // formula print
                  return const Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: Text(
                      "-> The Spearman's rank cofficient of correlation is ...",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  );
                } else if (index == n + 5) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: const TeXViewDocument(
                        r'\(r = 1- \frac{6\sum{d^2}}{n(n^2-1)}\)',
                      ),
                      style: TeXViewStyle(
                        fontStyle: TeXViewFontStyle(fontSize: 25),
                      ),
                    ),
                  );
                } else if (index == n + 6) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        fill_formula_1(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 7) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        fill_formula_2(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 8) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        fill_formula_3(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 9) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        print_answer(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 10) {
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Expanded(
                      child: SlideAction(
                        onSubmit: () {
                          return null;
                        },
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                x_Controller[index - 3].text,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                y_Controller[index - 3].text,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                d[index - 3].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                dd[index - 3].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
    );
  }
}
