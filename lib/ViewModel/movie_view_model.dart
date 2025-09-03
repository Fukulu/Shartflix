import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieViewModel extends ChangeNotifier {
  static const String _baseUrl = "https://caseapi.servicelabs.tech";

  String? token;
  List<MovieModel> movies = [];
  int totalPages = 0;
  int currentPage = 1;
  bool isLoading = false;

  // TAG - FETCH MOVIES WITH PAGINATION
  Future<void> fetchMovies({int page = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("auth_token");

    if (token == null) return;

    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse("$_baseUrl/movie/list?page=$page");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final movieList = (data["data"]["movies"] as List?) ?? [];
        final newMovies = movieList.map((m) => MovieModel.fromJson(m)).toList();

        if (page == 1) {
          movies = newMovies; // ilk sayfada overwrite
        } else {
          movies.addAll(newMovies); // sonraki sayfalarda ekle
        }

        totalPages = data["data"]["totalPages"] ?? totalPages;
        currentPage = page;

        if (kDebugMode) {
          print("DEBUG -> ${movies.length} film yüklendi. Sayfa: $currentPage/$totalPages");
        }
      } else {
        if (kDebugMode) {
          print("ERROR -> fetchMovies failed: ${response.statusCode}");
          print("DEBUG -> Body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("EXCEPTION -> fetchMovies error: $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
