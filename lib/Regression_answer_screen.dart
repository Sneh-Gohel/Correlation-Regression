// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tex/flutter_tex.dart';

class Regression_answer_screen extends StatefulWidget {
  int n = 1;
  List<TextEditingController> x_Controller = [];
  List<TextEditingController> y_Controller = [];
  Regression_answer_screen(this.n, this.x_Controller, this.y_Controller,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Regression_answer_screen(n, x_Controller, y_Controller);
}

class _Regression_answer_screen extends State<Regression_answer_screen> {
  int n = 1;
  List<TextEditingController> x_Controller = [];
  List<TextEditingController> y_Controller = [];
  List x = [];
  List y = [];
  List xx = [];
  List yy = [];
  List xy = [];
  double sum_x = 0;
  double sum_y = 0;
  double sum_xx = 0;
  double sum_yy = 0;
  double sum_xy = 0;
  double byx_ff_2_1 = 0;
  double byx_ff_2_2 = 0;
  double byx_ff_3_1 = 0;
  double byx_ff_3_2 = 0;
  double bxy_ff_2_1 = 0;
  double bxy_ff_2_2 = 0;
  double bxy_ff_3_1 = 0;
  double bxy_ff_3_2 = 0;
  double r_ff_2_1 = 0;
  double byx = 0;
  double bxy = 0;
  double r = 0;
  late double ax = double.parse(x_Controller[(n / 2).round() - 1].text);
  late double ay = double.parse(y_Controller[(n / 2).round() - 1].text);
  bool loading_screen = true;

  _Regression_answer_screen(
    this.n,
    this.x_Controller,
    this.y_Controller,
  );

  fill_table() {
    for (int i = 0; i < n; i++) {
      setState(() {
        x.add(int.parse(x_Controller[i].text));
        y.add(int.parse(y_Controller[i].text));
        xx.add(x[i] * x[i]);
        yy.add(y[i] * y[i]);
        xy.add(x[i] * y[i]);
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
        sum_xx += xx[i];
        sum_yy += yy[i];
        sum_xy += xy[i];
      });
    }

    byx_ff_2_1 = ((sum_x * sum_y) / n);
    byx_ff_2_2 = ((sum_x * sum_x) / n);

    byx_ff_3_1 = (sum_xy - byx_ff_2_1);
    byx_ff_3_2 = (sum_xx - byx_ff_2_2);

    byx = (byx_ff_3_1 / byx_ff_3_2);

    bxy_ff_2_1 = ((sum_x * sum_y) / n);
    bxy_ff_2_2 = ((sum_y * sum_y) / n);

    bxy_ff_3_1 = (sum_xy - bxy_ff_2_1);
    bxy_ff_3_2 = (sum_yy - bxy_ff_2_2);

    bxy = (bxy_ff_3_1 / bxy_ff_3_2);

    r_ff_2_1 = (bxy * byx);

    r = sqrt(r_ff_2_1);

    setState(() {
      loading_screen = false;
    });
  }

  String generateFormula() {
    return r'\(r = \frac{{' +
        '$n \\cdot \\sum(XY) - \\sum(X) \\cdot \\sum(Y)' +
        '}}{{' +
        '\\sqrt{{' +
        '(n \\cdot \\sum(X^2) - (\\sum(X))^2) \\cdot (n \\cdot \\sum(Y^2) - (\\sum(Y))^2)' +
        '}}' +
        r'}}\)';
  }

  String byx_fill_formula_1() {
    String formula = r'\(\therefore byx = \frac{(' +
        sum_xy.toStringAsFixed(4) +
        ') - \\frac{(' +
        sum_x.toStringAsFixed(4) +
        ')(' +
        sum_y.toStringAsFixed(4) +
        ')}{(' +
        n.toString() +
        ')}}{(' +
        sum_xx.toStringAsFixed(4) +
        ') - \\frac{(' +
        sum_x.toStringAsFixed(4) +
        ')^2}{(' +
        n.toString() +
        ')}} \\)';

    return formula;
  }

  String byx_fill_formula_2() {
    String formula = r'\(\therefore byx = \frac{(' +
        sum_xy.toString() +
        ') - (' +
        byx_ff_2_1.toString() +
        ')}{(' +
        sum_xx.toString() +
        ') - (' +
        byx_ff_2_2.toString() +
        ')} \\)';

    return formula;
  }

  String byx_fill_formula_3() {
    String formula = r'\(\therefore byx = \frac{' +
        byx_ff_3_1.toStringAsFixed(4) +
        '}{' +
        byx_ff_3_2.toStringAsFixed(4) +
        '} \\)';

    return formula;
  }

