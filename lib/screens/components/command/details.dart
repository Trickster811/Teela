import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:teela/screens/components/general/image_viewer.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class DetailsCommande extends StatefulWidget {
  final CommandeModel commande;
  const DetailsCommande({
    super.key,
    required this.commande,
  });

  @override
  State<DetailsCommande> createState() => _DetailsCommandeState();
}

class _DetailsCommandeState extends State<DetailsCommande> {
  bool selectedDescription =
      true; // To show either Command-Description type Text or type Image
  bool selectedMesures =
      true; // To show either Mesures type 'Haut du corps' or type 'Bas du corps'

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
        title: const Text(
          'Details de la commande',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showCupertinoModalPopup(
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
                            'Quelle action souhaitex-vous effectuer sur cette commande?',
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
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  message: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ajouter le dernier paiement?',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Montserrat',
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Le dernier paiement sera enregiste si vous confirmez cette option',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0,
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                        color: primary200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: const Text(
                                                        'Oui',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Montserrat',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0,
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        border: Border.all(
                                                          color: primary200,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      child: const Text(
                                                        'Non',
                                                        style: TextStyle(
                                                          color: primary200,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Montserrat',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: const Text(
                                            'Annuler',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                color: Colors.transparent,
                                border: Border.all(
                                  color: primary200,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Text(
                                'Valider le dernier paiement',
                                style: TextStyle(
                                  color: primary200,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: DottedBorder(
                              padding: EdgeInsets.zero,
                              child: const SizedBox(
                                width: double.maxFinite,
                              ),
                            ),
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
                              widget.commande.customerName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.commande.customerPhone,
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
                            color: widget.commande.date
                                        .add(Duration(
                                            days: widget.commande.duration))
                                        .difference(widget.commande.date)
                                        .inDays <=
                                    3
                                ? primary200
                                : Colors.transparent,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            '${widget.commande.date.add(Duration(days: widget.commande.duration)).difference(widget.commande.date).inDays} jour${widget.commande.duration > 1 ? 's' : ''}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: widget.commande.date
                                          .add(Duration(
                                              days: widget.commande.duration))
                                          .difference(widget.commande.date)
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
                      margin: const EdgeInsets.only(left: 10.0),
                      decoration: const BoxDecoration(
                        color: neutral200,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50.0),
                          right: Radius.circular(5.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewer(
                                  images: widget.commande.modele.images,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Transform.flip(
                                  flipX: true,
                                  child: Transform.rotate(
                                    angle: 275,
                                    origin: const Offset(-1, -5),
                                    child: Container(
                                      height: 80.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 275,
                                  origin: const Offset(-1, -5),
                                  child: Container(
                                    height: 80.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: !widget.commande.modele.images[0]
                                            .contains('http')
                                        ? Image.asset(
                                            widget.commande.modele.images[0],
                                            fit: BoxFit.cover,
                                            height: 80.0,
                                            width: 80.0,
                                          )
                                        : Image.network(
                                            widget.commande.modele.images[0],
                                            fit: BoxFit.cover,
                                            height: 80.0,
                                            width: 80.0,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.commande.modele.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'Voir le modele',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recu le :',
                              style: TextStyle(
                                color: neutral700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              DateFormat.yMMMd().format(widget.commande.date),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'A livre le :',
                              style: TextStyle(
                                color: neutral700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(widget.commande.date.add(
                                Duration(
                                  days: widget.commande.duration,
                                ),
                              )),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Paye :',
                              style: TextStyle(
                                color: neutral700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '${NumberFormat().format(
                                widget.commande.versements.values.fold<double>(
                                    0, (sum, amount) => sum + amount),
                              )} Fcfa',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'A payer :',
                              style: TextStyle(
                                color: neutral700,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '${NumberFormat().format(
                                widget.commande.price -
                                    widget.commande.versements.values
                                        .fold<double>(
                                            0, (sum, amount) => sum + amount),
                              )} Fcfa',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: neutral700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '${NumberFormat().format(widget.commande.price)} Fcfa',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: DottedBorder(
                        padding: EdgeInsets.zero,
                        child: const SizedBox(
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mesures',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            selectedMesures = true;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: selectedMesures
                                  ? Colors.transparent
                                  : neutral200,
                              border: Border.all(
                                color:
                                    selectedMesures ? primary200 : neutral200,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              'Haut du corps',
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    selectedMesures ? primary200 : neutral500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            selectedMesures = false;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: !selectedMesures
                                  ? Colors.transparent
                                  : neutral200,
                              border: Border.all(
                                color:
                                    !selectedMesures ? primary200 : neutral200,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              'Bas du corps',
                              style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    !selectedMesures ? primary200 : neutral500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: [
                        for (Map<String, dynamic> item
                            in widget.commande.customerMesures[
                                selectedMesures ? 'topBody' : 'downBody']!)
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            height: 60.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: neutral200,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3.0,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: primary200,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    item['abbr'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(item['value'].toString())
                              ],
                            ),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: DottedBorder(
                        padding: EdgeInsets.zero,
                        child: const SizedBox(
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            selectedDescription = true;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: selectedDescription
                                  ? Colors.transparent
                                  : neutral200,
                              border: Border.all(
                                color: selectedDescription
                                    ? primary200
                                    : neutral200,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              'Texte',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: selectedDescription
                                    ? primary200
                                    : neutral500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            selectedDescription = false;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: !selectedDescription
                                  ? Colors.transparent
                                  : neutral200,
                              border: Border.all(
                                color: !selectedDescription
                                    ? primary200
                                    : neutral200,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              'Images',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: !selectedDescription
                                    ? primary200
                                    : neutral500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    selectedDescription
                        ? widget.commande.details['text'] != null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.commande.details['text'],
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            : const Text(
                                'Aucune description',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                        : widget.commande.details['images'] != null
                            ? Row(
                                children: [
                                  for (String photo
                                      in widget.commande.details['images'])
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ImageViewer(
                                            images: [photo],
                                          ),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: !photo.contains('http')
                                            ? Image.asset(
                                                photo,
                                                fit: BoxFit.cover,
                                                height: 80.0,
                                                width: 80.0,
                                              )
                                            : Image.network(
                                                photo,
                                                fit: BoxFit.cover,
                                                height: 80.0,
                                                width: 80.0,
                                              ),
                                      ),
                                    ),
                                ],
                              )
                            : const Text(
                                'Aucune description',
                                style: TextStyle(
                                  fontSize: 12,
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
                  onTap: () => showCupertinoModalPopup(
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
                                  'Terminer',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                Text(
                                  'Pourriez-vous confirmer que cette commande est terminee?',
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
                                    child: const Text(
                                      'Terminer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Montserrat',
                                      ),
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
                                      border: Border.all(
                                        color: primary200,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Text(
                                      'Terminer et livrer',
                                      style: TextStyle(
                                        color: primary200,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    'Annuler',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat',
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
