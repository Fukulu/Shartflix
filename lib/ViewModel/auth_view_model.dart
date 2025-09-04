import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/user_model.dart';
import 'dart:io';

class AuthViewModel extends ChangeNotifier {
  String? token;
  UserModel? currentUser;

  static const String _baseUrl = "https://caseapi.servicelabs.tech";

  // TAG - INITIALIZE TO FETCH TOKEN & PROFILE
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");

    if (token != null) {
      if (kDebugMode) {
        print("DEBUG -> Token found in storage, fetching profile...");
      }
      await fetchUserProfile();
    } else {
      if (kDebugMode) {
        print("DEBUG -> No token found, user not logged in.");
      }
    }
  }

  // TAG - FETCH USER PROFILE
  Future<void> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");
    if (token == null) {
      if (kDebugMode) print("ERROR -> No token available!");
      return;
    }

    try {
      final url = Uri.parse("$_baseUrl/user/profile");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final data = body["data"]; // ✅ sadece "data" kısmını al
        if (data != null) {
          currentUser = UserModel.fromJson(data);
          notifyListeners();

          if (kDebugMode) {
            print("DEBUG -> User info fetched: ${currentUser?.name}");
          }
        }
      } else {
        if (kDebugMode) {
          print("ERROR -> Profile fetch failed. Status: ${response.statusCode}");
          print("DEBUG -> Body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION -> ${e.toString()}");
      }
    }
  }

  // TAG - LOGIN USER
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final data = decoded["data"];
        if (data == null) {
          debugPrint("ERROR -> Login response missing data");
          return;
        }

        token = data["token"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token!);

        await fetchUserProfile();

        if (kDebugMode) {
          print("DEBUG -> Login successful, token saved: $token");
          print("DEBUG -> Current User: ${currentUser?.name}");
          print("DEBUG -> Current User Email: ${currentUser?.email}");
          print("DEBUG -> Current User Photo URL: ${currentUser?.id}");
        }

        notifyListeners();
      } else {
        if (kDebugMode) {
          print("DEBUG -> Login failed: ${response.statusCode}");
          print("DEBUG -> Body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG -> Error during login: $e");
      }
    }
  }

  // TAG - REGISTER USER
  Future<void> registerUser(String email, String name, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/user/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final data = body["data"];
        if (data == null) {
          if (kDebugMode) print("ERROR -> Register response data is null");
          return;
        }

        token = data["token"];
        currentUser = UserModel.fromJson(data);

        // Token'ı kaydet
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token!);

        if (kDebugMode) {
          print("DEBUG -> Register successful, token saved: $token");
          print("DEBUG -> Current User: ${currentUser?.name}");
        }

        notifyListeners();
      } else {
        if (kDebugMode) {
          print("ERROR -> Register failed: ${response.statusCode}");
          print("DEBUG -> Body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION -> Register error: $e");
      }
    }
  }

  // TAG - UPLOAD PHOTO
  Future<void> uploadPhoto(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");
    if (token == null) return;

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$_baseUrl/user/upload_photo"),
      );
      request.headers["Authorization"] = "Bearer $token";
      request.files.add(await http.MultipartFile.fromPath("file", imageFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final photoUrl = data["photoUrl"];

        if (kDebugMode) {
          print("DEBUG -> Photo successfully uploaded: $photoUrl");
        }

        await fetchUserProfile();
      } else {
        if (kDebugMode) {
          print("ERROR -> Photo upload failed. Status: ${response.statusCode}, Body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION -> uploadPhoto error: $e");
      }
    }
  }

  // TAG - LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
    token = null;
    currentUser = null;

    if (kDebugMode) {
      print("DEBUG -> Logged out, token removed.");
    }
    notifyListeners();
  }

}
