import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lancealot_admin_panel/routes/custom_routes.dart';
import 'package:lancealot_admin_panel/routes/routes_names.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lancealot Admin Panel',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0.0,
          color: Colors.lightBlueAccent,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black,fontSize: 20),
          ),
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: CustomRoutes.allRoutes,
      initialRoute: dashboard,
    );
  }
}

