import 'dart:js';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../home_page_model.dart';
export '../home_page_model.dart';




class ModuleHipnomp3_2 extends StatelessWidget {
  const ModuleHipnomp3_2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ModuleHipnoWidget(),
    );
  }
}



class ModuleHipnoWidget extends StatefulWidget {
  const ModuleHipnoWidget({super.key});

  @override
  State<ModuleHipnoWidget> createState() => _ModuleHipnotState();
}

class _ModuleHipnotState extends State<ModuleHipnoWidget> {
  late Duration _currentPosition;
  late AssetsAudioPlayer _assetsAudioPlayer;
  double _sliderValue = 0.0; // A csúszka értéke
  bool _isDraggingSlider = false;

  late HomePageModel _model;

  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  //late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  bool isOpened = false;

  //late AssetsAudioPlayer _assetsAudioPlayer;
  String _audioFilePath = 'hanganyag.mp3';
  //double _sliderValue = 0.0;
  //bool _isDraggingSlider = false;

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _assetsAudioPlayer = AssetsAudioPlayer();

    _assetsAudioPlayer.currentPosition.listen((duration) {
      setState(() {
        if (!_isDraggingSlider) {
          _currentPosition = duration;
          _sliderValue = _currentPosition.inSeconds.toDouble();
        }
      });
    });

  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white70,
        drawer: Drawer(
          elevation: 16,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(230, 20, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          'A második gyakorlat: Biztonságos hely',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                Row(
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          'A következő gyakorlatnak Biztonságos Hely a címe. Ebben a gyakorlatban egy újfajta légzést tanulhatsz meg. Ráadásul azt is megmutatjuk, hogyan tudod a kezeidet a hasadra helyezve átmelegíteni a pocakodat, hogy az még jobban érezze magát. Ezt követően arra kérünk majd, hogy alkoss egy képet a saját biztonságos helyedről. Sok gyerek szereti ezt a gyakorlatot, mert nyugodtnak és magabiztosnak érzi magát tőle. Hallgasd meg a gyakorlatot!',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE41B48),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                Image.asset("assets/images/gyakorlat2.jpg"),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black, width: 4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hátralévő idő: ${_currentPosition.toString()}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),


                        Slider(
                          value: _sliderValue,
                          min: 0.0,
                          max: 1289,//_assetsAudioPlayer.current.value.audio.duration!.inSeconds.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                              _isDraggingSlider = true;
                            });
                          },
                          onChangeEnd: (value) {
                            _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                            _isDraggingSlider = false;
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                _playAudio();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: () {
                                _assetsAudioPlayer.pause();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.stop),
                              onPressed: () {
                                _assetsAudioPlayer.stop();
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                ),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),


                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          'Na, mit gondolsz, jól ment? ',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE41B48),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(230, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(
                          'Nos, ennyi volt erre a hétre. Az elkövetkező két hétben az a házi feladatod, hogy hallgasd meg mindkét gyakorlatot, legalább naponta egyszer. Észre fogod venni, hogy minél többet gyakorolsz, annál jobb hatással lesz a hasadra. Vannak, akik azt veszik észre, hogy a hasuk egy kicsit jobban érzi magát a gyakorlatok után, mások pedig lényegesen jobban érzik magukat tőlük. Érdekes lesz megfigyelni, te hogyan fogod érezni magad. Jó szórakozást!',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE41B48),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: MediaQuery.of(context).size.width*0.025,),
                SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                TextButton(
                  onPressed: () {
                    navigateTo('https://www.bethesda.hu/');
                  },
                  child: Text(
                    'https://www.bethesda.hu/',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    navigateTo('https://www.bethesda.hu/');
                  },
                  child: Text(
                    'Tudjon meg többet a krónikus hasi fájdalomról!',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),


              ],
            ),

          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  void _playAudio() {
    if (isOpened == false){
      _assetsAudioPlayer.open(Audio("assets/sound/A_gondtalan_tengerpart_hangositott.mp3"));
      isOpened = true;
    }
    _assetsAudioPlayer.play();
  }

}

// Ez a függvény navigál a megadott URL-re a webes alkalmazásban
void navigateTo(String url) {
  // A window.location.href tulajdonság beállítása a megadott URL-re
  // megnyitja az új URL-t az aktuális ablakban
  // A replaceAll kiküszöböli az esetleges szóközöket a URL-ből
  // Mivel a navigateTo függvény Flutter weben fut, ezért szükséges használni a window objektumot
  // A window objektumot nem lehet használni a Flutter mobilalkalmazásokban
  // Ebben az esetben kizárólag a mobilalkalmazásokban használatos url_launcher csomagot kellene használni
  // de mivel ez a kód a Flutter web verziójára vonatkozik, ezért itt a window objektumot használjuk
  // A window objektum a Dart SDK webes környezetében ismert
  // Szükséges lehet a dart:js csomagot importálni, ha a VS Code figyelmeztetést ad
  //import 'dart:js';
  //context['window'].callMethod('open', [url]);
  context['window'].location.href = url.replaceAll(' ', '');
}