import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> storeUserData(
      int userId,
      String email,
      String firstName,
      String lastName,
      String position,
      String phoneNumber,
      String gender,
      String? profilePicture,
      int age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
    prefs.setString('email', email);
    prefs.setString('firstName', firstName);
    prefs.setString('lastName', lastName);
    prefs.setString('position', position);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('gender', gender);
    prefs.setString('profilePicture', profilePicture!);
    prefs.setInt('age', age);
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId');
    String email = prefs.getString('email') ?? '';
    String firstName = prefs.getString('firstName') ?? '';
    String lastName = prefs.getString('lastName') ?? '';
    String position = prefs.getString('position') ?? '';
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String gender = prefs.getString('gender') ?? '';
    String? profilePicture = prefs.getString('profilePicture');
    int age = prefs.getInt('age') ?? 0;

    return {
      'userId': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'profilePicture': profilePicture,
      'age': age,
    };
  }

  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
