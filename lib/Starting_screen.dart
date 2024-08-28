// ignore_for_file: camel_case_types, file_names, unused_field

import 'dart:async';
import 'package:correlation_and_regression/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Starting_screen extends StatefulWidget {
  const Starting_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Starting_screen();
}

class _Starting_screen extends State<Starting_screen> {
  late VideoPlayerController _controller;
  late Timer _timer;
  // bool is_tick = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.asset('res/videos/logo.mp4')
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home_screen()),
              );
              _timer.cancel();
            });
          });
        });
    } catch (e) {
      print("Getting error");
    }
    _controller.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
