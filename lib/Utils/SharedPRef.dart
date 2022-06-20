import 'package:shared_preferences/shared_preferences.dart';

void createShared(String uid) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("uid", uid);
}

Future<String?> getuidSHR() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("uid");
}
