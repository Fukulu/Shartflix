import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/favorite_movie_model.dart';
import '../Model/movie_model.dart';
import '../Core/Storage/secure_storage.dart';

class MovieViewModel extends ChangeNotifier {
  static const String _baseUrl = "https://caseapi.servicelabs.tech";

  String? token;
  List<MovieModel> movies = [];
  int totalPages = 0;
  int currentPage = 1;
  int lastFetchedPage = 0;
  bool isLoading = false;

  // FAVORITES
  List<String> favoriteMovieIds = [];
  List<FavoriteMovieModel> favoriteMovies = [];
  bool isFavoriteLoading = false;

  void reset() {
    movies = [];
    totalPages = 0;
    currentPage = 1;
    lastFetchedPage = 0;
    isLoading = false;
    favoriteMovieIds = [];
    favoriteMovies = [];
    isFavoriteLoading = false;
    notifyListeners();
  }

  Future<void> _loadToken() async {
    token = await SecureStorage.read("auth_token");
  }

  // TAG - FETCH MOVIES WITH PAGINATION
  Future<void> fetchMovies({int page = 1}) async {
    await _loadToken();
    if (token == null) return;

    if (isLoading || page <= lastFetchedPage) return;

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse("$_baseUrl/movie/list?page=$page");
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieList = (data["data"]["movies"] as List?) ?? [];
        final newMovies = movieList.map((m) => MovieModel.fromJson(m)).toList();

        if (page == 1) {
          movies = newMovies;
        } else {
          movies.addAll(newMovies);
        }

        totalPages = data["data"]["totalPages"] ?? totalPages;
        currentPage = page;
        lastFetchedPage = page;

        if (kDebugMode) {
          print("DEBUG -> ${movies.length} films loaded. Page: $page/$totalPages");
        }
      } else {
        debugPrint("ERROR -> fetchMovies failed: ${response.statusCode}");
        debugPrint("DEBUG -> Body: ${response.body}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> fetchMovies error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // TAG - FETCH FAVORITES
  Future<void> fetchFavorites() async {
    await _loadToken();
    if (token == null) return;

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/movie/favorites"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final movieList = (decoded["data"] as List?) ?? [];

        favoriteMovies = movieList
            .map((m) => FavoriteMovieModel.fromJson(m as Map<String, dynamic>))
            .toList();

        favoriteMovieIds = favoriteMovies.map((m) => m.id).toList();

        notifyListeners();

        if (kDebugMode) {
          print("DEBUG -> ${favoriteMovies.length} favorite films fetched");
        }
      } else {
        debugPrint("ERROR -> fetchFavorites failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> fetchFavorites error: $e");
    }
  }


  // TAG - TOGGLE FAVORITE
  Future<void> toggleFavorite(String movieId) async {
    if (isFavoriteLoading) return;

    isFavoriteLoading = true;
    notifyListeners();

    await _loadToken();
    if (token == null) {
      isFavoriteLoading = false;
      notifyListeners();
      return;
    }

    try {
      final url = Uri.parse("$_baseUrl/movie/favorite/$movieId");
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        await fetchFavorites();
      } else {
        debugPrint("ERROR -> toggleFavorite failed: ${response.statusCode}");
        debugPrint("DEBUG -> Body: ${response.body}");
      }
    } catch (e) {
      debugPrint("EXCEPTION -> toggleFavorite error: $e");
    } finally {
      isFavoriteLoading = false;
      notifyListeners();
    }
  }
}
