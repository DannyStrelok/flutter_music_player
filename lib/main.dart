import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/models/audioplayer_model.dart';
import 'package:flutter_music_player/src/screens/music_player_screen.dart';
import 'package:flutter_music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AudioPlayerModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reproductor de música',
        theme: miTema,
        home: MusicPlayerScreen(),
      ),
    );
  }
}
