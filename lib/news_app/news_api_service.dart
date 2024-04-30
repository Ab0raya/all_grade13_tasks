import 'package:dio/dio.dart';

import 'news_model.dart';

class NewsApiService{
final dio = Dio();
List<NewsModel> articles = [];

Future<List<NewsModel>> fetchData() async{
  final response = await dio.get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=711803c4c9f74be09393efd59ec52e64');
  if(response.statusCode == 200){
    for(var element in response.data['articles']){
      final article = NewsModel.fromJson(element);
      articles.add(article);
    }
    return articles;
  }else{
    return articles;
  }
}
}