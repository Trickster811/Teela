import 'package:syncfusion_flutter_sliders/sliders.dart';

class CatalogueModel {
  final String description;
  final Object id;
  final List<ModeleModel> modeles;
  final String title;

  const CatalogueModel({
    required this.description,
    required this.id,
    required this.modeles,
    required this.title,
  });
}

class CommandeModel {
  final Map<String, dynamic> customerMesures;
  final String customerName;
  final String customerPhone;
  final DateTime date;
  final Map<String, dynamic> details;
  final int duration;
  final Object id;
  final ModeleModel modele;
  final int price; // Total to pay
  final Map<String, dynamic> versements;
  final int status; // 1 = In progress | 2 = Finished | 3 = Delivered  ]

  const CommandeModel({
    required this.customerMesures,
    required this.customerName,
    required this.customerPhone,
    required this.date,
    required this.details,
    required this.duration,
    required this.id,
    required this.modele,
    required this.price,
    required this.versements,
    required this.status,
  });
}

class ModeleModel {
  final String description;
  final SfRangeValues duration;
  final Object id;
  final List<dynamic> images;
  final int maxPrice;
  final int minPrice;
  final String title;

  const ModeleModel({
    required this.description,
    required this.duration,
    required this.id,
    required this.images,
    required this.maxPrice,
    required this.minPrice,
    required this.title,
  });
}
