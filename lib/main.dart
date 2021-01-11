import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/screens/music_player_screen.dart';
import 'package:flutter_music_player/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reproductor de música',
      theme: miTema,
      home: MusicPlayerScreen(),
    );
  }
}
