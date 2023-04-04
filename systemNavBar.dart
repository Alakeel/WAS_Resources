import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'riyadh_map.dart';

void main() {
  runApp(MyApp());
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.yellow
// ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            // // below system
            // backgroundColor: Colors.yellow, // Status bar color
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarColor: Colors.red, // Color for Android

            //   // For iOS (dark icons)
            //   statusBarBrightness: Brightness.light,

            //   // For Android (dark icons)
            //   statusBarIconBrightness: Brightness.light,
            //   systemNavigationBarColor: Colors.green, // navigation bar color

            // below system
            backgroundColor: Colors.yellow, // Status bar color
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white, // Color for Android
              // For iOS (dark icons)
              statusBarBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarIconBrightness: Brightness.dark,
              // systemNavigationBarContrastEnforced: false,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness:
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light,
            )),
      ),
      title: 'Riyadh Map',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riyadh Map'),
          // brightness: Brightness.light, // or use Brightness.dark
        ),
        body: RiyadhMap(),
      ),
    );
  }
}
