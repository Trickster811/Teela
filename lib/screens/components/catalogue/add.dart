import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/data.dart';
import 'package:teela/utils/local.dart';
import 'package:teela/utils/model.dart';

class AddCatalogue extends StatefulWidget {
  final CatalogueModel? catalogueModel;
  const AddCatalogue({super.key, required this.catalogueModel});

  @override
  State<AddCatalogue> createState() => _AddCatalogueState();
}

class _AddCatalogueState extends State<AddCatalogue> {
  final _controllerTitle = TextEditingController();

  final _controllerDescription = TextEditingController();

  // Form key
  final addCatalogueFormKey = GlobalKey<FormState>();
  bool onGoingProcess = false;

  @override
  void initState() {
    super.initState();
    if (widget.catalogueModel != null) {
      _controllerTitle.text = widget.catalogueModel!.title;
      _controllerDescription.text = widget.catalogueModel!.description;
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
          widget.catalogueModel != null
              ? 'Mise A Jour Catalogue'
              : 'Nouveau Catalogue',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: addCatalogueFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (onGoingProcess ||
                    !addCatalogueFormKey.currentState!.validate()) {
                  return;
                }
                await addOrUpdateCatalogue();
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
                          child: CupertinoActivityIndicator(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        )
                        : Text(
                          widget.catalogueModel != null
                              ? 'Mettre a jour'
                              : 'Ajouter',
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

  Future addOrUpdateCatalogue() async {
    setState(() {
      onGoingProcess = true;
    });
    try {
      if (!await Internet.checkInternetAccess()) {
        LocalPreferences.showFlashMessage('Pas d\'internet', Colors.red);
        setState(() {
          onGoingProcess = false;
        });
      }
      if (widget.catalogueModel != null) {
        await CatalogueTeela.updateCatalogue(
          data: {
            'description': _controllerDescription.text.trim(),
            'title': _controllerTitle.text.trim(),
          },
          id: widget.catalogueModel!.id,
        );
        LocalPreferences.showFlashMessage(
          'Catalogue mis a jour avec succès',
          Colors.blue,
        );
      } else {
        await CatalogueTeela.createCatalogue(
          data: {
            'description': _controllerDescription.text.trim(),
            'title': _controllerTitle.text.trim(),
            'user': Auth.user!['_id'].toString(),
          },
        );
        LocalPreferences.showFlashMessage(
          'Catalogue créé avec succès',
          Colors.green,
        );
      }

      setState(() {
        onGoingProcess = false;
      });
      Navigator.pop(context);
    } on PostgrestException catch (e) {
      setState(() {
        onGoingProcess = false;
      });
      LocalPreferences.showFlashMessage(e.message, Colors.red);
    } catch (erno) {
      setState(() {
        onGoingProcess = false;
      });
      debugPrint(erno.toString());
    }
  }
}
