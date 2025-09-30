import 'dart:js';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'ModuleHipnomp3_2.dart';
import '../home_page_model.dart';
export '../home_page_model.dart';




class ModuleHipnomp3_1 extends StatelessWidget {

  String Azonosito = '';
  ModuleHipnomp3_1(String s, {super.key}){Azonosito=s;}

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
      home:  ModuleHipnoWidget(Azonosito),
    );
  }
}


class ModuleHipnoWidget extends StatefulWidget {
  String Azonosito = '';
   ModuleHipnoWidget(String s,{super.key}){Azonosito=s;}

  @override
  State<ModuleHipnoWidget> createState() => _ModuleHipnotState(Azonosito);
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


  String Azonosito = '';
  _ModuleHipnotState(String s){Azonosito=s;}
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
                          'Az első gyakorlat: Relaxációs gyakorlat!',
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
                          'Hamarosan az első gyakorlatot fogod hallani. Ez egy relaxációs gyakorlat, amit már nagyon sok gyerek hallgatott. Ebben a gyakorlatban megtanulod, hogyan tudod a testedben lévő összes különböző izmot megfeszíteni, majd újra ellazítani. Ez egy nagyon jó gyakorlat, amit akkor végezhetsz, ha egy kicsit feszült vagy bizonytalan vagy. Észre fogod venni, hogy ez nagyon meg tud nyugtatni. A legjobb az, ha ma legalább kétszer elvégzed a gyakorlatot, utána pedig majd meglátod mi a jobb neked: ha naponta egyszer, vagy ha inkább kétszer végzed. Most hallgasd meg a gyakorlatot.',
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

                Image.asset("assets/images/gyakorlat1.jpg"),

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
                          'Tetszett? Ha valami nem világos, megkérheted a szüleidet, hogy segítsenek neked benne. ',
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

                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ModuleHipnomp3_2(Azonosito),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text('Kezdjük a következő gyakorlatot!'),
                      Icon(
                        Icons.play_arrow,
                        size: 15,
                      ),
                    ],
                  ),
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