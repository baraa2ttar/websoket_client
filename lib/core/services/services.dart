// import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../constant/constant.dart';
// import '../constant/pref_key.dart';
//
// class MyServices extends GetxService {
//   late SharedPreferences sharedPreferences;
//   Future<MyServices> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//
//
//     return this;
//   }
//
//   static Future<void> saveStringValue(String key, String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, value);
//   }
//
//   Future<String?> getStringValue(String key) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key);
//   }
//
//   static Future <void> removeData(String key) async{
//
//        final SharedPreferences prefs = await SharedPreferences.getInstance();
//        await   prefs.remove(key);
//
//   }
//
//   static Future <void> removeAllData() async{
//
//        final SharedPreferences prefs = await SharedPreferences.getInstance();
//        await   prefs.clear();
//
//   }
//
//    Future saveTokenUser(String token)async{
//      await  saveStringValue(PrefKey.token, token );
//      print('////TokenUser.....////${PrefKey.token}');
//
//   }
//
//
// }
//
// Future<void> asyncingData() async {
//   await Get.putAsync(() => MyServices().init());
// }
//
