import 'package:dsmap/services/dataService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapping extends StatefulWidget {
  const Mapping({super.key});

  @override
  State<Mapping> createState() => _MappingState();
}

class _MappingState extends State<Mapping> {
  Set<Marker> _markers = Set();
  bool _isLoading = true;

  void getMarkers() async {
    Set<Marker> temp = await DataService.getAllReports();
    setState(() {
      _isLoading = false;
      _markers = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapping'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_isLoading == false)
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(17.771387, 121.527988),
                zoom: 14,
              ),
              markers: _markers,
            ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
