import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'dart:convert';

class SharedPreferencesUtil {
  static const String LAST_CALCULATION_KEY = 'last_calculation';

  static Future<void> saveLastCalculation(UserModel user, double calories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode({'user': user.toJson(), 'calories': calories});
    await prefs.setString(LAST_CALCULATION_KEY, data);
  }

  static Future<Map<String, dynamic>?> getLastCalculation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(LAST_CALCULATION_KEY);

    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  static Future<void> clearLastCalculation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(LAST_CALCULATION_KEY);
  }
}
