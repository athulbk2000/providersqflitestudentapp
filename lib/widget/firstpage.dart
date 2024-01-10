
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudent/controller/provider.dart';
import 'package:providerstudent/model/model.dart';
import 'package:providerstudent/view/mainpage.dart';


class Studentfirstpage extends StatelessWidget {
  final StudentModel studentModel;
  const Studentfirstpage(this.studentModel,{super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<StudentClass>(context);
    return InkWell(
      onTap: ((){
        Navigator.push(context, MaterialPageRoute(builder: ((context)=>EditStudent(studentModel: studentModel))));
      }),child: Card(
        child: Container(decoration: BoxDecoration(
          color: Provider.of<StudentClass>(context).isDark?Colors.teal[100]:null,
          borderRadius: BorderRadius.circular(10)),
          margin:const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: ListTile(
            trailing: IconButton(onPressed: (){
              provider.deleteStudent(studentModel);
            }, icon: Icon(Icons.delete)),
            tileColor: Provider.of<StudentClass>(context).isDark?Colors.teal[100]:null,
            leading: studentModel.image==null?Container(decoration: BoxDecoration(
              color: Provider.of<StudentClass>(context).isDark?Colors.teal:null,
              borderRadius: BorderRadius.circular(8)),
              height: double.infinity,
              width: 70,
              child: const Center(child: CircleAvatar(backgroundImage:AssetImage('assets/avathar1.jpg'),),),):Image.file(studentModel.image!,width: 70,
              height: double.infinity,),
              title: Text('Name:${studentModel.name}'),
              subtitle: Column(children: [Text('Age:${studentModel.age}'),
             Text('Course:${studentModel.course}'),Text('Blood Group:${studentModel.bloodgroup}'),
             Text('Address:${studentModel.address}'),Text('Phone:${studentModel.age}'), ],),
          ),
          ),
      ),
    );
  }
}