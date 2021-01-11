import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _isPlaying = false;
  AnimationController _animationController;
  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current = new Duration(milliseconds: 0);

  String get songTotalDuration => this.printDuration(this._songDuration);
  String get currentSecond => this.printDuration(this._current);

  double get porcentaje => (this._songDuration.inSeconds > 0)
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  AnimationController get animationController => _animationController;

  set animationController(AnimationController value) {
    _animationController = value;
  }

  Duration get current => _current;

  set current(Duration value) {
    _current = value;
    notifyListeners();
  }

  Duration get songDuration => _songDuration;

  set songDuration(Duration value) {
    _songDuration = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if(n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

}
