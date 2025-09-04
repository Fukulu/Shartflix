import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';
import '../Core/Storage/secure_storage.dart';

class AuthViewModel extends ChangeNotifier {
  String? token;
  UserModel? currentUser;

  static const String _baseUrl = "https://caseapi.servicelabs.tech";

  // TAG - INITIALIZE TO FETCH TOKEN & PROFILE
  Future<void> init() async {
    token = await SecureStorage.read("auth_token");

    if (token != null) {
      debugPrint("DEBUG -> Token found in storage, fetching profile...");
      await fetchUserProfile();
    } else {
      debugPrint("DEBUG -> No token found, user not logged in.");
    }
  }

  // TAG - FETCH USER PROFILE
  Future<void> fetchUserProfile() async {
    token = await SecureStorage.read("auth_token");
    if (token == null) {
      debugPrint("ERROR -> No token available!");
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
        final data = body["data"];
        if (data != null) {
          currentUser = UserModel.fromJson(data);
          notifyListeners();
          if (kDebugMode) {
            print("DEBUG -> User info fetched: ${currentUser?.name}");
          }
        }
      } else {
        debugPrint("ERROR -> Profile fetch failed. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> fetchUserProfile error: $e");
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
        await SecureStorage.write("auth_token", token!);

        await fetchUserProfile();

        debugPrint("DEBUG -> Login successful, token saved securely.");
        debugPrint("DEBUG -> Current User: ${currentUser?.name}");

        notifyListeners();
      } else {
        debugPrint("ERROR -> Login failed: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> loginUser error: $e");
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
          debugPrint("ERROR -> Register response data is null");
          return;
        }

        token = data["token"];
        await SecureStorage.write("auth_token", token!);

        currentUser = UserModel.fromJson(data);
        notifyListeners();

        debugPrint("DEBUG -> Register successful, token saved securely.");
      } else {
        debugPrint("ERROR -> Register failed: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> registerUser error: $e");
    }
  }

  // TAG - UPLOAD PHOTO
  Future<void> uploadPhoto(File imageFile) async {
    token = await SecureStorage.read("auth_token");
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
        await fetchUserProfile();
        debugPrint("DEBUG -> Photo uploaded and profile refreshed.");
      } else {
        debugPrint("ERROR -> Photo upload failed: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> uploadPhoto error: $e");
    }
  }

  // TAG - LOGOUT
  Future<void> logout() async {
    await SecureStorage.delete("auth_token");
    token = null;
    currentUser = null;
    notifyListeners();

    if (kDebugMode) print("DEBUG -> Logged out, token removed securely.");
  }
}
