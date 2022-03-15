import 'dart:convert';

import 'package:covid_19/Service/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStateModel.dart';


class StateService {


  Future<WorldStateModel>  fetchWorkStatesRecords () async {

    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    }
    else {
      throw Exception('Error');
    }


  }


  Future<List<dynamic>>  CountriesListApi () async {
    var data;

    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
      return data;
    }
    else {
      throw Exception('Error');
    }


  }


}