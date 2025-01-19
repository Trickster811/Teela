import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/screens/components/catalogue/add.dart';
import 'package:teela/screens/components/catalogue/details.dart';
import 'package:teela/screens/components/catalogue/search.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class Catalogue extends StatelessWidget {
  const Catalogue({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            onTap: () => showSearch(
              context: context,
              delegate: Search(searchKey: 'Catalogue'),
            ),
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  'assets/icons/search.5.svg',
                  colorFilter: const ColorFilter.mode(
                    neutral700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.only(
                right: 10.0,
              ),
              filled: true,
              fillColor: neutral200,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: neutral200),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: neutral200),
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              hintText: 'Rechercher...',
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCatalogue(
                  catalogueModel: null,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 40.0,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Expanded(
                  child: SizedBox(
                    height: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nouveau',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Ajouter un nouveau catalogue',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          for (var item in [1, 2, 3, 4, 5, 6, 6]) ...[
            catalogueItemBuilder(
              catalogue: const CatalogueModel(
                description: 'Des vetements refletants les coutumes',
                modeles: [
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                  ModeleModel(
                    title: 'Nom du model',
                    description:
                        'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
                    duration: SfRangeValues(1, 5),
                    images: [
                      'assets/images/catalogue/img_1.png',
                      'assets/images/catalogue/img_2.png',
                    ],
                    minPrice: 0,
                    maxPrice: 0,
                  ),
                ],
                title: 'Modeles traditionels',
              ),
              context: context,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  GestureDetector catalogueItemBuilder({
    required BuildContext context,
    required CatalogueModel catalogue,
  }) {
    int randomModeleToDisplay = Random().nextInt(catalogue.modeles.length);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsCatalogue(
            catalogueModel: catalogue,
          ),
        ),
      ),
      onLongPress: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          message: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actions',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Text(
                      'Quelle action souhaitex-vous effectuer sur ce catalogue?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCatalogue(
                              catalogueModel: catalogue,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: primary200,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/edit.svg',
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              'Editer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/delete.6.svg',
                              colorFilter: const ColorFilter.mode(
                                primary200,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              'Supprimer',
                              style: TextStyle(
                                color: primary200,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              catalogue.modeles[randomModeleToDisplay].images[Random().nextInt(
                catalogue.modeles[randomModeleToDisplay].images.length,
              )],
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: SizedBox(
              height: 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    catalogue.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    catalogue.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${catalogue.modeles.length} modele${catalogue.modeles.length > 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
