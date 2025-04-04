import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';
import 'package:path/path.dart' as p;

class AddModele extends StatefulWidget {
  final CatalogueModel catalogue;
  final ModeleModel? modele;
  const AddModele({super.key, required this.catalogue, required this.modele});

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
  bool onGoingProcess = false;

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
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
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
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                padding: EdgeInsets.zero,
                                radius: const Radius.circular(15.0),
                                child: const SizedBox(
                                  height: 80.0,
                                  width: 80.0,
                                  child: Icon(Icons.add, size: 40.0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            for (dynamic image in images) ...[
                              SizedBox(
                                height: 80.0,
                                width: 80.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child:
                                      image is String && !image.contains('http')
                                          ? Image.asset(
                                            image,
                                            fit: BoxFit.cover,
                                          )
                                          : image is File
                                          ? Image.file(image, fit: BoxFit.cover)
                                          : ItemBuilder.imageCardBuilder(image),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Titre',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        cursorColor: Theme.of(context).iconTheme.color,
                        cursorErrorColor: primary500,
                        decoration: FormDecoration.inputDecoaration(
                          context: context,
                          placeholder: 'Modeles traditionnels',
                        ),
                        controller: _controllerTitle,
                        validator:
                            (title) =>
                                title == null ||
                                        _controllerTitle.text.trim() == ''
                                    ? 'Veuillez renseigner le titre'
                                    : null,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
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
                        validator:
                            (description) =>
                                description == null ||
                                        _controllerDescription.text.trim() == ''
                                    ? 'Veuillez saisir une description'
                                    : null,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Prix (Min - Max)',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * .5 - 30.0,
                            child: TextFormField(
                              cursorColor: Theme.of(context).iconTheme.color,
                              cursorErrorColor: primary500,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '3500',
                              ),
                              controller: _controllerMinPrice,
                              validator:
                                  (amount) =>
                                      amount == null ||
                                              _controllerMinPrice.text.trim() ==
                                                  ''
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
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                              decoration: FormDecoration.inputDecoaration(
                                context: context,
                                placeholder: '7000',
                              ),
                              controller: _controllerMaxPrice,
                              validator:
                                  (amount) =>
                                      amount == null ||
                                              _controllerMaxPrice.text.trim() ==
                                                  ''
                                          ? 'Veuillez saisir un montant maximum'
                                          : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Duree (${_duration.start.toInt()} - ${_duration.end.toInt()})',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
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
                if (onGoingProcess ||
                    !addModeleFormKey.currentState!.validate()) {
                  return;
                }
                setState(() {
                  onGoingProcess = true;
                });
                await uploadPhotos();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary200,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:
                    onGoingProcess
                        ? SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        )
                        : Text(
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

  Future uploadPhotos() async {
    try {
      // Upload images if they were picked from internal storage
      List<String> imageModeleDownloadLinks = [];
      for (dynamic image in images) {
        if (image is! String) {
          final photosLink = await FileManager.uploadFile(
            image: image,
            folder: 'modele_images',
            uploadPath:
                '${Auth.user!['_id'].toString()}/${_controllerTitle.text.trim()}/${p.basename(image.path)}',
          );
          if (photosLink != null) {
            imageModeleDownloadLinks.add(photosLink);
          } else {}
        }
      }
      return await addOrUpdateModele(
        imageModeleDownloadLinks: imageModeleDownloadLinks,
      );
    } catch (e) {
      setState(() {
        onGoingProcess = false;
      });
      print(e);
      LocalPreferences.showFlashMessage(
        'Erreur de chargement des fichiers\nVeuiller reessayer',
        Colors.red,
      );
    }
  }

  Future addOrUpdateModele({List<String>? imageModeleDownloadLinks}) async {
    try {
      if (!await Internet.checkInternetAccess()) {
        LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
        setState(() {
          onGoingProcess = false;
        });
      }
      if (widget.modele != null) {
        await ModeleTeela.updateModele(
          data: {
            'description': _controllerDescription.text.trim(),
            'duration': [_duration.start, _duration.end],
            'images': [],
            'max_price': _controllerMaxPrice.text.trim(),
            'min_price': _controllerMinPrice.text.trim(),
            'title': _controllerTitle.text.trim(),
          },
          id: widget.modele!.id,
        );
        LocalPreferences.showFlashMessage(
          'Modele mis a jour avec succès',
          Colors.blue,
        );
      } else {
        await ModeleTeela.createModele(
          data: {
            'description': _controllerDescription.text.trim(),
            'duration': [_duration.start, _duration.end],
            'images': imageModeleDownloadLinks,
            'max_price': _controllerMaxPrice.text.trim(),
            'min_price': _controllerMinPrice.text.trim(),
            'title': _controllerTitle.text.trim(),
            'catalogue': widget.catalogue.id,
          },
        );
        LocalPreferences.showFlashMessage(
          'Modele créé avec succès',
          Colors.green,
        );
      }

      setState(() {
        onGoingProcess = false;
        Navigator.pop(context);
      });
    } catch (erno) {
      LocalPreferences.showFlashMessage('Une erreur est survenue', Colors.red);
      setState(() {
        onGoingProcess = false;
      });
      debugPrint(erno.toString());
    }
  }
}
