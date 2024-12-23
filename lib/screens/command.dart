import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/screens/components/catalogue/search.dart';
import 'package:teela/screens/components/command/details.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );

    // Listening for tab change event
    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  List<CommandeModel> commandes = [
    CommandeModel(
      customerName: 'Maryline Kamgueng',
      customerPhone: '+23760786195',
      date: DateTime.now(),
      duration: const SfRangeValues(1, 9),
      modele: const ModeleModel(
        title: 'Nom du model',
        description:
            'Aenean nec odio vel ante porttitor sagittis in vel erat. Nam a ex tristique sapien dapibus mollis vel nec lacus. Donec et diam a mi accumsan placerat.',
        duration: SfRangeValues(1, 9),
        images: [
          'assets/images/catalogue/img_1.png',
          'assets/images/catalogue/img_2.png',
        ],
        minPrice: 0,
        maxPrice: 0,
        state: false,
      ),
      price: 7000,
      versements: [],
    ),
    CommandeModel(
      customerName: 'Maryline Kamgueng',
      customerPhone: '+23760786195',
      date: DateTime.now(),
      duration: const SfRangeValues(1, 5),
      modele: const ModeleModel(
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
        state: false,
      ),
      price: 7000,
      versements: [],
    ),
    CommandeModel(
      customerName: 'Maryline Kamgueng',
      customerPhone: '+23760786195',
      date: DateTime.now(),
      duration: const SfRangeValues(1, 5),
      modele: const ModeleModel(
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
        state: false,
      ),
      price: 7000,
      versements: [],
    ),
    CommandeModel(
      customerName: 'Maryline Kamgueng',
      customerPhone: '+23760786195',
      date: DateTime.now(),
      duration: const SfRangeValues(1, 5),
      modele: const ModeleModel(
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
        state: false,
      ),
      price: 7000,
      versements: [],
    ),
    CommandeModel(
      customerName: 'Maryline Kamgueng',
      customerPhone: '+23760786195',
      date: DateTime.now(),
      duration: const SfRangeValues(1, 5),
      modele: const ModeleModel(
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
        state: false,
      ),
      price: 7000,
      versements: [],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 5.0,
        ),
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
                      color: _selectedIndex == 0
                          ? primary200
                          : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_selectedIndex == 0)
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
                      color: _selectedIndex == 1
                          ? primary200
                          : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_selectedIndex == 1)
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
                      color: _selectedIndex == 2
                          ? primary200
                          : Theme.of(context).iconTheme.color,
                    ),
                  ),
                  if (_selectedIndex == 2)
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
        SvgPicture.asset(
          'assets/images/general/pattern_2.svg',
          colorFilter: const ColorFilter.mode(
            neutral700,
            BlendMode.srcIn,
          ),
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.height,
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              Column(
                children: [
                  for (CommandeModel commande in commandes) ...[
                    commandeItemBuilder(context, commande),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ]
                ],
              ),
              const Column(),
              const Column(),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector commandeItemBuilder(
      BuildContext context, CommandeModel commande) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsCommande(
            commande: commande,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              commande.modele.images[Random().nextInt(
                commande.modele.images.length,
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
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: commande.date
                                  .add(Duration(days: commande.duration.end))
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
                                    .add(Duration(days: commande.duration.end))
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
                    '${commande.date.add(Duration(days: commande.duration.end)).day}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 49),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -10,
                  child: Text(
                    DateFormat.MMM().format(commande.date
                        .add(Duration(days: commande.duration.end))),
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
    );
  }
}
