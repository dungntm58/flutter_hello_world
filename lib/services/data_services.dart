import 'dart:convert';
import 'package:flutter_hello_world/services/model/trip.dart';
import 'package:http/http.dart' as http;

class DataServices {
  String baseUrl = "http://mark.bslmeiyu.com/api";

  Future<List<TripModel>> getTrips() async {
    final api = "/getplaces";
    final response = await http.get(Uri.parse("$baseUrl$api"));
    try {
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        return list.map((e) => TripModel.fromJson(e)).toList();
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }
}
