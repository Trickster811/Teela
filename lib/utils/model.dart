import 'package:syncfusion_flutter_sliders/sliders.dart';

class CatalogueModel {
  final String description;
  final List<ModeleModel> modeles;
  final String title;

  const CatalogueModel({
    required this.description,
    required this.modeles,
    required this.title,
  });
}

class CommandeModel {
  final String customerName;
  final String customerPhone;
  final DateTime date;
  final SfRangeValues duration;
  final ModeleModel modele;
  final int price;
  final List<Map<String, int>> versements;

  const CommandeModel({
    required this.customerName,
    required this.customerPhone,
    required this.date,
    required this.duration,
    required this.modele,
    required this.price,
    required this.versements,
  });
}

class ModeleModel {
  final String description;
  final SfRangeValues duration;
  final List<String> images;
  final int maxPrice;
  final int minPrice;
  final bool state;
  final String title;

  const ModeleModel({
    required this.description,
    required this.duration,
    required this.images,
    required this.maxPrice,
    required this.minPrice,
    required this.state,
    required this.title,
  });
}
