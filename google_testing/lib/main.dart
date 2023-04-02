import 'package:flutter/material.dart';
import 'riyadh_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riyadh Map',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riyadh Map'),
        ),
        body: RiyadhMap(),
      ),
    );
  }
}
