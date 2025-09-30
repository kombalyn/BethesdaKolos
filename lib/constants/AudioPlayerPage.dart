import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class AudioPlayerPage extends StatefulWidget {
  final String url;
  final String azonosito;
  final String hangfajlszam;
  final VoidCallback onUzenetKuldes; // Callback a szülő osztály számára


  AudioPlayerPage({
    required this.url,
    required this.azonosito,
    required this.hangfajlszam,
    required this.onUzenetKuldes, // Callback inicializálása
  });
  @override
  _AudioControlsState createState() =>
      _AudioControlsState(url, azonosito, hangfajlszam, onUzenetKuldes);
}

class _AudioControlsState extends State<AudioPlayerPage> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  double _sliderValue = 0.0;
  bool _isDraggingSlider = false;
  late Duration _currentPosition = Duration.zero;
  late Duration maxPosition = Duration.zero;
  double _maxDuration = 100.0;
  String url;
  double _currentSliderValue = 0.0;
  bool isPlaying = false;
  String azonosito = "";
  String hangfajlszam = "";
  final VoidCallback onUzenetKuldes; // Callback referenciája
  int gombnyomva=0;

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  _AudioControlsState(
      this.url,
      this.azonosito,
      this.hangfajlszam,
      this.onUzenetKuldes,
      );

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio.network(url),
      autoStart: false,
      showNotification: true,
    );

    _assetsAudioPlayer.currentPosition.listen((duration) {
      setState(() {
        if (!_isDraggingSlider) {
          _currentPosition = duration;
          _sliderValue = _currentPosition.inSeconds.toDouble();
        }
      });
    });

    _assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        if (playingAudio != null) {
          _maxDuration = playingAudio.audio.duration.inSeconds.toDouble();
          maxPosition = Duration(seconds: _maxDuration.toInt());
        } else {
          _maxDuration = 100.0;
        }
      });
    });

    _assetsAudioPlayer.isPlaying.listen((playing) {
      setState(() {
        isPlaying = playing;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [if (hours > 0) hours, twoDigits(minutes), twoDigits(seconds)].join(':');
  }

  void uzenet_kuldes(){
    print("uzenet elkuldve");
    _channel = WebSocketChannel.connect(
       //Uri.parse('wss://34.72.67.6:8089'),
        Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
     );

    //_channel.sink.add("megnezte|ABCDE,mp3_3") ;
    //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.sink.add("megnezte|$azonosito,$hangfajlszam");
    print("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
     print('Received message: $message');
    });
  }
  // fentebb majd legyen: megnezte|A34BD,mp3_3 vagy valami hasonlo


  void _togglePlayPause() {
    if (isPlaying) {
      _assetsAudioPlayer.pause();
    } else {
      _assetsAudioPlayer.play();
      if(gombnyomva==0){
        uzenet_kuldes();
        setState(() {
          gombnyomva=1;
        });
      }
      // Callback meghívása
      onUzenetKuldes();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Grey background color
        borderRadius: BorderRadius.circular(30), // Rounded corners
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
              Text(
                '${_formatDuration(_currentPosition)} / ${_formatDuration(maxPosition)}',
                style: TextStyle(fontSize: 14),
              ),
              Expanded(
                child: Slider(
                  value: _sliderValue,
                  min: 0.0,
                  max: _maxDuration,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _isDraggingSlider = true;
                      _currentSliderValue = value; // Update _currentSliderValue here
                    });
                  },
                  onChangeEnd: (value) {
                    _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                    setState(() {
                      _isDraggingSlider = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
