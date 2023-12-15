

import 'package:hive_database/models/NotesModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes{
  static Box<NotesModel>  getdata()=>  Hive.box<NotesModel>("notes");
}