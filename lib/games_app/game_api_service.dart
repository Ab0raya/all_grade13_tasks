import 'package:dio/dio.dart';
import 'game_model.dart';

class GameApiService{
  final dio = Dio();
  List<GameModel> games = [];

  Future<List<GameModel>> fetchGames()async{
    final response = await dio.get('https://www.mmobomb.com/api1/games');
    if(response.statusCode == 200){
      for(var element in response.data){
        final GameModel game = GameModel.fromJson(element);
        games.add(game);
      }
      return games;
    }else{
      return games;
    }
  }
}