import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  int documentLimit = 15;

  // Check the app is currently fetching commande data
  bool isFetchingCommande = false;

  bool _hasNextCommande = true;
  bool internetAccess = true;

  // List of commande
  List<Map<String, dynamic>> ownerCommande = CommandeTeela.ownerCommandes;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    // if (CommandeTeela.ownerCommandes.isEmpty) {
    retrieveCommande();
    // } else {
    // _hasNextCommande = false;
    // }
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
        _hasNextCommande) {
      retrieveCommande();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        CommandeTeela.ownerCommandes = [];
        setState(() {
          internetAccess = true;
          _hasNextCommande = true;
        });
        retrieveCommande();
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      color: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).iconTheme.color,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques de ${DateFormat.yMMMM('fr_FR').format(DateTime.now())}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        // height: 120,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/wallet-money-linear.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Revenus',
                                  style: TextStyle(
                                    color: neutral800,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            Text(
                              '${NumberFormat().format(ownerCommande.where((item) => item['status'] == 1 && DateUtils.isSameMonth(DateTime.now(), DateTime.parse(item['date']))).fold<num>(0, (sum, amount) => sum + amount['versements'].values.reduce((x, y) => x + y)))} Fcfa',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        // height: 120,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/hand-coins.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'A percevoir',
                                  style: TextStyle(
                                    color: neutral800,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            Text(
                              '${NumberFormat().format(ownerCommande.where((item) => item['status'] == 1 && DateUtils.isSameMonth(DateTime.now(), DateTime.parse(item['date']))).fold<num>(0, (sum, amount) => sum + (int.tryParse(amount['price'])! - amount['versements'].values.reduce((x, y) => x + y))))} Fcfa',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        // height: 120,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/time-circle.2.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat().format(
                                        ownerCommande
                                            .where(
                                              (item) =>
                                                  item['status'] == 1 &&
                                                  DateUtils.isSameMonth(
                                                    DateTime.now(),
                                                    DateTime.parse(
                                                      item['date'],
                                                    ),
                                                  ),
                                            )
                                            .length,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                      ),
                                    ),
                                    Text(
                                      'En cours',
                                      style: TextStyle(
                                        color: neutral800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        // height: 120,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/discount.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat().format(
                                        ownerCommande
                                            .where(
                                              (item) =>
                                                  item['status'] == 2 &&
                                                  DateUtils.isSameMonth(
                                                    DateTime.now(),
                                                    DateTime.parse(
                                                      item['date'],
                                                    ),
                                                  ),
                                            )
                                            .length,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                      ),
                                    ),
                                    Text(
                                      'Termines',
                                      style: TextStyle(
                                        color: neutral800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        // height: 120,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10000),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/package-check.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat().format(
                                        ownerCommande
                                            .where(
                                              (item) =>
                                                  item['status'] == 3 &&
                                                  DateUtils.isSameMonth(
                                                    DateTime.now(),
                                                    DateTime.parse(
                                                      item['date'],
                                                    ),
                                                  ),
                                            )
                                            .length,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                      ),
                                    ),
                                    Text(
                                      'Livres',
                                      style: TextStyle(
                                        color: neutral800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Commandes en cours',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Tout voir',
                  style: TextStyle(color: neutral600, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            !internetAccess
                ? Container(
                  alignment: Alignment.center,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : ownerCommande.isEmpty && !_hasNextCommande
                ? Container(
                  alignment: Alignment.center,
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
                    for (Map<String, dynamic> commande in ownerCommande.where(
                      (item) => item['status'] == 1,
                    )) ...[
                      ItemBuilder.commandeItemBuilder(
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
                                  commande['Modele']['max_price'].toString(),
                                )!,
                            minPrice:
                                int.tryParse(
                                  commande['Modele']['min_price'].toString(),
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
