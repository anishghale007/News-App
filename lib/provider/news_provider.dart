import 'package:dio/dio.dart';
import 'package:flutter_news/model/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final newsProvider = FutureProvider((ref) => NewsProvider().getData());

final newsProvider =
    StateNotifierProvider<NewsProvider, List<News>>((ref) => NewsProvider());

class NewsProvider extends StateNotifier<List<News>> {
  NewsProvider() : super([]) {
    getData();
  }

  Future<void> getData() async {
    final dio = Dio();

    try {
      final response =
          await dio.get('https://free-news.p.rapidapi.com/v1/search',
              queryParameters: {'q': 'news', 'lang': 'en'},
              options: Options(headers: {
                'x-rapidapi-host': 'free-news.p.rapidapi.com',
                'x-rapidapi-key':
                    'bf5ec94953msh94dc7db178f218cp1f29f2jsn7e7fdfb01965'
              }));

      if (response.data['status'] == 'No matches for your search.') {
          state = [News(title: 'not found', author: '', published_date: '', link: '', summary: '', media: '')];
      } else {
        final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
        state = data;
      }
    } on DioError catch (err) {
      print(err.response);
    }
  }

  Future<void> searchNews({required String query}) async {
    final dio = Dio();

    try {
      state = [];
      final response =
          await dio.get('https://free-news.p.rapidapi.com/v1/search',
              queryParameters: {'q': query, 'lang': 'en'},
              options: Options(headers: {
                'x-rapidapi-host': 'free-news.p.rapidapi.com',
                'x-rapidapi-key':
                    'bf5ec94953msh94dc7db178f218cp1f29f2jsn7e7fdfb01965'
              }));
      if (response.data['status'] == 'No matches for your search.') {
        state = [News(title: 'not found', author: '', published_date: '', link: '', summary: '', media: '')];
      } else {
        final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
        state = data;
      }
    } on DioError catch (err) {
      print(err.response);
    }
  }
}
