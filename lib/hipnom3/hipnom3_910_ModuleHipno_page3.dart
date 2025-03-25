import 'dart:js';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../constants/AudioPlayerPage.dart';
import '../home_page_model.dart';
export '../home_page_model.dart';

import 'dart:js';
import '../constants/AudioPlayerPage.dart';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

export '../home_page_model.dart';

import 'package:bethesda_2/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

export '../home_page_model.dart';
import '../appbar/appbar.dart';

import 'hipnom3_34_ModuleOpening_M3.dart';
import 'hipnom3_12_ModuleHipno.dart';
import 'hipnom3_56_ModuleHipno_page2.dart';
import 'hipnom3_78_ModuleM3_4het.dart';
import 'hipnom3_910_ModuleHipno_page3.dart';
import 'models/hipnom3_questions1.dart';
import 'providers/hipnom3_3_4_quiz_provider1.dart';
import 'providers/hipnom3_7_quiz_provider2.dart';
import 'providers/hipnom3_8_quiz_provider3.dart';
import 'providers/hipnom3_11_quiz_provider4.dart';
import 'providers/hipnom3_12_quiz_provider5.dart';
import 'screens/hipnom3_1_2_quiz_screen1.dart';
import 'screens/hipnom3_7_quiz_screen2.dart';
import 'screens/hipnom3_8_quiz_screen3.dart';
import 'screens/hipnom3_11_quiz_screen4.dart';
import 'screens/hipnom3_12_quiz_screen5.dart';
import 'screens/hipnom3_result_screen1.dart';
import 'screens/hipnom3_show_response.dart';

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

class hipnom3_ModuleHipno3 extends StatelessWidget {
  hipnom3_ModuleHipno3(String s, {super.key}){Azonosito=s;}
  String Azonosito = '';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hipnom3',
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenish),
        useMaterial3: false,
      ),
      home:  hipnom3_ModuleHipnoWidget(Azonosito),
    );
  }
}

class hipnom3_ModuleHipnoWidget extends StatefulWidget {
  hipnom3_ModuleHipnoWidget(String azonosito, {super.key}){Azonosito=azonosito;}
  String Azonosito = '';

  @override
  State<hipnom3_ModuleHipnoWidget> createState() => _hipnom3_ModuleHipnotState(Azonosito);
}

class _hipnom3_ModuleHipnotState extends State<hipnom3_ModuleHipnoWidget> {

  String szam1 = "-1";
  String szam2 = "-1";
  String szam3 = "-1";
  Future<void> szamokBbeallitas()async {
    print('TODO');
  }


  late HomePageModel _model;

