import 'package:flutter/material.dart';

import 'package:contacts/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqontacts',
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue.withOpacity(0.6)),
      home: Home(),
    );
  }
}
