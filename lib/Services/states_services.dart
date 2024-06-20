import 'dart:convert';

import 'package:covidtracker/Modals/world_state_modal.dart';
import 'package:covidtracker/Services/Utitlities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModal> getWorldState() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStateModal.fromJson(data);
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> getCountriesList() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.contriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("error");
    }
  }
}
