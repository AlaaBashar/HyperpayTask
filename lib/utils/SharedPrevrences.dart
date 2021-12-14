import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putUID(String key , String value) async {
    return await sharedPreferences!.setString(key, value);
  }

  static String? getUID(String key) {
    return sharedPreferences!.getString(key) ;
  }

}
