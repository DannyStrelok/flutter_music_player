import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/helpers/helpers.dart';
import 'package:flutter_music_player/src/models/audioplayer_model.dart';
import 'package:flutter_music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenSize.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.center,
                colors: [
                  Color(0xff333333e),
                  Color(0xff201e28),
                ]
              )
            ),
          ),
          Column(
            children: [
              CustomAppBar(),
              TimelineProgressBar(),
              TituloPlay(),
              Expanded(
                  child: Lyrics()
              )
            ],
          )
        ],
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics.map((linea) => Text(linea, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),)).toList(),
      ),
    );
  }
}


class TimelineProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          ImagenDisco(),
          Spacer(),
          ProgressBar(),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  AnimationController animationController;

  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void open() {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(
      Audio("assets/Breaking-Benjamin-Far-Away.mp3"),
      autoStart: true,
      showNotification: true
    );

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text('Titulo', style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8)),),
              Text('Grupo', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {

              final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);

              if(this.isPlaying) {
                animationController.reverse();
                this.isPlaying = false;
                audioPlayerModel.animationController.stop();
              } else {
                animationController.forward();
                this.isPlaying = true;
                audioPlayerModel.animationController.repeat();
              }

              if(firstTime) {
                this.open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }

            },
            backgroundColor: Color(0xfff8cb51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: animationController,
            ),
          )
        ],
      ),
    );
  }
}


class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final audioModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioModel.porcentaje;

    return Container(
      child: Column(
        children: [
          Text("${audioModel.songTotalDuration}", style: TextStyle(color: Colors.white.withOpacity(0.4)),),
          SizedBox(height: 10,),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Container(
                width: 3,
                height: 230 * porcentaje,
                color: Colors.white.withOpacity(0.8),
              )
            ],
          ),
          SizedBox(height: 10,),
          Text("${audioModel.currentSecond}", style: TextStyle(color: Colors.white.withOpacity(0.4)),),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1e1c24),
          ]
        ),
        borderRadius: BorderRadius.circular(200)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
                duration: Duration(seconds: 10),
                infinite: true,
                manualTrigger: true,
                animate: false,
                controller: (controller) => audioPlayerModel.animationController = controller,
                child: Image(image: AssetImage('assets/aurora.jpg'), fit: BoxFit.contain,)
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: Color(0xff1c1c25),
                  borderRadius: BorderRadius.circular(100)
              ),
            )
          ],
        ),
      ),
    );
  }
}
