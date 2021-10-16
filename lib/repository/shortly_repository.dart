
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShortlyRepository{

   Future<ShortlyModel?> fetchShortlyData() async {
    var url = Uri.parse("https://api.shrtco.de/v2/shorten?url=www.google.com");
         http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> resMap = jsonDecode(response.body);
      return ShortlyModel.fromJson(resMap['Result']);
    }

  }






}