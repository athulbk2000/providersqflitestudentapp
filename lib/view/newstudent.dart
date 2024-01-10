import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:providerstudent/controller/provider.dart';

class Newstudent extends StatefulWidget {
  const Newstudent({super.key});

  @override
  State<Newstudent> createState() => _NewstudentState();
}

class _NewstudentState extends State<Newstudent> {
  Future pickImage(BuildContext context,ImageSource source)async{
    final image=await ImagePicker().pickImage(source: source);
    if(image==null)return const Center(child: Text('no image'));
    Provider.of<StudentClass>(context,listen: false).image=File(image.path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD STUDENT"),
      ),
      body: Consumer<StudentClass>(builder: (context, provider, child) => SingleChildScrollView(
        child: Container(padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Row(
            children: [
              PopupMenuButton(
                color:provider.isDark?Colors.teal[100]:null,
                icon: const Icon(Icons.camera),
                itemBuilder:((context)=>[
                  PopupMenuItem(
                    onTap: (()=>pickImage(context, ImageSource.camera)),
                    child: const Row(
                      children: [Icon(Icons.camera_alt_outlined),SizedBox(width: 5,),
                    Text("take a picture")],),
                    ),
                    PopupMenuItem(
                      onTap: (()=>pickImage(context, ImageSource.gallery)),
                      child:const Row(children: [Icon(Icons.image_outlined),SizedBox(width: 5,),
                      Text('select a image'),
                      ],)),
                ]),
                ),
                const Text('add a picture ')
            ],
          ),
          Visibility(
            visible: provider.image!=null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [InkWell(
             onTap: (){
              provider.image=null;
             },child: const Icon(Icons.cancel_outlined,color: Colors.red,),),
             provider.image!=null?Image.file(provider.image!,
             width:100,
             height: 100,):Container(),
             ],
            )),
            const SizedBox(height: 10,),
            TextFormField(controller: provider.nameController,
            decoration: InputDecoration(label:const Text('student name'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),),const SizedBox(height: 20,),
            TextFormField(controller: provider.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration( label: const Text('age'),
            
            border: OutlineInputBorder( borderRadius: BorderRadius.circular(15))
            ),),const SizedBox(height: 20,),
            TextFormField(controller: provider.bloodcontroller,
            decoration: InputDecoration(label: const Text('Blood group'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),),const SizedBox(height: 20,),
            TextFormField(controller: provider.courseController,
            decoration: InputDecoration(label: const Text('Course'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),),const SizedBox(height: 20,),
            TextFormField(controller: provider.phonecontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: const Text('Phone number'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),),const SizedBox(height: 20,),

           SingleChildScrollView(scrollDirection: Axis.vertical,child: SizedBox(height: 100,
            child: TextField(
              expands: true,
              maxLines: null,
              controller: provider.addressController,
              decoration: InputDecoration(label: const Text('addres'),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),),),const SizedBox(height: 20,),
            ElevatedButton(
  onPressed: () {
    if (provider.image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select an image before saving.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      provider.insertNewStudent();
      provider.nameController.clear();
      provider.ageController.clear();
      provider.addressController.clear();
      provider.courseController.clear();
      provider.phonecontroller.clear();
      provider.bloodcontroller.clear();
      provider.image = null;
      Navigator.of(context).pop();
    }
  },
  child: const Center(child: Text('Save Student')),
),

            ],
        ),
        ),
      ),),
    );
  }
}