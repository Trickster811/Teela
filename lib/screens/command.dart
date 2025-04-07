import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/screens/components/catalogue/search.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int documentLimit = 15;

  // Check the app is currently fetching commande data
  bool isFetchingCommande = false;

  bool _hasNextCommande = true;
  final scrollController = ScrollController();
  bool internetAccess = true;

  // List of commande
  List<Map<String, dynamic>> ownerCommande = CommandeTeela.ownerCommandes;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    // Listening for tab change event
    _controller!.addListener(() {
      setState(() {});
    });
    scrollController.addListener(scrollListener);
    // if (CommandeTeela.ownerCommandes.isEmpty) {
    retrieveCommande();
    // } else {
    // _hasNextCommande = false;
    // }
  }

  @override
  void dispose() {
    _controller!.dispose();

    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange &&
        _hasNextCommande) {
      retrieveCommande();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 100.0,
              child: TextField(
                onTap:
                    () => showSearch(
                      context: context,
                      delegate: Search(searchKey: 'Modeles'),
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
            ),
            GestureDetector(
              onTap: () async {
                CommandeTeela.ownerCommandes = [];
                setState(() {
                  internetAccess = true;
                  _hasNextCommande = true;
                });
                retrieveCommande();
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: neutral200,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Icon(Icons.cached_rounded),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        TabBar(
          controller: _controller,
          padding: EdgeInsets.zero,
          indicatorColor: Colors.transparent,
          dividerHeight: 0,
          dividerColor: Colors.transparent,
          tabs: [
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'En attente',
                    style: TextStyle(
                      color:
                          _controller!.index == 0
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_controller!.index == 0)
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: primary200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Termines',
                    style: TextStyle(
                      color:
                          _controller!.index == 1
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_controller!.index == 1)
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: primary200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Livres',
                    style: TextStyle(
                      color:
                          _controller!.index == 2
                              ? primary200
                              : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_controller!.index == 2)
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: primary200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.maxFinite,
          child: SvgPicture.asset(
            'assets/images/general/pattern_2.svg',
            colorFilter: const ColorFilter.mode(neutral700, BlendMode.srcIn),
            fit: BoxFit.fill,
            // width: MediaQuery.of(context).size.height,
          ),
        ),
        const SizedBox(height: 10.0),
        !internetAccess
            ? Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  for (var index in [1, 2, 3])
                    Container(
                      key: Key(index.toString()),
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
                                  _hasNextCommande = true;
                                });
                                retrieveCommande();
                              },
                              child: Text(
                                'Réessayer',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
            : ownerCommande.isEmpty && !_hasNextCommande
            ? Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  for (var index in [1, 2, 3])
                    Container(
                      key: Key(index.toString()),
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
                            'Aucun Commande à afficher',
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
                                _hasNextCommande = true;
                              });
                              retrieveCommande();
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
            : Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        for (Map<String, dynamic> commande in ownerCommande
                            .where((item) => item['status'] == 1)) ...[
                          ItemBuilder.commandeItemBuilder(
                            onTap: () {
                              CommandeTeela.ownerCommandes = [];
                              setState(() {
                                internetAccess = true;
                                _hasNextCommande = true;
                              });
                              retrieveCommande();
                            },
                            context: context,
                            commande: CommandeModel(
                              customerMesures: commande['customerMesures'],
                              customerName: commande['customerName'],
                              customerPhone: commande['customerPhone'],
                              date: DateTime.parse(commande['date']),
                              details: commande['details'],
                              duration: commande['duration'],
                              id: commande['_id'],
                              modele: ModeleModel(
                                description: commande['Modele']['description'],
                                duration: SfRangeValues(
                                  commande['Modele']['duration'][0],
                                  commande['Modele']['duration'][1],
                                ),
                                id: commande['Modele']['_id'],
                                images: commande['Modele']['images'],
                                maxPrice:
                                    int.tryParse(
                                      commande['Modele']['max_price']
                                          .toString(),
                                    )!,
                                minPrice:
                                    int.tryParse(
                                      commande['Modele']['min_price']
                                          .toString(),
                                    )!,
                                title: commande['Modele']['title'],
                              ),
                              price: int.tryParse(commande['price'])!,
                              versements: commande['versements'],
                              status: commande['status'],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                        if (_hasNextCommande)
                          const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        for (Map<String, dynamic> commande in ownerCommande
                            .where((item) => item['status'] == 2)) ...[
                          ItemBuilder.commandeItemBuilder(
                            onTap: () {
                              CommandeTeela.ownerCommandes = [];
                              setState(() {
                                internetAccess = true;
                                _hasNextCommande = true;
                              });
                              retrieveCommande();
                            },
                            context: context,
                            commande: CommandeModel(
                              customerMesures: commande['customerMesures'],
                              customerName: commande['customerName'],
                              customerPhone: commande['customerPhone'],
                              date: DateTime.parse(commande['date']),
                              details: commande['details'],
                              duration: commande['duration'],
                              id: commande['_id'],
                              modele: ModeleModel(
                                description: commande['Modele']['description'],
                                duration: SfRangeValues(
                                  commande['Modele']['duration'][0],
                                  commande['Modele']['duration'][1],
                                ),
                                id: commande['Modele']['_id'],
                                images: commande['Modele']['images'],
                                maxPrice:
                                    int.tryParse(
                                      commande['Modele']['max_price']
                                          .toString(),
                                    )!,
                                minPrice:
                                    int.tryParse(
                                      commande['Modele']['min_price']
                                          .toString(),
                                    )!,
                                title: commande['Modele']['title'],
                              ),
                              price: int.tryParse(commande['price'])!,
                              versements: commande['versements'],
                              status: commande['status'],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                        if (_hasNextCommande)
                          const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        for (Map<String, dynamic> commande in ownerCommande
                            .where((item) => item['status'] == 3)) ...[
                          ItemBuilder.commandeItemBuilder(
                            onTap: () {
                              CommandeTeela.ownerCommandes = [];
                              setState(() {
                                internetAccess = true;
                                _hasNextCommande = true;
                              });
                              retrieveCommande();
                            },
                            context: context,
                            commande: CommandeModel(
                              customerMesures: commande['customerMesures'],
                              customerName: commande['customerName'],
                              customerPhone: commande['customerPhone'],
                              date: DateTime.parse(commande['date']),
                              details: commande['details'],
                              duration: commande['duration'],
                              id: commande['_id'],
                              modele: ModeleModel(
                                description: commande['Modele']['description'],
                                duration: SfRangeValues(
                                  commande['Modele']['duration'][0],
                                  commande['Modele']['duration'][1],
                                ),
                                id: commande['Modele']['_id'],
                                images: commande['Modele']['images'],
                                maxPrice:
                                    int.tryParse(
                                      commande['Modele']['max_price']
                                          .toString(),
                                    )!,
                                minPrice:
                                    int.tryParse(
                                      commande['Modele']['min_price']
                                          .toString(),
                                    )!,
                                title: commande['Modele']['title'],
                              ),
                              price: int.tryParse(commande['price'])!,
                              versements: commande['versements'],
                              status: commande['status'],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                        if (_hasNextCommande)
                          const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  Future retrieveCommande() async {
    if (!await Internet.checkInternetAccess()) {
      LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
      setState(() {
        internetAccess = false;
      });
      return;
    }

    if (isFetchingCommande) return;
    isFetchingCommande = true;

    if (!_hasNextCommande) {
      setState(() {
        _hasNextCommande = true;
      });
    }

    try {
      final commandeSnap = await CommandeTeela.retrieveMultiCommande(
        limit: documentLimit,
        // startAfter: CatalogueTeela.ownerCommandes.isNotEmpty
        //     ? CatalogueTeela.ownerCommandes.last['id']
        //     : null,
        owner: mongodb.ObjectId.parse(Auth.user!['_id']),
      );
      print(commandeSnap);
      ownerCommande = CommandeTeela.ownerCommandes;
      if (commandeSnap.length < documentLimit) {
        setState(() {
          _hasNextCommande = false;
        });
      }
    } catch (errno) {
      debugPrint(errno.toString());
      LocalPreferences.showFlashMessage(
        'Une erreur est survenue\nVeuillez verifier votre connexion internet',
        Colors.red,
      );
      setState(() {
        _hasNextCommande = false;
      });
    }
    setState(() {
      isFetchingCommande = false;
    });
  }
}
