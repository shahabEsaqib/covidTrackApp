import 'dart:convert';

import 'package:covid_app_api/Model/world_states_model.dart';
import 'package:covid_app_api/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;
class StatesServices {

  Future <WorldStatesModel> fetchWorldStetes()async{
    final response = await http.get(Uri.parse(AppUrl.worldState));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Eroro");
    }

  }
  Future <List<dynamic>> fetchCountriesStetes()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesist));
    data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception("Eroro");
    }

  }
}