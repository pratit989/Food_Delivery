import 'dart:convert';
import 'package:food_app/Model/restaurant_model.dart';
import 'package:http/http.dart';

class Webservice {

  final _response = get(Uri(
  scheme: 'https',
  host: 'mocky.io',
  path: 'v2/5dfccffc310000efc8d2c1ad'
  ));

  Future<List<Restaurant>> fetchRestaurant() async {
    final response = await _response;
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      final Iterable json = body;
      return json.map((restaurant) => Restaurant.fromJson(restaurant)).toList();

    } else {
      throw Exception("Unable to perform request!");
    }
  }
}