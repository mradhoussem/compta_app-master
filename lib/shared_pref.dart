import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferences_class{

  final String _Key_facebook_connection = "_Key_facebook_connection";


  Future<String> getFacebook_connection_shared_pref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(_Key_facebook_connection);
  }

  Future<String> setFacebook_connection_shared_pref(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_Key_facebook_connection, value);
  }
}