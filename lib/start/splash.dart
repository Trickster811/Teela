import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teela/start/start.dart';
import 'package:teela/start/onboard.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/local.dart';

class Splash extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  const Splash({
    super.key,
    required this.userInfo,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // startTime();
    start();
  }

  start() async {
    bool? firstTime = LocalPreferences.getFirstTime();

    if ((firstTime != null && firstTime)) {
      startTime();
    } else {
      startTime1();
    }
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  startTime1() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route1);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Start(
          userInfo: widget.userInfo,
        ),
      ),
    );
  }

  route1() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Onboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: [
                        Container(
                          color: primary500,
                        ),
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.transparent,
                        ),
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.transparent,
                        ),
                        Container(
                          color: Colors.transparent,
                        ),
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: secondary500,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text('by OHO'),
                  Container(
                    height: 2,
                    width: 120,
                    color: primary500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
