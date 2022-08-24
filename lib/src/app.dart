import 'package:flutter/material.dart';

import 'login/login_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: const Color.fromRGBO(238, 240, 243, 1.0),
      ),
      home: const LoginScreen(),
    );
  }
}
