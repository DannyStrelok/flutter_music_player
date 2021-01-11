import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/widgets/custom_appbar.dart';
class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          TimelineProgressBar()
        ],
      ),
    );
  }
}

class TimelineProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          ImagenDisco(),
          Spacer(),
          ProgressBar(),
          //SizedBox(width: 20,)
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('00:00', style: TextStyle(color: Colors.white.withOpacity(0.4)),),
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
                height: 150,
                color: Colors.white.withOpacity(0.8),
              )
            ],
          ),
          SizedBox(height: 10,),
          Text('00:00', style: TextStyle(color: Colors.white.withOpacity(0.4)),),
        ],
      ),
    );
  }
}


class ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Image(image: AssetImage('assets/aurora.jpg'), fit: BoxFit.contain,),
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
