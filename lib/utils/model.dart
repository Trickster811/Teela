import 'package:syncfusion_flutter_sliders/sliders.dart';

class CatalogueModel {
  final String description;
  final String id;
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
  final Map<String, List<Map<String, dynamic>>> customerMesures;
  final String customerName;
  final String customerPhone;
  final DateTime date;
  final Map<String, dynamic> details;
  final SfRangeValues duration;
  final ModeleModel modele;
  final int price; // Total to pay
  final Map<String, int> versements;

  const CommandeModel({
    required this.customerMesures,
    required this.customerName,
    required this.customerPhone,
    required this.date,
    required this.details,
    required this.duration,
    required this.modele,
    required this.price,
    required this.versements,
  });
}

class ModeleModel {
  final String description;
  final SfRangeValues duration;
  final List<dynamic> images;
  final int maxPrice;
  final int minPrice;
  final String title;

  const ModeleModel({
    required this.description,
    required this.duration,
    required this.images,
    required this.maxPrice,
    required this.minPrice,
    required this.title,
  });
}
