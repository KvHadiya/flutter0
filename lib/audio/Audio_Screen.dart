import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class Audio_screen extends StatefulWidget {
  const Audio_screen({Key? key}) : super(key: key);

  @override
  State<Audio_screen> createState() => _Audio_screenState();
}

class _Audio_screenState extends State<Audio_screen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlay = false;
  Icon iconMusic = Icon(Icons.play_arrow);
  Duration tDU = Duration(seconds: 0);
  Duration cDU = Duration(seconds: 0);

  @override
  initState() {
    super.initState();
    assetsAudioPlayer.open(
      Audio("assets/audio/yy.mp3"),
      autoStart: false,
      showNotification: true,
    );

    assetsAudioPlayer.current.listen((event) {
      tDU = event!.audio.duration;
    });

    assetsAudioPlayer.current.listen((event) {
      String data = event!.audio.audio.metas.title.toString();
      print("========== $data");
    });


  }

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  playaudio();
                },
                icon: iconMusic,
              ),
              PlayerBuilder.currentPosition(
                player: assetsAudioPlayer,
                builder: (context, duration) {
                  return Column(
                    children: [
                      Slider(
                        value: duration.inSeconds.toDouble(),
                        max: tDU.inSeconds.toDouble(),
                        onChanged: (value) {

                          assetsAudioPlayer.seek(Duration(seconds: value.toInt()));

                          print("======Time $cDU");
                        },
                      ),
                      Text("$duration/$tDU"),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void playaudio() {
    if (isPlay == false) {
      assetsAudioPlayer.play();
      setState(() {
        isPlay = true;
        iconMusic = Icon(Icons.pause);
      });
    } else {
      assetsAudioPlayer.pause();
      setState(() {
        isPlay = false;
        iconMusic = Icon(Icons.play_arrow);
      });
    }


  }
}
