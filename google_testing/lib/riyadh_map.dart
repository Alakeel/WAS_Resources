import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';

class RiyadhMap extends StatefulWidget {
  @override
  _RiyadhMapState createState() => _RiyadhMapState();
}

class _RiyadhMapState extends State<RiyadhMap> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LocationData? _myLocation;
  bool _mapLoaded = false;
  bool _isFullScreen = false;

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    _myLocation = await location.getLocation();
    if (_myLocation != null) {
      print('added !!!');
      _markers.add(
        Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(_myLocation!.latitude!, _myLocation!.longitude!),
          infoWindow: InfoWindow(title: 'My Location'),
        ),
      );
    }
  }

  Future<void> _setMarkers() async {
    // Add your marker code here, for example:
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.7136, 46.6753),
        infoWindow: InfoWindow(title: 'Marker 1'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.7743, 46.7386),
        infoWindow: InfoWindow(title: 'Marker 2'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('3'),
        position: LatLng(24.7135, 46.6755),
        infoWindow: InfoWindow(title: 'Marker 3'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('4'),
        position: LatLng(24.7714, 46.6988),
        infoWindow: InfoWindow(title: 'Marker 4'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('5'),
        position: LatLng(24.6753, 46.6977),
        infoWindow: InfoWindow(title: 'Marker 5'),
      ),
    );

    // Wait for the map to be fully initialized before setting the camera position
    await Future.delayed(Duration(milliseconds: 1000));

    // Get the bounds of the markers
    LatLngBounds bounds = await _calculateBounds(_markers);

    // Animate the camera to fit the markers
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Future<LatLngBounds> _calculateBounds(Set<Marker> markers) async {
    double minLat = 90;
    double maxLat = -90;
    double minLng = 180;
    double maxLng = -180;

    // Check if my location marker exists, if yes then include it in the calculation
    LocationData? myLocationData;
    final location = Location();
    try {
      myLocationData = await location.getLocation();
    } catch (e) {
      print('Could not get current location: $e');
    }
    if (myLocationData != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(myLocationData.latitude!, myLocationData.longitude!),
          infoWindow: InfoWindow(title: 'My Location'),
        ),
      );
    }

    for (Marker marker in markers) {
      double lat = marker.position.latitude;
      double lng = marker.position.longitude;
      if (lat < minLat) minLat = lat;
      if (lat > maxLat) maxLat = lat;
      if (lng < minLng) minLng = lng;
      if (lng > maxLng) maxLng = lng;
    }
    LatLng sw = LatLng(minLat, minLng);
    LatLng ne = LatLng(maxLat, maxLng);
    return LatLngBounds(southwest: sw, northeast: ne);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: _isFullScreen ? 4 : 3,
              child: GoogleMap(
                mapToolbarEnabled: false,
                buildingsEnabled: false,
                zoomControlsEnabled: true,
                // zoomGesturesEnabled: false,
                myLocationEnabled: true, // enable my location button
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _markers.elementAt(0).position,
                  zoom: 10,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  setState(() {
                    _mapLoaded = true;
                  });
                },
              ),
            ),
            // Half-screen card with data
            Visibility(
              visible: _mapLoaded,
              child: Expanded(
                flex: _isFullScreen ? 0 : 1,
                child: Card(
                  margin: EdgeInsets.all(1.0),
                  child: Column(
                    children: [
                      // Button to toggle full-screen mode

                      // Data to display in half-screen mode
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Some data to display here'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // Container(
        //   decoration: BoxDecoration(
        //       color: Color(0xff240046),
        //       // borderRadius: BorderRadius.circular(15)
        //       ),
        //   // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        //   // margin: EdgeInsets.symmetric(vertical: 8),
        //   child:

        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 15,
          top: _isFullScreen
              ? MediaQuery.of(context).size.height - 130
              : MediaQuery.of(context).size.height - 225,
          // child: Center(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  // color: Colors.grey[400],
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                _isFullScreen ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.black,
              ),
              iconSize: 12,
              onPressed: _toggleFullScreen,
            ),
          ),
        ),
        // ),
        // ),
      ],
    );
  }

  void _resetCamera() async {
    if (_myLocation != null) {
      LatLng myLocation =
          LatLng(_myLocation!.latitude!, _myLocation!.longitude!);
      CameraPosition cameraPosition = CameraPosition(
        target: myLocation,
        zoom: 10,
      );
      await _mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      // If location permission is not granted or location service is disabled, show an error message.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Unable to retrieve current location."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
