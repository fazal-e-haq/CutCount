import 'package:isar_community/isar.dart';

part 'cut_record_model.g.dart';

@collection
class CutRecordModel {
  Id id = Isar.autoIncrement;

  late String serviceName;
  
  late double price;
  
  @Index(type: IndexType.value)
  late DateTime timestamp;
}
