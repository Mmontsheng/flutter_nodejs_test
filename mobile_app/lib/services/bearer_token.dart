import 'package:shared_preferences/shared_preferences.dart';

class BearerTokenService {
  final String bearerKey = 'bearer';
  SharedPreferences sharedPreferences;

  BearerTokenService({required this.sharedPreferences});
  String get() {
    return sharedPreferences.getString(bearerKey) == null
        ? ''
        : sharedPreferences.getString(bearerKey)!;
  }

  void save(token) {
    sharedPreferences.setString(bearerKey, token);
  }

  void remove() {
    sharedPreferences.remove(bearerKey);
  }
}
