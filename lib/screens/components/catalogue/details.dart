import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teela/screens/components/catalogue/model-catalogue/add.dart';
import 'package:teela/screens/components/catalogue/model-catalogue/details.dart';
import 'package:teela/screens/components/catalogue/search.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class DetailsCatalogue extends StatelessWidget {
  final CatalogueModel catalogueModel;

  const DetailsCatalogue({
    super.key,
    required this.catalogueModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
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
        title: Text(
          catalogueModel.title,
          style: const TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100.0,
                          child: TextField(
                            onTap: () => showSearch(
                              context: context,
                              delegate: Search(searchKey: 'Modeles'),
                            ),
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
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
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: neutral200,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 15.0,
                          children: [
                            for (ModeleModel item in catalogueModel.modeles
                                .getRange(
                                    0,
                                    (catalogueModel.modeles.length / 2)
                                        .round()))
                              modeleBuilder(context, item)
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 15.0,
                          children: [
                            for (ModeleModel item in catalogueModel.modeles
                                .getRange(
                                    (catalogueModel.modeles.length / 2).round(),
                                    catalogueModel.modeles.length))
                              modeleBuilder(context, item)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 90.0,
              left: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      '02 realise${2 > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: primary200,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      '04 en attente${4 > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddModele(
              catalogue: catalogueModel,
              modele: null,
            ),
          ),
        ),
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: primary200,
          ),
          child: const Icon(
            Icons.add,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  GestureDetector modeleBuilder(BuildContext context, ModeleModel item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsModele(
            catalogue: catalogueModel,
            modele: item,
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
                      'Quelle action souhaitex-vous effectuer sur ce modele?',
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
                            builder: (context) => AddModele(
                              catalogue: catalogueModel,
                              modele: item,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: !item.images[0].contains('http')
            ? Image.asset(
                'assets/images/catalogue/img_1.png',
                // item.images[0],
                fit: BoxFit.cover,
                height: Random().nextInt(250) + 100,
                width: MediaQuery.of(context).size.width * .5 - 30.0,
              )
            : Image.network(
                item.images[0],
                fit: BoxFit.cover,
                height: Random().nextInt(250) + 100,
                width: MediaQuery.of(context).size.width * .5 - 30.0,
              ),
      ),
    );
  }
}
