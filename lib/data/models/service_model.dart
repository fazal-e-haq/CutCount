import 'package:isar_community/isar.dart';

part 'service_model.g.dart';

@collection
class ServiceModel {
  Id id = Isar.autoIncrement;

  late String name;
  
  late double price;
  
  // Storing icon as an integer code point
  late int iconCodePoint;
  
  String note = '';
}
