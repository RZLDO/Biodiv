import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static saveUserPreferences(
      int id, String name, int level, String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', name);
    await preferences.setInt('level', level);
    await preferences.setString('token', token);
  }

  static deleteUserPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('name');
    await preferences.remove('address');
    await preferences.remove('level');
    await preferences.remove('token');
  }
}
