import 'package:flutter/material.dart';
import 'package:grade13/news_app/news_api_service.dart';

import 'news_model.dart';

class NewsHomeView extends StatefulWidget {
  const NewsHomeView({super.key});

  @override
  State<NewsHomeView> createState() => _NewsHomeViewState();
}

class _NewsHomeViewState extends State<NewsHomeView> {
  NewsApiService newsApiService = NewsApiService();
  late Future<List<NewsModel>> futureNews;

  @override
  void initState() {
    futureNews = newsApiService.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter news',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 29,color: Colors.blueAccent)),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: futureNews,
          builder: (context, snapshot) {
            final newsList = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context,index){
                  final newsData = newsList?[index]  ?? NewsModel(title: "Loading...", description: "Loading...", imgUrl: 'https://static.vecteezy.com/system/resources/thumbnails/006/692/205/small/loading-icon-template-black-color-editable-loading-icon-symbol-flat-illustration-for-graphic-and-web-design-free-vector.jpg');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.center, child: Image.network(newsData.imgUrl??'')),
                      const SizedBox(height: 15,),
                       Text(newsData.title ?? '',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
                       Text(newsData.description ?? '',style: const TextStyle(fontSize: 23,color: Colors.grey),maxLines: 3,),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
