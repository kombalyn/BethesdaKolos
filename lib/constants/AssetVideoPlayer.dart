import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetVideoPlayer extends StatefulWidget {
  @override
  _AssetVideoPlayerState createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video_1_1.mp4')
      ..initialize().then((_) {
        setState(() {}); // Frissíti a képernyőt, miután inicializálódott
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Felszabadítja az erőforrásokat
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            CircularProgressIndicator(), // Betöltési animáció
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  setState(() {
                    _controller.seekTo(Duration.zero); // Visszateker az elejére
                    _controller.pause(); // Leállítja a videót
                  });
                },
              ),
            ],
          ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true, // Engedi a csúszkán való navigációt
            colors: VideoProgressColors(
              playedColor: Colors.blue,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
