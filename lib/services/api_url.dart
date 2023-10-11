import 'dart:convert';

import 'package:flutter_covid/model/country_model.dart';

import '../model/all_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<AllModel> fetch() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AllModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<CountryModel>> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((data) => CountryModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
/*
  Future<AllModel> fetch() async {
    //jo token ma shared prefrence ma set karwao ga wohe token yaha get kar luga 
    //Sting token ma or ya token Authrization ma pas karwa doga phir wo token har jaga apna ap call hota raha ga
    String token = '';
    final response =

        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'),headers: {
          'Contant-Type':'aplication/json',
          'Autrization':'Barer $token'
        });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AllModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
 */