import 'package:flutter/material.dart';
import 'package:grade13/games_app/game_api_service.dart';
import 'package:grade13/games_app/game_model.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  final GameApiService _gameApiService = GameApiService();
  late Future<List<GameModel>> futureGames;

  @override
  void initState() {
    futureGames = _gameApiService.fetchGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gems App',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff212121),
      ),
      backgroundColor: const Color(0xff5f5a5f),
      body: SafeArea(
        child: FutureBuilder(
          future: futureGames,
          builder: (context, snapshot) {
            final gamesList = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final game = gamesList?[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  width: 300,
                  height: 390,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          color: Colors.red,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(game?.img ??
                                'https://static.vecteezy.com/system/resources/thumbnails/006/692/205/small/loading-icon-template-black-color-editable-loading-icon-symbol-flat-illustration-for-graphic-and-web-design-free-vector.jpg'),

                          ),
                        ),
                      ),
                       Text(game?.gameName??'Loading...',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
                       Text(game?.desc??'Loading...',style: const TextStyle(color: Colors.grey,fontSize: 22,),
                       maxLines: 3,
                         overflow: TextOverflow.fade,
                       ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