  late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;
  String Azonosito = '';
  _hipnom3_ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

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
        appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.greenish, // Optional: Override the default background color
          iconColor: AppColors.greenish,),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: AppColors.lightshade,
                        // Use your desired background color
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.33,
                            right: MediaQuery.of(context).size.width * 0.05),
                        // Indentation for the rows
                        child: Column(
                          children: [

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Szia!",
                                      style:
                                          MyTextStyles.bethesdagomb_zold(context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  // Allocates 3 parts of the space to the text
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Itt az ideje egy újabb gyakorlatnak!\n \nA negyedik felvételnek Gondtalan Tengerpart a címe és abban segít majd, hogy kitisztítsd a fejedet, a gondolataidat. Vannak gyerekek, akiket nagyon sok minden nyugtalanít. Olyasmik, mint hogy az iskolában fogják-e bántani őket, hogy mi van a barátaikkal, hogyan sikerülnek a dolgozataik, és így tovább. Ettől lehet, hogy rosszabbul alszanak és még a hasuk is megfájdulhat tőle. \n \n Ez a gyakorlat abban segít, hogy elengedd ezeket az aggodalmakat és meg tudj nyugodni.",
                                        style: MyTextStyles.bekezdes(context),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                Expanded(
                                  flex: 2,
                                  // Allocates 2 parts of the space to the image
                                  child: Column(
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                      // Adjust the height to provide the desired spacing
                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.3, // Increase the width
                                        height: MediaQuery.of(context).size.width * 0.3 / 1.778, // Increase the height proportionally
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(17),
                                          // Slightly less than Container's borderRadius to fit inside the border
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/images/relax_illisztracio_3.jpeg',
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Most is azt fogjuk kérni tőled, hogy legalább naponta egyszer hallgasd meg a felvételt. Továbbá arra is kérünk, hogy az előző három gyakorlat egyikét is hallgasd meg minden nap. Nagyon sok gyerektől hallottuk, hogy ez a gyakorlat segít nekik nyugodtabbnak lenni és jobban is alszanak tőle éjszaka.\nMost pedig keress egy kényelmes helyet és hallgasd meg a Gondtalan Tengerpart c. felvételt. \n\nReméljük élvezni fogod!",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),

                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed

                                  child:  AudioPlayerPage(url: "http://pigssh.ddns.net:8080/assets/assets/A gondtalan tengerpart hangositott.mp3",azonosito: "XY123",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  // This ensures the text fits within the available space and wraps.
                                  child: Text(
                                    "Eddig ennyiszer hallgattad meg ezt a hanganyagot:",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Maintain the same border radius
                                  ),
                                  color: AppColors.whitewhite,
                                  // Background color of the card
                                  child: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      // Adjust padding to fit your design needs
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // Use the minimum space required by the children
                                        children: [
                                          Text(
                                            'Szám!', // Your button text
                                            style:
                                                MyTextStyles.greengomb(context),
                                          ),
                                          // Add more widgets if needed
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text(
                                    "Amikor nyugodt vagy fejben, akkor a tested is megnyugszik!",
                                    style: MyTextStyles.bethesdagomb_zold(context),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.15),

                            // You can add more rows as needed
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Front Layer with Clickable parts
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.3, // Sidebar width
                      color:
                          Colors.white.withOpacity(1), // Slightly transparent
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03,
                            left: MediaQuery.of(context).size.width * 0.04),
                        // Set the desired top and left padding
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          // Sidebar width
                          color: Colors.white.withOpacity(0.3),
                          // Fully opaque white
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fájdalomkezelési kisokos',
                                textAlign: TextAlign.left,
                                style:
                                    MyTextStyles.huszonkettobekezdes(context),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewhite,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/2icon_b.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    'Üdvözlő',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  onTap: () async {

                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Anyagok',
                                textAlign: TextAlign.left,
                                style: MyTextStyles.huszonegybekezdes(context),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewhite,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/5icon_b.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    '1-2. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    // Replace this text with what you want as a subtitle
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    print('Button pressed ...');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            hipnom3_ModuleHipno('Azonosito'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.whitewhite,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/4icon_b.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    '3-4. hét',
                                    style: MyTextStyles.vastagbekezdes(context),
                                  ),
                                  subtitle: Text(
                                    'Zárolva',
                                    // Replace this text with what you want as a subtitle
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    print('Button pressed ...');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            hipnom3_ModuleHipno2('Azonosito'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.lightshade,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.lightshade,
                                  // Use your specific color variable
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    // Adjust the radius as needed
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: ListTile(
                                  leading:
                                      Image.asset('assets/images/6icon_b.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    '5-6. hét',
                                    style: MyTextStyles.vastaggreenish(context),
                                  ),
                                  subtitle: Text(
                                    'Elérhető',
                                    // Replace this text with what you want as a subtitle
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    print('Button pressed ...');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            hipnom3_ModuleHipno3('Azonosito'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                color: AppColors.lightshade,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/3icon_b.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '7-8. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {

                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Image.asset('assets/images/7icon_b.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '9-12. hét',
                                  style: MyTextStyles.vastagbekezdes(context),
                                ),
                                subtitle: Text(
                                  'Zárolva',
                                  // Replace this text with what you want as a subtitle
                                  style: MyTextStyles.kicsibekezdes(context),
                                ),
                                onTap: () {

                                },
                              ),
                              Container(
                                color: AppColors.whitewhite,
                                // Set a different background color for the outer container
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    // Inner container color
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          20.0), // Rounded corner for inner container
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.029, // Adjust to match the text's top padding
                    left: 0, // Adjust to position next to the text
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.03, // Adjust the width as needed
                      height: MediaQuery.of(context).size.height * 0.05, // Adjust the height as needed
                      color: AppColors.greenish, // Adjust the color as needed
                    ),
                  ),
                ],
              ),
            ],
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
