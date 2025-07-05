import 'package:get/get.dart';

import 'core/constant/app_routs.dart';
import 'view/home_screen/Home_view/home_screen.dart';


List <GetPage <dynamic>> routes = [
  GetPage(name:AppRouts.homeScreen, page: () =>  HomeScreen()),
  //GetPage(name: AppRouts.visibilityScreen, page: () =>  VisibilityScreen()),
];