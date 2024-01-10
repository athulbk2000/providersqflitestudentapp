import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudent/controller/provider.dart';
import 'package:providerstudent/view/newstudent.dart';
import 'package:providerstudent/widget/firstpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentClass>(builder: (BuildContext context,myprovider,Widget?child)=> Scaffold(
      body:ListView.builder(
            itemCount: myprovider.allStudent.length,
            itemBuilder: (context, index) {
              return Studentfirstpage(myprovider.allStudent[index]);
            },) ,
        
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Newstudent()),);
      },child: Icon(Icons.person_add),),
      ));
    
  }
}