import 'package:flutter/material.dart';
import 'package:hive_database/Screens/Main_Screen.dart';
import 'package:hive_database/models/NotesModel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
 

 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory=await getApplicationDocumentsDirectory();
  await Hive.initFlutter( );
  Hive.registerAdapter(NotesModelAdapter());
await Hive.openBox<NotesModel>("notes");

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const MainScreen(),
    );
  }
}
