import 'dart:js';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../constants/AudioPlayerPage.dart';

import 'dart:html' as html;
export '../home_page_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bethesda_2/constants/styles.dart';

import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
export '../home_page_model.dart';
import '../appbar/appbar.dart';

import 'hipnom3_34_ModuleOpening_M3.dart';
import 'hipnom3_12_ModuleHipno.dart';
import 'hipnom3_56_ModuleHipno_page2.dart';
import 'hipnom3_910_ModuleHipno_page3.dart';




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

class hipnom3_ModuleHipno2 extends StatelessWidget {


  hipnom3_ModuleHipno2(String s, {super.key}){Azonosito=s;}
  String Azonosito = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hipnom3_',
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
      home: hipnom3_ModuleHipnoWidget(Azonosito),
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
  late double _currentPointOnFunction = 0;
  late double _sliderValue = 0.0;
  late bool toggle = true;
  String Azonosito = '';
  _hipnom3_ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Uri _url;

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    /*
    _controller = VideoPlayerController.asset('assets/videos/szia.mp4')
      ..initialize().then((_) {
        setState(() {});
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
    */
  }

  @override
  void dispose() {
    _controller.dispose();
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

        body: SingleChildScrollView( child:
        Column(
          children: [
            Stack(
              children: [
            // Background Layer
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
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style: MyTextStyles.bethesdagomb_zold(context)),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Start with the image (left side)
                            Expanded(
                              flex: 2, // Allocates 2 parts of the space to the image
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start (top-left in this case)
                                mainAxisSize: MainAxisSize.min, // Prevents Column from expanding to fill available space
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17), // Slightly smaller radius than the container to fit inside the border
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            child: Image.asset(
                                              'assets/images/relax_illusztráció_2.jpeg',
                                              fit: BoxFit.contain, // Ensure the image is fully visible without cropping
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.white.withOpacity(0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03), // Spacing between image and text

                            // Now the text (right side)
                            Expanded(
                              flex: 3, // Allocates 3 parts of the space to the text
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Itt az ideje egy új gyakorlatnak. \n \n Győződj meg arról, hogy jó helyet találtál az otthonodban a felvételek hallgatására. A mai új gyakorlatnak A Színek Bolygója a címe. Ez egy szórakoztató feladat, amellyel több önbizalmat és kellemes, egészséges érzéseket élhetsz át. Arra fogunk kérni, hogy képzelj el különböző színeket, amelyek olyan érzésekhez kapcsolódnak, amiket érezni szeretnél. A gyakorlat elvégzése után le is írhatod, hogy melyik szín melyik érzéshez tartozik. \n \n Most helyezd magadat kényelembe és hallgasd meg a harmadik gyakorlatot!",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),


                       /* Html(
                          data: """
          <audio controls>
            <source src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A gondtalan tengerpart.mp3" type="audio/mpeg">
            Your browser does not support the audio tag.
          </audio>
          """,
                        ), */


                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed

                              child:  AudioPlayerPage(url: "http://pigssh.ddns.net:8080/assets/assets/Progr_relax_nagyoknak.mp3",azonosito: "XY123",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

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
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
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
                                        'Szám', // Your button text
                                        style: MyTextStyles.greengomb(context),
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
                            height: MediaQuery.of(context).size.width * 0.03),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.greenish, // Color of the border
                              width: 3, // Width of the border
                            ),
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Melyik szín és melyik érzés tartozik össze számodra?",
                                      style: MyTextStyles.vastagbekezdes(context),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              InputForm(),
                              // Make sure InputForm is defined and correctly imported
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Sok gyereknek segít, ha készítenek valamit, amihez felhasználják a számukra fontos színeket. Csinálhatsz például egy karkötőt olyan színű gyöngyökből, amilyeneket választottál a gyakorlat során. Amikor szükséged van valamelyik érzésre elég ránézned a karkötődre vagy megérinteni azt. Rajzolhatsz is valami szépet a Színek Bolygójáról és kiteheted a szobádba. Itt van még néhány ötlet, hogy mi mindent készíthetsz a számodra fontos színekkel.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.greenish, // Color of the border
                              width: 4, // Thickness of the border
                            ),
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/3-4-karkoto.png',
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "A következő két hétben minden nap hallgasd meg a Színek Bolygóját. Ha szeretnéd, akkor ráadásként maghallgathatod az első gyakorlatot is (Relaxációs gyakorlat). Ez lesz a feladatod a harmadik és a negyedik hétre.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Jó szórakozást!",
                                style: MyTextStyles.bethesdagomb_zold(context),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),

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
                width: MediaQuery.of(context).size.width * 0.3, // Sidebar width
                color: Colors.white.withOpacity(1), // Slightly transparent
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.03,
                      left: MediaQuery.of(context).size.width * 0.04), // Set the desired top and left padding
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
                          style: MyTextStyles.huszonkettobekezdes(context),
                        ),
                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.03,
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
                            leading: Image.asset('assets/images/2icon_b.png'),
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
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            leading: Image.asset('assets/images/5icon_b.png'),
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

                            },
                          ),
                        ),
                        Container(
                          color: AppColors.whitewhite,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            leading: Image.asset('assets/images/4icon_b.png'),
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

                            },
                          ),
                        ),

                        Container(
                          color: AppColors.lightshade,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                          ),                          child: ListTile(
                            leading: Image.asset('assets/images/6icon_b.png'),
                            title: Text(
                              '5-6. hét',
                              style: MyTextStyles.vastaggreenish(context),
                            ),
                            subtitle: Text(
                              'Elérhető',
                              style: MyTextStyles.kicsibekezdes(context),
                            ),
                            onTap: () {
                              print('Button pressed ...');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => hipnom3_ModuleHipno2('Azonosito'),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: AppColors.lightshade,
                          // Set a different background color for the outer container
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            height: MediaQuery.of(context).size.width * 0.02,
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
                            height: MediaQuery.of(context).size.width * 0.02,
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

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> colors = ['', '', '', ''];
  List<String> feelings = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 4; i++) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "${i + 1}. Szín *",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => colors[i] = value),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "${i + 1}. Érzés *",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => feelings[i] = value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process data
                  print("Színek: $colors");
                  print("Érzések: $feelings");
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.whitewhite,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
              ),
              child: Text(
                "Küldés!",
                style: MyTextStyles.greengomb(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
