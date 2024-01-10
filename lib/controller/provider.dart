import 'dart:io';

import 'package:flutter/material.dart';
import 'package:providerstudent/database/sq.dart';
import 'package:providerstudent/model/model.dart';

  
class StudentClass extends ChangeNotifier {
  StudentClass() {
    getStudent();
  }

  bool isDark = false;
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController bloodcontroller = TextEditingController();
  File? image;

  List< StudentModel> allStudent = [];
  getStudent() async {
    allStudent = await DbHelper.dbHelper.getAllStudents();
    notifyListeners();
  }

  insertNewStudent() {
     StudentModel studentModel =  StudentModel(
        name: nameController.text,
        image: image,
       course: courseController.text,
       address: addressController.text,
        age: int.parse(ageController.text != ''
            ? ageController.text
            : '0'),
        phonenumber: int.parse(phonecontroller.text != ''
            ? phonecontroller.text
            : '0'),
        bloodgroup:bloodcontroller.text,

            );
       
            
    DbHelper.dbHelper.insertNewStudents(studentModel);
    getStudent();
  }

  updateStudent( StudentModel studentModel) async {
    await DbHelper.dbHelper.updateStudent(studentModel);
    getStudent();
  }

  deleteStudent( StudentModel studentModel) {
    DbHelper.dbHelper.deleteStudents(studentModel);
    getStudent();
  }
}