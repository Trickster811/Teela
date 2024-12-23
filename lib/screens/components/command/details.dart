import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/screens/components/general/image_viewer.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class DetailsCommande extends StatelessWidget {
  final CommandeModel commande;
  const DetailsCommande({super.key, required this.commande});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left-2.4.svg',
            semanticsLabel: 'Arriw left',
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn,
            ),
            height: 30,
          ),
        ),
        title: const Text(
          'Details de la commande',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commande.customerName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              commande.customerPhone,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: commande.date
                                        .add(Duration(
                                            days: commande.duration.end))
                                        .difference(commande.date)
                                        .inDays <=
                                    3
                                ? primary200
                                : Colors.transparent,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '${commande.date.add(Duration(days: commande.duration.end)).difference(commande.date).inDays} jour${commande.duration.end > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: commande.date
                                          .add(Duration(
                                              days: commande.duration.end))
                                          .difference(commande.date)
                                          .inDays <=
                                      3
                                  ? Colors.white
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: neutral200,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewer(
                                  images: commande.modele.images,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                commande.modele.images[Random().nextInt(
                                  commande.modele.images.length,
                                )],
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/arrow-right-2.3.svg',
                                      semanticsLabel: 'Arriw left',
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).iconTheme.color!,
                                        BlendMode.srcIn,
                                      ),
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFFFCECE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary200,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Terminer',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Image.asset(
                  'assets/images/general/pattern_2_white.png',
                  fit: BoxFit.fitWidth,
                  width: double.maxFinite,
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
