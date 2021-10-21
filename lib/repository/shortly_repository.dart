import 'package:hyperpay_task/database_shortly/database_helper.dart';
import 'package:hyperpay_task/database_shortly/model_database.dart';
import 'package:hyperpay_task/model/shortly_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShortlyRepository {



  static const String _baseUrl = 'https://api.shrtco.de/v2';

  static DbHelper? _helper = DbHelper();

  Future<ShortlyResult?> fetchShortlyData(String url) async {
    http.Response response =
        await http.get(Uri.parse("$_baseUrl/shorten?url=$url"));

    Map<String, dynamic> resMap = jsonDecode(response.body);

    ShortlyModel shortlyModel = ShortlyModel.fromJson(resMap);

    if (shortlyModel.ok) {
      ShortlyModelDB shortlyModelDB = ShortlyModelDB();
      shortlyModelDB
        ..originalLink = url
        ..shortlyLink = shortlyModel.result.fullShortLink;
      await _helper!.insertDate(shortlyModelDB);
      return ShortlyResult.fromJson(resMap['result']);
    }
  }

}
