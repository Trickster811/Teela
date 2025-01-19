import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:teela/utils/app.dart';
import 'package:teela/utils/color_scheme.dart';
import 'package:teela/utils/model.dart';

class AddCommande extends StatefulWidget {
  final CommandeModel? commande;

  const AddCommande({
    super.key,
    required this.commande,
  });

  @override
  State<AddCommande> createState() => _AddCommandeState();
}

class _AddCommandeState extends State<AddCommande>
    with SingleTickerProviderStateMixin {
  // User info
  final _controllerFullName = TextEditingController();
  final _controllerPhone = TextEditingController();

  // Modele info
  ModeleModel? model;
  List<dynamic> images = []; // description - images
  final _controllerText = TextEditingController(); // description - text

  // Paymet info
  final _controllerPrice = TextEditingController();
  final _controllerVersement = TextEditingController();
  double _duration = 5.0;

  // Form key
  final addCommandeFormKey = GlobalKey<FormState>();

  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );

    // Listening for tab change event
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  List<CatalogueModel> listCatalogue = [
    const CatalogueModel(
      description: 'Des vetements refletants les coutumes',
      modeles: [
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
        ModeleModel(
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
        ),
      ],
      title: 'Modeles traditionels',
    ),
  ];

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
          'Nouvelle commande',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: addCommandeFormKey,
        child: Column(
          children: [
            TabBar(
              controller: _controller,
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 0.0,
              indicator: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              dividerHeight: 0,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informations du client',
                          style: TextStyle(
                            color: _controller!.index >= 0
                                ? primary200
                                : neutral300,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: _controller!.index >= 0
                                  ? const EdgeInsets.all(5.0)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: _controller!.index >= 0
                                    ? Border.all(color: primary200)
                                    : Border.all(width: 0),
                                borderRadius: BorderRadius.circular(5000),
                              ),
                              child: Container(
                                height: _controller!.index >= 0 ? 10.0 : 15.0,
                                width: _controller!.index >= 0 ? 10.0 : 15.0,
                                decoration: BoxDecoration(
                                  color: _controller!.index >= 0
                                      ? primary200
                                      : neutral300,
                                  borderRadius: BorderRadius.circular(5000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            Expanded(
                              child: Divider(
                                color: _controller!.index >= 0
                                    ? primary200
                                    : neutral300,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Modele',
                          style: TextStyle(
                            color: _controller!.index >= 1
                                ? primary200
                                : neutral300,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: _controller!.index >= 1
                                  ? const EdgeInsets.all(5.0)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: _controller!.index >= 1
                                    ? Border.all(color: primary200)
                                    : Border.all(width: 0),
                                borderRadius: BorderRadius.circular(5000),
                              ),
                              child: Container(
                                height: _controller!.index >= 1 ? 10.0 : 15.0,
                                width: _controller!.index >= 1 ? 10.0 : 15.0,
                                decoration: BoxDecoration(
                                  color: _controller!.index >= 1
                                      ? primary200
                                      : neutral300,
                                  borderRadius: BorderRadius.circular(5000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            Expanded(
                              child: Divider(
                                color: _controller!.index >= 1
                                    ? primary200
                                    : neutral300,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Modalites',
                          style: TextStyle(
                            color: _controller!.index >= 2
                                ? primary200
                                : neutral300,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: _controller!.index >= 2
                                  ? const EdgeInsets.all(5.0)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: _controller!.index >= 2
                                    ? Border.all(color: primary200)
                                    : Border.all(width: 0),
                                borderRadius: BorderRadius.circular(5000),
                              ),
                              child: Container(
                                height: _controller!.index >= 2 ? 10.0 : 15.0,
                                width: _controller!.index >= 2 ? 10.0 : 15.0,
                                decoration: BoxDecoration(
                                  color: _controller!.index >= 2
                                      ? primary200
                                      : neutral300,
                                  borderRadius: BorderRadius.circular(5000),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: TabBarView(
                  controller: _controller,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nom du client',
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
                              placeholder: 'julie queen',
                            ),
                            controller: _controllerFullName,
                            validator: (fullName) => fullName == null ||
                                    _controllerFullName.text.trim() == ''
                                ? 'Veuillez saisir votre nom complet'
                                : null,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Numéro de téléphone',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          InternationalPhoneNumberInput(
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              showFlags: true,
                              useEmoji: false,
                              setSelectorButtonAsPrefixIcon: false,
                              useBottomSheetSafeArea: false,
                            ),
                            initialValue: PhoneNumber(isoCode: 'CM'),
                            countries: const ["CM"],
                            onInputChanged: (PhoneNumber number) {
                              setState(() {
                                _controllerPhone.text = number.phoneNumber!;
                              });
                            },
                            // textFieldController: _controllerPhone,
                            textStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.normal,
                            ),
                            selectorTextStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.normal,
                            ),
                            spaceBetweenSelectorAndTextField: 0,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            inputDecoration: FormDecoration.inputDecoaration(
                              context: context,
                              placeholder: 'téléphone',
                            ),
                            validator: (phone) => phone != null &&
                                    _controllerPhone.text.trim().length < 13
                                ? 'Veuillez saisir une numéro de téléphone valide'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Photos du modele',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
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
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      builder: (context) => StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter stateSetter) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                            top: 15.0,
                                            right: 15.0,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/arrow-left-2.4.svg',
                                                    semanticsLabel:
                                                        'Arriw left',
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Theme.of(context)
                                                          .iconTheme
                                                          .color!,
                                                      BlendMode.srcIn,
                                                    ),
                                                    height: 30,
                                                  ),
                                                  const Spacer(),
                                                  const Text(
                                                    'Choix du modele',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 14.0),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/search.5.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        neutral700,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                    right: 10.0,
                                                  ),
                                                  filled: true,
                                                  fillColor: neutral200,
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: neutral200),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    gapPadding: 0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: neutral200),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  hintText: 'Rechercher...',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  File photo = await FileManager
                                                      .getImageFromDevice(
                                                    multiImage: false,
                                                    source: ImageSource.camera,
                                                  );
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    model = ModeleModel(
                                                      description: '',
                                                      duration:
                                                          const SfRangeValues(
                                                              0, 0),
                                                      images: [photo],
                                                      maxPrice: 0,
                                                      minPrice: 0,
                                                      title: 'Modele Anonyme',
                                                    );
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      height: 80.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        border: Border.all(),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/icons/camera.svg',
                                                        semanticsLabel:
                                                            'Arriw left',
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          Theme.of(context)
                                                              .iconTheme
                                                              .color!,
                                                          BlendMode.srcIn,
                                                        ),
                                                        // height: 30,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    const Expanded(
                                                      child: SizedBox(
                                                        height: 80.0,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Camera',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Prendre en photo votre modele',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              for (CatalogueModel catalogue
                                                  in listCatalogue)
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        child: Image.asset(
                                                          catalogue.modeles[0]
                                                              .images[0],
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                catalogue.title,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                catalogue
                                                                    .description,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      10.0,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Text(
                                                                  '${catalogue.modeles.length} modele${catalogue.modeles.length > 1 ? 's' : ''}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ],
                                          ),
                                        );
                                      }),
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
                                if (model != null)
                                  for (dynamic image in model!.images) ...[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: image is String &&
                                              !image.contains('http')
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
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            'Ecrivez sur du papier et filmer ou rediger directement la description de votre commande',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Photos',
                            style: TextStyle(
                              fontSize: 14,
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
                                    child: image is String &&
                                            !image.contains('http')
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
                            'Texte',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            cursorColor: Theme.of(context).iconTheme.color,
                            cursorErrorColor: primary500,
                            maxLines: 8,
                            decoration: FormDecoration.inputDecoaration(
                              context: context,
                              placeholder: 'details ici',
                            ),
                            controller: _controllerText,
                            validator: (description) => description == null ||
                                    _controllerText.text.trim() == ''
                                ? 'Veuillez saisir une description'
                                : null,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Prix (Fcfa)',
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
                              placeholder: '3500',
                            ),
                            controller: _controllerPrice,
                            validator: (amount) => amount == null ||
                                    _controllerPrice.text.trim() == ''
                                ? 'Veuillez saisir un montant minimum'
                                : null,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Premier versement (Fcfa)',
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
                              placeholder: '7000',
                            ),
                            controller: _controllerVersement,
                            validator: (amount) => amount == null ||
                                    _controllerVersement.text.trim() == ''
                                ? 'Veuillez saisir un montant maximum'
                                : null,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Duree (${_duration.toInt()} jours)',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SfSlider(
                            onChanged: (dynamic newValue) {
                              setState(() {
                                _duration = newValue;
                              });
                            },
                            min: 1,
                            max: 30,
                            value: _duration,
                            interval: 1,
                            stepSize: 1,
                            showDividers: true,
                            enableTooltip: true,
                            activeColor: primary200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (!addCommandeFormKey.currentState!.validate()) return;
          if (_controller!.index != 2) {
            _controller!.animateTo(_controller!.index + 1);
            return;
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          height: 40,
          decoration: BoxDecoration(
            color: primary200,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            _controller!.index != 2 ? 'Continuer' : 'Enregistrer',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
