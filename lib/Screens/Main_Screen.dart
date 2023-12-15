
 

import 'package:flutter/material.dart';
 
import 'package:hive_database/Boxes/Boxes.dart';
import 'package:hive_database/models/NotesModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

 class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final titleController= TextEditingController();
  final descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Database"),
      ),
      body:  ValueListenableBuilder<Box<NotesModel>>(
        
        valueListenable: Boxes.getdata().listenable(), 
        builder: (context , Box, _){
          var data= Box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: Box.length,
            itemBuilder: (context, index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(data[index].title.toString()),
                             Text(data[index].description.toString()),
                             
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                             IconButton(onPressed: ( ){
                              Delete(data[index]);
                             }, icon: Icon(Icons.delete)),
                             IconButton(onPressed: ( ){
                              _EditDialog(data[index], data[index].title.toString(), data[index].description.toString());
                             }, icon: Icon(Icons.edit)),
                             
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _ShowDialog();
        },
        child: Icon(Icons.add),
        ),
    );
  }

  void Delete(NotesModel notesModel)async{
    await notesModel.delete();
  }
  Future <void> _EditDialog(NotesModel notesModel, String title, String description)async{

    titleController.text= title;
    descriptionController.text= description;
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Title",
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Description",
                  ),
                )
              ],
            ),
          ), 
          title: Text("Add Notes"),
          actions: [
            TextButton(onPressed: ( ){
              Navigator.pop(context);
            }, child: Text("Cancel")),
             TextButton(onPressed: ( )async{
               notesModel.title = titleController.text.toString();
               notesModel.description=descriptionController.text.toString();
               await notesModel.save();
               titleController.clear();
               descriptionController.clear();

              Navigator.pop(context);
             }, child: Text("Update")),
          ],
        );
      });
  }

  


  Future <void> _ShowDialog()async{
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Title",
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Description",
                  ),
                )
              ],
            ),
          ), 
          title: Text("Add Notes"),
          actions: [
            TextButton(onPressed: ( ){
              Navigator.pop(context);
            }, child: Text("Cancel")),
             TextButton(onPressed: ( ){
              final data=NotesModel(title: titleController.text, description: descriptionController.text);
              final box= Boxes.getdata();
              box.add(data);
              data.save();
              titleController.clear();
              descriptionController.clear();
               
              Navigator.pop(context);
             }, child: Text("Add")),
          ],
        );
      });
  }
}