 

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox("Majid"),
            builder: (context, snapshot){
            if(snapshot.hasData){
              return Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data!.get("name").toString()),
                    subtitle: Text(snapshot.data!.get("age").toString()),
                    trailing: IconButton(onPressed: ( ){
                      snapshot.data!.delete("name",);
                      setState(() {
                        
                      });
                    }, icon: Icon(Icons.delete)),
                  )
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()async{
          var box= await Hive.openBox("Majid");
          box.put("name", "Majid");
          box.put("age", "25");
          box.put("List", {
            "A": 75,
            "B":60,
            "C": 50,
          });

          print(box.get("name"));
          print(box.get("age"));
          print(box.get("List")["C"]);
        },
        child: Icon(Icons.add),),
    );
  }
}