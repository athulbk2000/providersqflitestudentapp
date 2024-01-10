import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudent/controller/provider.dart';
import 'package:providerstudent/database/sq.dart';
import 'package:providerstudent/view/home.dart';


void main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<StudentClass>(
          create: (context) => StudentClass(),),
          ],
        child: const InitApp());;
  }
}
class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<StudentClass>(context).isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.teal[200],
              dialogBackgroundColor: Colors.teal[200],
              primaryColor: Colors.teal[200]),
      title: 'student app',
      home:Homepage(),
     
    );
  }
}