import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  static String apiKey = 'AIzaSyCzj89MKQi5be0eF40vPELRihuBhkiTjy4';
  static Future<String> getPlaceName(LatLng point) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${point.latitude},${point.longitude}&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse["status"] == "OK") {
      String address = jsonResponse["results"][0]["formatted_address"];
      return address;
    } else {
      return "Unable to find address for the given location";
    }
    return '';
  }
}
