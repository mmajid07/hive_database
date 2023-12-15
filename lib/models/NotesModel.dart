import 'package:hive/hive.dart';
part 'NotesModel.g.dart';

@HiveType(typeId: 1)
class NotesModel extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  NotesModel({required this.title, required this.description});
}