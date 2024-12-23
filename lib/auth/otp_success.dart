import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/start/start.dart';
import 'package:teela/utils/color_scheme.dart';

class OtpSuccess extends StatelessWidget {
  const OtpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * .22,
            child: SvgPicture.asset(
              'assets/images/auth/lines.svg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    // fit: StackFit.expand,
                    children: [
                      SafeArea(
                        child: SvgPicture.asset(
                          'assets/images/auth/Success_auth_icon.svg',
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .1,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: secondary400,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      ...[
                        Positioned(
                          top: MediaQuery.of(context).size.height * .15,
                          left: MediaQuery.of(context).size.width * .4,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceOut,
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: secondary400,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .17,
                          left: MediaQuery.of(context).size.width * .27,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .08,
                          left: MediaQuery.of(context).size.width * .2,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .18,
                          left: MediaQuery.of(context).size.width * .15,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .23,
                          left: MediaQuery.of(context).size.width * .34,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .28,
                          left: MediaQuery.of(context).size.width * .26,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .26,
                          left: MediaQuery.of(context).size.width * .13,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ],
                      ...[
                        Positioned(
                          top: MediaQuery.of(context).size.height * .14,
                          right: MediaQuery.of(context).size.width * .4,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .11,
                          right: MediaQuery.of(context).size.width * .35,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .07,
                          right: MediaQuery.of(context).size.width * .18,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .18,
                          right: MediaQuery.of(context).size.width * .3,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .18,
                          right: MediaQuery.of(context).size.width * .18,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .22,
                          right: MediaQuery.of(context).size.width * .24,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .29,
                          right: MediaQuery.of(context).size.width * .3,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .26,
                          right: MediaQuery.of(context).size.width * .15,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: secondary400,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Le numero a ete verifie',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Start(
                          userInfo: {},
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary200,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Continuer',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