  String print_byx() {
    String formula = r'\(\therefore byx = ' + byx.toStringAsFixed(4) + '\\)';

    return formula;
  }

  String bxy_fill_formula_1() {
    String formula = r'\(\therefore bxy = \frac{(' +
        sum_xy.toStringAsFixed(4) +
        ') - \\frac{(' +
        sum_x.toStringAsFixed(4) +
        ')(' +
        sum_y.toStringAsFixed(4) +
        ')}{(' +
        n.toString() +
        ')}}{(' +
        sum_yy.toStringAsFixed(4) +
        ') - \\frac{(' +
        sum_y.toStringAsFixed(4) +
        ')^2}{(' +
        n.toString() +
        ')}} \\)';

    return formula;
  }

  String bxy_fill_formula_2() {
    String formula = r'\(\therefore bxy = \frac{(' +
        sum_xy.toString() +
        ') - (' +
        bxy_ff_2_1.toString() +
        ')}{(' +
        sum_xx.toString() +
        ') - (' +
        bxy_ff_2_2.toString() +
        ')} \\)';

    return formula;
  }

  String bxy_fill_formula_3() {
    String formula = r'\(\therefore bxy = \frac{' +
        bxy_ff_3_1.toStringAsFixed(4) +
        '}{' +
        bxy_ff_3_2.toStringAsFixed(4) +
        '} \\)';

    return formula;
  }

  String print_bxy() {
    String formula = r'\(\therefore bxy = ' + bxy.toStringAsFixed(4) + '\\)';

    return formula;
  }

  String r_fill_formula_1() {
    String formula = r'\(\therefore r = \sqrt{(' +
        bxy.toStringAsFixed(4) +
        ') (' +
        byx.toStringAsFixed(4) +
        ')} \\)';

    return formula;
  }

  String r_fill_formula_2() {
    String formula =
        r'\(\therefore r = \sqrt{' + r_ff_2_1.toStringAsFixed(4) + '} \\)';

    return formula;
  }

  String print_r() {
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
              itemCount: n + 21,
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
                          width: screenWidth / 5,
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
                          width: screenWidth / 5,
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
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "x^2",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "y^2",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Center(
                            child: Text(
                              "xy",
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
                        width: screenWidth / 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_x.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_y.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_xx.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_yy.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "= ${sum_xy.toStringAsFixed(2)}",
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
                      "-> For regression line y on x.",
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
                        r'\(byx = \frac{\sum{xy} - \frac{\sum{x}\sum{y}}{n}}{\sum{x^2 - \frac{(\sum{x})^2}{n}}} \)',
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
                        byx_fill_formula_1(),
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
                        byx_fill_formula_2(),
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
                        byx_fill_formula_3(),
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
                        print_byx(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 10) {
                  // formula print
                  return const Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: Text(
                      "-> For regression line x on y.",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  );
                } else if (index == n + 11) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: const TeXViewDocument(
                        r'\(bxy = \frac{\sum{xy} - \frac{\sum{x}\sum{y}}{n}}{\sum{y^2 - \frac{(\sum{y})^2}{n}}} \)',
                      ),
                      style: TeXViewStyle(
                        fontStyle: TeXViewFontStyle(fontSize: 25),
                      ),
                    ),
                  );
                } else if (index == n + 12) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        bxy_fill_formula_1(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 13) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        bxy_fill_formula_2(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 14) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        bxy_fill_formula_3(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 15) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        print_bxy(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 16) {
                  return const Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: Text(
                      "-> Now, correlation corfficient...",
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  );
                } else if (index == n + 17) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: const TeXViewDocument(
                        r'\(r = \sqrt{bxy byx} \)',
                      ),
                      style: TeXViewStyle(
                        fontStyle: TeXViewFontStyle(fontSize: 25),
                      ),
                    ),
                  );
                } else if (index == n + 18) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        r_fill_formula_1(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 19) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        r_fill_formula_2(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else if (index == n + 20) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 50, bottom: 10),
                    child: TeXView(
                      renderingEngine: const TeXViewRenderingEngine.katex(),
                      child: TeXViewDocument(
                        print_r(),
                      ),
                      style: TeXViewStyle(
                          fontStyle: TeXViewFontStyle(fontSize: 25)),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 5,
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
                          width: screenWidth / 5,
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
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                xx[index - 3].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                yy[index - 3].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth / 5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                xy[index - 3].toStringAsFixed(2),
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
              },
            ),
    );
  }
}
