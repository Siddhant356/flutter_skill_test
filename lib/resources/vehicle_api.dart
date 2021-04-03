import 'dart:convert';

import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:http/http.dart' show Client;

class VehicleApi {
  Client client = Client();
  final _baseUrl = 'https://myfakeapi.com/api/cars/';
  Future<List<Vehicle>> fetchVehicleList() async{
    List<Vehicle> listVehicle = [];
    final response = await client.get(Uri.parse(_baseUrl));
    if(response.statusCode == 200) {
      var res = json.decode(response.body);
      for(int i=0; i<10; i++){
        var temp = Vehicle.fromJson(res['cars'][i]);
        listVehicle.add(temp);
      }
      return listVehicle;
    } else {
      throw Exception("Failed to get post");
    }
  }

}