import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Add shared_preferences
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_event.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews); // Register the handler for FetchNews event
    on<SearchNews>(_onSearchNews); // Register the handler for SearchNews event
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2024-05-18&sortBy=publishedAt&apiKey=d12ca6cce1f248a591012a9e0df1db45'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'ok') {
          emit(NewsLoaded(articles: data['articles']));

          // Store response in local storage (SharedPreferences)
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('newsResponse', json.encode(data['articles']));
        } else {
          emit(NewsError(message: 'Error: ${data['message']}'));
        }
      } else {
        emit(NewsError(
            message:
            'Failed to fetch news. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(NewsError(message: 'Failed to fetch news. Error: $e'));
    }
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedData = prefs.getString('newsResponse');

      if (storedData != null) {
        List<dynamic> articles = json.decode(storedData);

        // Filter articles based on search text
        List<dynamic> filteredArticles = articles
            .where((article) =>
            (article['title'] as String)
                .toLowerCase()
                .contains(event.searchTerm.toLowerCase()))
            .toList();

        emit(NewsLoaded(articles: filteredArticles));
      } else {
        emit(NewsError(message: 'No cached news available'));
      }
    } catch (e) {
      emit(NewsError(message: 'Failed to search news. Error: $e'));
    }
  }
}
