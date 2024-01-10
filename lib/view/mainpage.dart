import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:providerstudent/controller/provider.dart';
import 'package:providerstudent/model/model.dart';

class EditStudent extends StatefulWidget {
  final StudentModel studentModel;

  const EditStudent({Key? key, required this.studentModel}) : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  late TextEditingController _courseController;
  late TextEditingController _phoneController;
  late TextEditingController _bloodController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentModel.name);
    _ageController = TextEditingController(text: widget.studentModel.age.toString());
    _addressController = TextEditingController(text: widget.studentModel.address);
    _courseController = TextEditingController(text: widget.studentModel.course);
    _phoneController = TextEditingController(text: widget.studentModel.phonenumber.toString());
    _bloodController = TextEditingController(text: widget.studentModel.bloodgroup);
  }

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

   
    widget.studentModel.image = File(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentClass>(
      builder: (BuildContext context, value, Widget? child) => AlertDialog(
        title: const Text('Edit Student'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PopupMenuButton(
                    color: value.isDark ? Colors.teal[100] : null,
                    icon: const Icon(Icons.camera),
                    itemBuilder: ((context) => [
                      PopupMenuItem(
                        onTap: () => pickImage(context, ImageSource.camera),
                        child: const Row(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 5),
                            Text("Take a Picture"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => pickImage(context, ImageSource.gallery),
                        child: const Row(children: [
                          Icon(Icons.image_outlined),
                          SizedBox(width: 5),
                          Text('Select an Image'),
                        ]),
                      ),
                    ]),
                  ),
                  const Text('Add a Picture '),
                ],
              ),
              Visibility(
                visible: widget.studentModel.image != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Clear the image in the student model
                        widget.studentModel.image = null;
                      },
                      child: const Icon(Icons.cancel_outlined, color: Colors.red),
                    ),
                    widget.studentModel.image != null
                        ? Image.file(
                            widget.studentModel.image!,
                            width: 100,
                            height: 100,
                          )
                        : Container(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bloodController,
                decoration: const InputDecoration(labelText: 'Blood Group'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
             
              widget.studentModel.name = _nameController.text;
              widget.studentModel.age = int.parse(_ageController.text);
              widget.studentModel.bloodgroup = _bloodController.text;
              widget.studentModel.course = _courseController.text;
              widget.studentModel.phonenumber = int.parse(_phoneController.text);
              widget.studentModel.address = _addressController.text;

              Provider.of<StudentClass>(context, listen: false).updateStudent(widget.studentModel);

              Navigator.of(context).pop();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
