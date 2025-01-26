import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teela/auth/sign_in.dart';
import 'package:teela/utils/color_scheme.dart';

class Onboard extends StatefulWidget {
  const Onboard({
    super.key,
  });

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );

    // Listening for tab change event
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          SafeArea(
            child: TabBarView(
              controller: _controller,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .65,
                      child: Stack(
                        children: [
                          SafeArea(
                            child: SvgPicture.asset(
                              'assets/images/welcome/lines_2.svg',
                              semanticsLabel: 'background illustration',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).iconTheme.color!,
                                BlendMode.srcIn,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * .37,
                              child: Image.asset(
                                'assets/images/welcome/sp1.png',
                                // height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .02,
                            right: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * .6,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_6.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .24,
                            left: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .18,
                              width: MediaQuery.of(context).size.width * .45,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 0,
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * .55,
                              child: Image.asset(
                                'assets/images/welcome/sp1.png',
                                // height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .34,
                              width: MediaQuery.of(context).size.width * .5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pour des couturiers',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .65,
                      child: Stack(
                        children: [
                          SafeArea(
                            child: Image.asset(
                              'assets/images/welcome/sp2.png',
                              height: MediaQuery.of(context).size.height * .5,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * .10,
                            right: MediaQuery.of(context).size.width * .24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 20; i++) ...[
                                  Container(
                                    width: 6.0,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!,
                                          width: 3.0,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                ]
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .1,
                            right: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .24,
                              width: MediaQuery.of(context).size.width * .7,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_4.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .02,
                            left: 20,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .22,
                              width: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: neutral100,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'assets/images/welcome/image_1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * .06,
                            left: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * .32,
                              width: MediaQuery.of(context).size.width * .4,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 4,
                                    color: neutral100,
                                  ),
                                  right: BorderSide(
                                    width: 4,
                                    color: neutral100,
                                  ),
                                ),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(5.0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_7.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 40,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .26,
                              width: MediaQuery.of(context).size.width * .38,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'assets/images/welcome/image_5.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Votre travail mis en avant',
                            style: TextStyle(
                              height: 1,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .65,
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.width * .6,
                            left: -MediaQuery.of(context).size.width * .5,
                            // bottom: 0,
                            child: Transform.rotate(
                              angle: -62,
                              child: SizedBox(
                                height: 50,
                                // width: MediaQuery.of(context).size.height*.3,
                                child: Image.asset(
                                  'assets/images/welcome/sp3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.width * .85,
                            left: -MediaQuery.of(context).size.width * .5,
                            // bottom: 0,
                            child: Transform.rotate(
                              angle: -56,
                              child: SizedBox(
                                height: 50,
                                // width: MediaQuery.of(context).size.height*.3,
                                child: Image.asset(
                                  'assets/images/welcome/sp3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.width * .35,
                            left: -MediaQuery.of(context).size.width * .5,
                            // bottom: 0,
                            child: Transform.rotate(
                              angle: 40,
                              child: SizedBox(
                                height: 50,
                                // width: MediaQuery.of(context).size.height*.3,
                                child: Image.asset(
                                  'assets/images/welcome/sp3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: MediaQuery.of(context).size.height * .075,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 20; i++) ...[
                                  Container(
                                    width: 6.0,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!,
                                          width: 3.0,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                ]
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .15,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 20; i++) ...[
                                  Container(
                                    width: 6.0,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!,
                                          width: 3.0,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                ]
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .02,
                            right: MediaQuery.of(context).size.width * .15,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * .7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_8.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * .24,
                            left: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .33,
                              width: MediaQuery.of(context).size.width * .5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_10.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 0,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .34,
                              width: MediaQuery.of(context).size.width * .45,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(5.0),
                                ),
                                child: Image.asset(
                                  'assets/images/welcome/image_9.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Votre atelier dans votre main',
                            style: TextStyle(
                              height: 1,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            // left: 10,
            // right: MediaQuery.of(context).size.width * .25,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    controller: _controller!,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: const EdgeInsets.only(
                      top: 13,
                      bottom: 15,
                    ),
                    // indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50000),
                      border: Border.all(
                        color: neutral1000,
                      ),
                    ),
                    dividerHeight: 0,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.center,
                    tabs: [
                      Tab(
                        icon: Container(
                          margin: const EdgeInsets.all(3.0),
                          alignment: Alignment.center,
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000),
                            color: _controller!.index >= 0
                                ? neutral1000
                                : neutral400,
                          ),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          margin: const EdgeInsets.all(3.0),
                          alignment: Alignment.center,
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000),
                            color: _controller!.index >= 1
                                ? neutral1000
                                : neutral400,
                          ),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          margin: const EdgeInsets.all(3.0),
                          alignment: Alignment.center,
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000),
                            color: _controller!.index >= 2
                                ? neutral1000
                                : neutral400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_controller!.index != 2) {
                        _controller!.animateTo(_controller!.index += 1);
                        return;
                      }

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                      return;
                    },
                    child: Row(
                      children: [
                        Text(
                          _controller!.index != 2 ? 'Continuer' : 'Commencer',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: _controller!.index != 2
                                ? FontWeight.normal
                                : FontWeight.w600,
                            color: _controller!.index != 2
                                ? Theme.of(context).iconTheme.color
                                : primary200,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (_controller!.index != 2)
                          SvgPicture.asset(
                            'assets/icons/arrow-right.svg',
                            semanticsLabel: 'next icon',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                        if (_controller!.index == 2)
                          SvgPicture.asset(
                            'assets/images/welcome/next_icon.svg',
                            semanticsLabel: 'next icon',
                          )
                      ],
                    ),
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
