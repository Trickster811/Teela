import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/screens/catalogue.dart';
import 'package:teela/screens/command.dart';
import 'package:teela/screens/components/command/add.dart';
import 'package:teela/screens/home.dart';
import 'package:teela/screens/profile.dart';
import 'package:teela/utils/color_scheme.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int currentPage = 0;
  // List of app main pages
  final List<Map> appPages = [
    {'title': 'Accueil', 'route': const Home()},
    {'title': 'Catalogue', 'route': const Catalogue()},
    {'title': 'Commande', 'route': const Command()},
    {'title': 'Profil', 'route': const Profile()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          currentPage == 0
              ? AppBar(
                scrolledUnderElevation: 0.0,
                automaticallyImplyLeading: false,
                title: SvgPicture.asset('assets/images/Teela.svg'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/solar_chart-2-linear.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/notification.3.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              )
              : AppBar(
                scrolledUnderElevation: 0.0,
                automaticallyImplyLeading: false,
                title: Text(
                  appPages[currentPage]['title'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
              ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: appPages[currentPage]['route'],
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 10.0,
          right: 20.0,
          bottom: 0.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 0;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/home.1.svg',
                    colorFilter: ColorFilter.mode(
                      currentPage == 0
                          ? primary200
                          : Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Accueil',
                    style: TextStyle(
                      color:
                          currentPage == 0
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 1;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/category.svg',
                    colorFilter: ColorFilter.mode(
                      currentPage == 1
                          ? primary200
                          : Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Catalogue',
                    style: TextStyle(
                      color:
                          currentPage == 1
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 2;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/document.4.svg',
                    colorFilter: ColorFilter.mode(
                      currentPage == 2
                          ? primary200
                          : Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Commande',
                    style: TextStyle(
                      color:
                          currentPage == 2
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 3;
                });
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/profile.2.svg',
                    colorFilter: ColorFilter.mode(
                      currentPage == 3
                          ? primary200
                          : Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Profil',
                    style: TextStyle(
                      color:
                          currentPage == 3
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCommande(commande: null),
              ),
            ),
        child: Container(
          height: 50.0,
          width: 50.0,
          // margin: EdgeInsets.only(
          //   left: 40,
          // ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: primary200,
          ),
          child: const Icon(Icons.add, size: 30.0, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
