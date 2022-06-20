import 'package:shared_preferences/shared_preferences.dart';

void createSHR(bool isShow) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("show", isShow);
}

Future<bool?> getSHR() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool("show");
}
