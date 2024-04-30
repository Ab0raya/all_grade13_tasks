class GameModel{
  final String gameName;
  final String desc;
  final String img;
  factory GameModel.fromJson(dynamic data ){
    return GameModel(
        gameName: data['title'],
        img: data['thumbnail'],
        desc: data['short_description'],
    );
  }
  GameModel({required this.gameName, required this.img , required this.desc});
}