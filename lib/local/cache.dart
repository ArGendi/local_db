import 'package:shared_preferences/shared_preferences.dart';

class Cache{
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveEmail(String email) async{
    await sharedPreferences.setString("email", email);
  }

  static String? getEmail(){
    return sharedPreferences.getString("email");
  }

  static Future<void> removeEmail() async{
    await sharedPreferences.remove("email");
  }

  static Future<void> clearAll() async{
    await sharedPreferences.clear();
  }
}