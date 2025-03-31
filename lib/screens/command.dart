import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/screens/components/catalogue/search.dart';
import 'package:teela/screens/components/command/details.dart';
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
    if (CommandeTeela.ownerCommandes.isEmpty) {
      retrieveCommande();
    } else {
      _hasNextCommande = false;
    }
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
        TextField(
          onTap:
              () => showSearch(
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
                  Column(
                    children: [
                      for (Map<String, dynamic> commande in ownerCommande.where(
                        (item) => true,
                      )) ...[
                        commandeItemBuilder(
                          context: context,
                          commande: CommandeModel(
                            customerMesures: commande['customerMesures'],
                            customerName: commande['customerName'],
                            customerPhone: commande['customerPhone'],
                            date: DateTime.parse(commande['date']),
                            details: commande['details'],
                            duration: commande['duration'],
                            id: commande['_id'].toString().substring(
                              10,
                              commande['_id'].toString().length - 2,
                            ),
                            modele: ModeleModel(
                              description: commande['Modele']['description'],
                              duration: SfRangeValues(
                                commande['Modele']['duration'][0],
                                commande['Modele']['duration'][0],
                              ),
                              id: commande['Modele']['_id'],
                              images: commande['Modele']['images'],
                              maxPrice: commande['Modele']['max_price'],
                              minPrice: commande['Modele']['min_price'],
                              title: commande['Modele']['title'],
                            ),
                            price: commande['price'],
                            versements: commande['versements'],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                      if (_hasNextCommande)
                        const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                    ],
                  ),
                  const Column(),
                  const Column(),
                ],
              ),
            ),
      ],
    );
  }

  GestureDetector commandeItemBuilder({
    required BuildContext context,
    required CommandeModel commande,
  }) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsCommande(commande: commande),
            ),
          ),
      child: SizedBox(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                // commande.modele.images[Random().nextInt(
                //   commande.modele.images.length,
                // )],
                'https://img.freepik.com/free-photo/portrait-stylish-adult-male-looking-away_23-2148466055.jpg?t=st=1738419204~exp=1738422804~hmac=f8441cfa1e1fc3eb8720246d815d69a1b9a5cce90a8410b3de3c07b15ea7ecf3&w=360',
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commande.modele.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    commande.customerName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color:
                          commande.date
                                      .add(Duration(days: commande.duration))
                                      .difference(commande.date)
                                      .inDays <=
                                  3
                              ? primary200
                              : Colors.transparent,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${commande.date.add(Duration(days: commande.duration)).difference(commande.date).inDays} jour${commande.duration > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color:
                            commande.date
                                        .add(Duration(days: commande.duration))
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
            ),
            SizedBox(
              height: 80.0,
              width: 60,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: -10,
                    right: 0,
                    child: Text(
                      '${commande.date.add(Duration(days: commande.duration)).day}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 49,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -10,
                    child: Text(
                      DateFormat.MMM().format(
                        commande.date.add(Duration(days: commande.duration)),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 29,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        owner: Auth.user!['_id'].toString(),
      );
      print(commandeSnap);
      ownerCommande = CommandeTeela.ownerCommandes;
      if (commandeSnap.length < documentLimit) {
        setState(() {
          _hasNextCommande = false;
        });
      }
    } on PostgrestException catch (errno) {
      debugPrint(errno.toString());
      LocalPreferences.showFlashMessage(errno.message.toString(), Colors.red);
      setState(() {
        _hasNextCommande = false;
      });
    }
    setState(() {
      isFetchingCommande = false;
    });
  }
}
