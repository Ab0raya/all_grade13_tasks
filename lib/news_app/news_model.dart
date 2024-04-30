class NewsModel {
  final String? title;
  final String? description;
  final String? imgUrl;

  factory NewsModel.fromJson(dynamic data) {
    return NewsModel(
      title: data['title'],
      description: data['description'],
      imgUrl: data['urlToImage'],
    );
  }

  NewsModel(
      {required this.title, required this.description, required this.imgUrl});
}
