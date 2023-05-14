import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dsmap/services/request.dart';

class SelectLocation extends StatefulWidget {
  final LatLng place;
  const SelectLocation({super.key, required this.place});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  GoogleMapController? mapController;
  LatLng? tappedLocation;
  String placeName = '';
  Set<Marker> _markers = {};

  void _onMapTapped(LatLng location) async {
    placeName = await Request.getPlaceName(location);
    setState(() {
      tappedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('${location.toString()}'),
          position: location,
          infoWindow: InfoWindow(
            title: '$placeName',
            snippet:
                'Latitude: ${location.latitude}, Longitude: ${location.longitude}',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: widget.place,
                zoom: 14,
              ),
              onTap: _onMapTapped,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
          Container(
            child: Column(
              children: [
                Text('Place: $placeName'),
                ElevatedButton(
                  onPressed: () {
                    if (tappedLocation != null) {
                      Navigator.pop(
                        context,
                        tappedLocation,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Please Select Location'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ok'),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Column(children: [Text('SELECT')]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
