import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isMapFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps Example'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.419416),
              zoom: 12,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: _isMapFullScreen ? 0 : null,
            top: _isMapFullScreen ? 0 : null,
            left: 0,
            right: 0,
            height: _isMapFullScreen ? MediaQuery.of(context).size.height : 200,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 && _isMapFullScreen) {
                  setState(() {
                    _isMapFullScreen = false;
                  });
                } else if (details.delta.dy < 0 && !_isMapFullScreen) {
                  setState(() {
                    _isMapFullScreen = true;
                  });
                }
              },
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Card Title'),
                      subtitle: Text('Card Subtitle'),
                      leading: Icon(Icons.album),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
