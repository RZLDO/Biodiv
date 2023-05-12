import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static saveUserPreferences(
      int id, String name, int level, String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('id', id);
    await preferences.setString('name', name);
    if (level == 1) {
      await preferences.setString('level', "BKSDA");
    } else if (level == 2) {
      await preferences.setString('level', "LSM");
    } else {
      await preferences.setString('level', 'MASYARAKAT');
    }
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
