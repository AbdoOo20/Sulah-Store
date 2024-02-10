import 'package:khedmaty_store/core/routing/route.dart';
import 'package:khedmaty_store/presentation/screens/auth/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/app_constants.dart';
import '../../presentation/screens/splash/splash.dart';
import '../datasource/remote/dio/dio_client.dart';

class SaveUserData {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;

  SaveUserData({required this.sharedPreferences, required this.dioClient});
  /// save SharedData
  Future<void> saveLang(String lang) async {
    try {
      await sharedPreferences.setString(AppConstants.lang, lang);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserId(String userId) async {
    try {
      await sharedPreferences.setString(AppConstants.userId, userId);
    } catch (e) {
      throw e;
    }
  }  Future<void> saveUserLong(String lat) async {
    try {
      await sharedPreferences.setString(AppConstants.long, lat);
    } catch (e) {
      throw e;
    }
  }  Future<void> saveUserLat(String lat) async {
    try {
      await sharedPreferences.setString(AppConstants.lat, lat);
    } catch (e) {
      throw e;
    }
  }  Future<void> saveUserAddress(String address) async {
    try {
      await sharedPreferences.setString(AppConstants.address, address);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserToken(String userTOKEN) async {
    dioClient.updateHeader(userTOKEN);
    try {
      await sharedPreferences.setString(AppConstants.userTOKEN, userTOKEN);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserName(String userName) async {
    try {
      await sharedPreferences.setString(AppConstants.userName, userName);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserImage(String userImage) async {
    try {
      await sharedPreferences.setString(AppConstants.userImage, userImage);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserEmail(String userEmail) async {
    try {
      await sharedPreferences.setString(AppConstants.userEmail, userEmail);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserPhone(String userPhone) async {
    try {
      await sharedPreferences.setString(AppConstants.userPhone, userPhone);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserDepartmentId(String userDepartmentId) async {
    try {
      await sharedPreferences.setString(
          AppConstants.userDepartmentId, userDepartmentId);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserDepartmentTitle(String userDepartmentTitle) async {
    try {
      await sharedPreferences.setString(
          AppConstants.userDepartmentTitle,userDepartmentTitle);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserIsNotification(bool userIsNotification) async {
    try {
      await sharedPreferences.setBool(
          AppConstants.isNotification,userIsNotification);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserIsAvailable(bool userIsAvailable) async {
    try {
      await sharedPreferences.setBool(
          AppConstants.isAvailable,userIsAvailable);
    } catch (e) {
      throw e;//installed
    }
  }
  Future<void> saveIsIntroShow(bool isIntroShow) async {
    try {
      await sharedPreferences.setBool(
          AppConstants.isIntroShow,isIntroShow);
    } catch (e) {
      throw e;
    }
  }


  ///get SharedData
  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.userTOKEN) ?? "";
  }  String getUserLat() {
    return sharedPreferences.getString(AppConstants.lat) ?? "";
  }  String getUserLong() {
    return sharedPreferences.getString(AppConstants.long) ?? "";
  }  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.address) ?? "";
  }

  String getLang() {
    return sharedPreferences.getString(AppConstants.lang) ?? "ar";
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.userName) ?? "";
  }

  String getUserImage() {
    return sharedPreferences.getString(AppConstants.userImage) ?? "";
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.userEmail) ?? "";
  }

  String getUserPhone() {
    return sharedPreferences.getString(AppConstants.userPhone) ?? "";
  }


  String getUserDepartmentId() {
    return sharedPreferences.getString(AppConstants.userDepartmentId)??"";
  }
  String getUserDepartmentTitle() {
    return sharedPreferences.getString(AppConstants.userDepartmentTitle)??"";
  }
  /// check
  bool isLoggedIn() {
    return sharedPreferences.getString(AppConstants.userTOKEN)==null||sharedPreferences.getString(AppConstants.userTOKEN)==''?false:true;
  }
  bool isAvailable() {
    return sharedPreferences.getBool(AppConstants.isAvailable)??false;
  }
  bool getIsIntroShow() {
    return sharedPreferences.getBool(AppConstants.isIntroShow)??false;
  }
  bool isNotification() {
    return sharedPreferences.getBool(AppConstants.isNotification)??false;
  }
  ///clear SharedData
  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.userName);
    await sharedPreferences.remove(AppConstants.userImage);
    await sharedPreferences.remove(AppConstants.userId);
    await sharedPreferences.remove(AppConstants.userTOKEN);
    await sharedPreferences.remove(AppConstants.userEmail);
    await sharedPreferences.remove(AppConstants.userPhone);
    await sharedPreferences.remove(AppConstants.userDepartmentId);
    pushAndRemoveUntil(LoginScreen());
    return true;
  }
}
