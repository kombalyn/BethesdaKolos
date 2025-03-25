import 'dart:js';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'hipno/ModuleHipnomp3_1.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}



class ModuleHipno4 extends StatelessWidget {
  const ModuleHipno4({super.key});

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
  late HomePageModel _model;

  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/kronikus_hasi_fajdalom.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();

     */
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
                            'Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?',
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
                          'A szüleid állandóan a hasfájásodról kérdezgetnek? Sok szülő teszi ezt. A nagypapák, nagymamák és a barátaid is kérdezhetik, hogy vagy. Vagy talán te magad is állandóan mondod a szüleidnek, hogy éppen mennyire fáj a hasad. Nagyon fontos, hogy te és a körülötted élő emberek ne beszéljenek/kérdezzenek többet a hasfájásodról. Elmagyarázzuk, hogy miért!',
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
                          'A szüleid mostanra már valószínűleg felismerték, hogy nem igazán tudnak neked segíteni, amikor fáj a hasad. Már egy ideje tartanak ezek a problémáid, és bármit is tesznek, legtöbbször semmi sem segít. Korábban talán bevettél egy tablettát, melegítetted a pocakodat vagy lefeküdtél a kanapéra, hogy megpróbáld jobban érezni magad. Ilyenkor ez egy kicsit segíthet, de a hasfájás folyamatosan visszatér. Az orvosok azonban tudják, hogy minél többet beszélsz a fájdalmadról és minél több figyelmet szentelsz neki, annál jobban fogsz szenvedni tőle. Ezért azt javasoljuk, hogy mától kezdve ne mondd a szüleidnek, ha fáj a hasad. És ha valaki megkérdezi, hogy van a pocakod, akkor mondd, hogy nem szeretnél erről többet beszélni.',
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
                         'Mostantól kezdve arra kérünk, hogy ha ismét elkezd fájni a hasad, akkor végezd a gyakorlatokat, pontosan úgy, ahogyan ebben a füzetben szerepelnek. Észre fogod venni, hogy ezek a gyakorlatok segítenek abban, hogy a pocakod ismét jobban érezze magát. Természetesen néha beszélhetsz azért a hasfájásról. Megállapodhatsz például a szüleiddel, hogy hetente egyszer vagy kétszer elmondod nekik, hogy hogyan alakulnak a panaszaid. Ha a szüleid a hasfájásodról máskor is kérdeznek, akkor egyszerűen csak mondd, hogy „Anya/Apa, erről nem szeretnék most beszélni". Vagy, hogy „Elmegyek most a gyakorlataimat végezni.”',
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

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tippek a gyakorlatok meghallgatásához:',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        //height: 327,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: SingleChildScrollView(

                          child: BulletList([
                            'Ne beszéljünk többé a hasfájásról',
                            'Egyszerűen csak végezd a gyakorlatokat',
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: MediaQuery.of(context).size.width*0.025,),


                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ModuleHipnomp3_1(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text('Go To Second Module'),
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