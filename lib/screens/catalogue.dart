import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/screens/components/catalogue/add.dart';
import 'package:teela/screens/components/catalogue/details.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  int documentLimit = 15;

  // Check the app is currently fetching catalogue data
  bool isFetchingCatalogue = false;

  bool _hasNextCatalogue = true;
  final scrollController = ScrollController();
  bool internetAccess = true;

  // List of catalogue
  List<Map<String, dynamic>> ownerCatalogue = CatalogueTeela.ownerCatalogues;

  // Catalogue drop progress
  int? dropInProgress;

  // Search text
  final _controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    retrieveCatalogue();
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange &&
        _hasNextCatalogue) {
      retrieveCatalogue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        CatalogueTeela.ownerCatalogues = [];
        ModeleTeela.modeles = [];
        setState(() {
          internetAccess = true;
          _hasNextCatalogue = true;
        });
        retrieveCatalogue();
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      color: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).iconTheme.color,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            TextField(
              // onTap:
              //     () => showSearch(
              //       context: context,
              //       delegate: Search(searchKey: 'Catalogue'),
              //     ),
              // readOnly: true,
              onChanged: (value) => setState(() {}),
              controller: _controllerSearch,
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
                contentPadding: const EdgeInsets.only(right: 10.0),
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
                hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                hintText: 'Rechercher...',
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const AddCatalogue(catalogueModel: null),
                  ),
                );
                CatalogueTeela.ownerCatalogues = [];
                ModeleTeela.modeles = [];
                setState(() {
                  internetAccess = true;
                  _hasNextCatalogue = true;
                });
                retrieveCatalogue();
              },
              child: Row(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    padding: EdgeInsets.zero,
                    radius: const Radius.circular(15.0),
                    child: const SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Icon(Icons.add, size: 40.0),
                    ),
                  ),
                  const SizedBox(width: 10.0),
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            !internetAccess
                ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/no-internet.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color!,
                          BlendMode.srcIn,
                        ),
                        height: 75,
                        width: 75,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Pas d\'accès internet',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              internetAccess = true;
                              _hasNextCatalogue = true;
                            });
                            retrieveCatalogue();
                          },
                          child: Text(
                            'Réessayer',
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : ownerCatalogue.isEmpty && !_hasNextCatalogue
                ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/no-data.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color!,
                          BlendMode.srcIn,
                        ),
                        height: 75,
                        width: 75,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Aucun Catalogue à afficher',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            internetAccess = true;
                            _hasNextCatalogue = true;
                          });
                          retrieveCatalogue();
                        },
                        child: Container(
                          // alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).iconTheme.color,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Actualiser',
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : Column(
                  children: [
                    for (var item in ownerCatalogue.where((item) {
                      if (_controllerSearch.text == '') {
                        return true;
                      } else {
                        return item['title'].contains(_controllerSearch.text) ||
                            item['description'].contains(
                              _controllerSearch.text,
                            );
                      }
                    })) ...[
                      catalogueItemBuilder(
                        catalogue: CatalogueModel(
                          id: item['_id'],
                          description: item['description'],
                          modeles: [
                            for (var element in item['Modele'])
                              ModeleModel(
                                description: element['description'],
                                duration: SfRangeValues(
                                  element['duration'][0],
                                  element['duration'][1],
                                ),
                                id: element['_id'],
                                images: element['images'],
                                maxPrice: int.tryParse(element['max_price'])!,
                                minPrice: int.tryParse(element['min_price'])!,
                                title: element['title'],
                              ),
                          ],
                          title: item['title'],
                        ),
                        context: context,
                        itemIndex: ownerCatalogue.indexOf(item),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                    if (_hasNextCatalogue)
                      const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  Widget catalogueItemBuilder({
    required BuildContext context,
    required CatalogueModel catalogue,
    required int itemIndex,
  }) {
    return Stack(
      children: [
        SafeArea(
          child: GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetailsCatalogue(catalogueModel: catalogue),
                ),
              );
              CatalogueTeela.ownerCatalogues = [];
              ModeleTeela.modeles = [];
              setState(() {
                internetAccess = true;
                _hasNextCatalogue = true;
              });
              retrieveCatalogue();
            },
            onLongPress:
                () => showCupertinoModalPopup(
                  context: context,
                  builder:
                      (context) => CupertinoActionSheet(
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
                            const SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => AddCatalogue(
                                                catalogueModel: catalogue,
                                              ),
                                        ),
                                      );
                                      CatalogueTeela.ownerCatalogues = [];
                                      ModeleTeela.modeles = [];
                                      setState(() {
                                        internetAccess = true;
                                        _hasNextCatalogue = true;
                                      });
                                      retrieveCatalogue();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: primary200,
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
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
                                          const SizedBox(width: 10.0),
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
                                  const SizedBox(height: 5.0),
                                  GestureDetector(
                                    onTap: () async {
                                      dropCatalogue(catalogueId: catalogue.id);
                                      setState(() {
                                        dropInProgress = itemIndex;
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
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
                                          const SizedBox(width: 10.0),
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
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child:
                        catalogue.modeles.isNotEmpty
                            ? ItemBuilder.imageCardBuilder(
                              catalogue.modeles[0].images[0],
                            )
                            : Image.asset(
                              'assets/images/catalogue/img_1.png',
                              height: double.maxFinite,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                const SizedBox(width: 10.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                ),
              ],
            ),
          ),
        ),
        if (dropInProgress != null && dropInProgress == itemIndex)
          Positioned(
            child: Container(
              alignment: Alignment.center,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(200),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Suppression',
                    style: TextStyle(
                      color: primary200,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: primary200),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future retrieveCatalogue() async {
    if (!await Internet.checkInternetAccess()) {
      LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
      setState(() {
        internetAccess = false;
      });
      return;
    }

    if (isFetchingCatalogue) return;
    isFetchingCatalogue = true;

    if (!_hasNextCatalogue) {
      setState(() {
        _hasNextCatalogue = true;
      });
    }
    try {
      final catalogueSnap = await CatalogueTeela.retrieveMultiCatalogue(
        limit: documentLimit,
        // startAfter:
        //     CatalogueTeela.ownerCatalogues.isNotEmpty
        //         ? CatalogueTeela.ownerCatalogues.last['id']
        //         : null,
        owner: mongodb.ObjectId.parse(Auth.user!['_id']),
      );
      ownerCatalogue = CatalogueTeela.ownerCatalogues;
      // CatalogueTeela.ownerCatalogues = ownerCatalogue = catalogueSnap;
      if (catalogueSnap.length < documentLimit) {
        setState(() {
          _hasNextCatalogue = false;
        });
      }
    } catch (errno) {
      debugPrint(errno.toString());
      LocalPreferences.showFlashMessage(
        'Une erreur est survenue\nVeuillez verifier votre connexion internet',
        Colors.red,
      );
      setState(() {
        _hasNextCatalogue = false;
      });
    }
    setState(() {
      isFetchingCatalogue = false;
    });
  }

  Future dropCatalogue({required Object catalogueId}) async {
    if (!await Internet.checkInternetAccess()) {
      LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
      return;
    }
    try {
      mongodb.WriteResult response = await CatalogueTeela.deleteCatalogue(
        id: catalogueId,
      );
      if (response.isSuccess) {
        CatalogueTeela.ownerCatalogues.removeAt(dropInProgress!);
        LocalPreferences.showFlashMessage(
          'Catalogue supprime avec succes',
          Colors.green,
        );
        setState(() {
          dropInProgress = null;
        });
      }
    } catch (errno) {
      debugPrint(errno.toString());
      LocalPreferences.showFlashMessage(
        'Une erreur est survenue\nVeuillez verifier votre connexion internet',
        Colors.red,
      );
    }
  }
}
