import 'package:flutter/material.dart';
import 'package:three_js_test/three_scene_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueGrey)),
      home: const ThreeScenePage(),
    );
  }
}
