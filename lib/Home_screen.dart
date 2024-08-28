// ignore_for_file: camel_case_types, file_names, unused_local_variable, non_constant_identifier_names

import 'package:correlation_and_regression/CAR_select_screen.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Home_screen();
}

class _Home_screen extends State<Home_screen> {
  final PageController _pageController = PageController(initialPage: 0);
  var image_details = {0: "COA_logo_image.png"};
  var name_details = {0: "Correlation And Regression"};

  screen_loader(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // return const COA_screen_1();
            return const CAR_select_screen();
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.brown,
        elevation: 10,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.home,
            size: 45,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            "Probability And Statistics",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          OrientationBuilder(
            builder: (context, orientation) {
              final int itemCount =
                  orientation == Orientation.landscape ? 6 : 3;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: itemCount,
                ),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
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
                          // margin: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double width = constraints.maxWidth;
                              double hight = constraints.maxHeight;
                              return ListView(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                            "res/images/${image_details[index]}"),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        name_details[index]!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
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
