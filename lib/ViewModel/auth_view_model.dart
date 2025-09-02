import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class AuthViewModel extends ChangeNotifier {

  UserModel? currentUser;

  Future<void> fetchUserProfile() async {
    try {
      final url = Uri.parse("https://caseapi.servicelabs.tech/user/profile");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        currentUser = UserModel.fromJson(data);
        notifyListeners();

        if (kDebugMode) {
          print("DEBUG -> User information successfully fetched: ${currentUser?.name}");
        }
      } else {
        if (kDebugMode) {
          print("ERROR -> Profile can not be fetched. Status: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION -> ${e.toString()}");
      }
    }
  }


}