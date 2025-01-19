import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class AddModele extends StatefulWidget {
  final ModeleModel? modele;
  const AddModele({
    super.key,
    required this.modele,
  });

  @override
  State<AddModele> createState() => _AddModeleState();
}

class _AddModeleState extends State<AddModele> {
  List<dynamic> images = [];
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerMinPrice = TextEditingController();
  final _controllerMaxPrice = TextEditingController();
  SfRangeValues _duration = const SfRangeValues(5.0, 8.0);

  // Form key
  final addModeleFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.modele != null) {
      _controllerTitle.text = widget.modele!.title;
      _controllerDescription.text = widget.modele!.description;
      _controllerMinPrice.text = widget.modele!.minPrice.toString();
      _controllerMaxPrice.text = widget.modele!.maxPrice.toString();
      images.addAll(widget.modele!.images);
    }
  }

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
          widget.modele != null ? 'Mise A Jour Modele' : 'Nouveau Modele',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: addModeleFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Photos',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                images.addAll(
                                  await FileManager.getImageFromDevice(
                                    multiImage: true,
                                  ),
                                );
                                setState(() {});
                              },
                              child: Container(
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
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            for (dynamic image in images) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child:
                                    image is String && !image.contains('http')
                                        ? Image.asset(
                                            image,
                                            fit: BoxFit.cover,
                                            height: 80.0,
                                            width: 80.0,
                                          )
                                        : image is File
                                            ? Image.file(
                                                image,
                                                fit: BoxFit.cover,
                                                height: 80.0,
                                                width: 80.0,
                                              )
                                            : Image.network(
                                                image,
                                                fit: BoxFit.cover,
                                                height: 80.0,
                                                width: 80.0,
                                              ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Titre',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).iconTheme.color,
                        cursorErrorColor: primary500,
                        decoration: FormDecoration.inputDecoaration(
                          context: context,
                          placeholder: 'Modeles traditionnels',
                        ),
                        controller: _controllerTitle,
                        validator: (title) =>
                            title == null || _controllerTitle.text.trim() == ''
                                ? 'Veuillez renseigner le titre'
                                : null,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        cursorColor: Theme.of(context).iconTheme.color,
                        cursorErrorColor: primary500,
                        maxLines: 5,
                        decoration: FormDecoration.inputDecoaration(
                          context: context,
                          placeholder:
                              'Des vetements refletant les coutumes de diverses regions du Cameroun',
                        ),
                        controller: _controllerDescription,
                        validator: (description) => description == null ||
                                _controllerDescription.text.trim() == ''
                            ? 'Veuillez saisir une description'
                            : null,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Prix (Min - Max)',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * .5 - 30.0,
                            child: TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '3500',
                              ),
                              controller: _controllerMinPrice,
                              validator: (amount) => amount == null ||
                                      _controllerMinPrice.text.trim() == ''
                                  ? 'Veuillez saisir un montant minimum'
                                  : null,
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * .5 - 30.0,
                            child: TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '7000',
                              ),
                              controller: _controllerMaxPrice,
                              validator: (amount) => amount == null ||
                                      _controllerMaxPrice.text.trim() == ''
                                  ? 'Veuillez saisir un montant maximum'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Duree (${_duration.start.toInt()} - ${_duration.end.toInt()})',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SfRangeSlider(
                        onChanged: (SfRangeValues newValues) {
                          setState(() {
                            _duration = newValues;
                          });
                        },
                        min: 1,
                        max: 30,
                        values: _duration,
                        interval: 1,
                        stepSize: 1,
                        showDividers: true,
                        enableTooltip: true,
                        dragMode: SliderDragMode.both,
                        activeColor: primary200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!addModeleFormKey.currentState!.validate()) return;
                await addModele();
              },
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
                  widget.modele != null ? 'Mettre a jour' : 'Ajouter',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future addModele() async {
    Navigator.pop(context);
  }
}
