import 'dart:js';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/AudioPlayerPage.dart';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

import 'dart:html' as html;
import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
export '../home_page_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bethesda_2/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'ModuleHipno_page2.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
import 'ModuleOpening.dart';

import 'ModuleHipno.dart';
export '../home_page_model.dart';
import '../appbar/appbar.dart';





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

class ModuleHipno2 extends StatelessWidget {
  ModuleHipno2(String s, {super.key}){Azonosito=s;}
  String Azonosito = '';

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
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueish),
        useMaterial3: false,
      ),
      home:  ModuleHipnoWidget(Azonosito),
    );
  }
}


class ModuleHipnoWidget extends StatefulWidget {
  ModuleHipnoWidget(String azonosito, {super.key}){Azonosito=azonosito;}
  String Azonosito = '';

  @override
  State<ModuleHipnoWidget> createState() => _ModuleHipnotState(Azonosito);
}

class _ModuleHipnotState extends State<ModuleHipnoWidget> {

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
  );

  String szam1 = "-1";
  String szam2 = "-1";
  String szam3 = "-1";

  Future<void> szamokBbeallitas()async {
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_3");
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam1 = cleanMessage;
        });

        print("vissz " + szam1);
      } catch (e) {
        print('Error: $e');
      }
    });

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_3"); //TODO ez majd mp3_2
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam2 = cleanMessage;
        });

        print("vissz " + szam1 + " ${Azonosito}");
      } catch (e) {
        print('Error: $e');
      }
    });

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_3"); //TODO ez majd mp3_2
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam3 = cleanMessage;
        });

        print("vissz " + szam3 + " ${Azonosito}");
      } catch (e) {
        print('Error: $e');
      }
    });

  }

  late HomePageModel _model;
  late VideoPlayerController _controller;
  late bool toggle = true;
  String Azonosito = '';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Uri _url;
  _ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    szamokBbeallitas();

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
        appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.blueish, // Optional: Override the default background color
          iconColor: AppColors.blueish,),
        drawer: Drawer(
          child:  SidebarLayout(
            iconSuffix: '_l',  // Here you pass the suffix you want
            weekScreens: {
              '1-2.hét': {
                'screenBuilder': (context) => ModuleHipno("$Azonosito"),
                'isClickable': true,
              },
              '3-4.hét': {
                'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
                'isClickable': true,
              },
              '5-6.hét': {
                'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
                'isClickable': true,
              },
              '7-8.hét': {
                'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
                'isClickable': true,
              },
              '9-12.hét': {
                'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
                'isClickable': true,
              },

            },
            selectedWeek: '3-4.hét', // Specify which week is selected
            weekTextStyles: {
              '3-4.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
              //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
              // Add other weeks as needed with their respective styles
            },
            rectangleColor: AppColors.blueish, // You can change this color to any other color
          ),
        ),
        body:

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return mobileLayout(context);
            } else if (constraints.maxWidth < 1200) {
              // Tablet layout
              return tabletLayout(context);
            } else {
              // Desktop layout (original preserved layout)
              return desktopLayout(context);
            }
          },
        ),
      ),
    );
  }

  Widget mobileLayout(BuildContext context) {
    // This is your original layout that will be used for desktop/laptop views
    return
      SingleChildScrollView( child:
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
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    // Indentation for the rows
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.09),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style: MyTextStyles.bethesdagomb_lila(context)),
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
                              width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                              child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_3",onUzenetKuldes: szamokBbeallitas,),

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
                                        szam1, // Your button text
                                        style: MyTextStyles.bluegomb(context),
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
                              color: AppColors.blueish, // Color of the border
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
                              color: AppColors.blueish, // Color of the border
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
                                style: MyTextStyles.bethesdagomb_lila(context),
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
                top: 0, // Position it at the top
                left: MediaQuery.of(context).size.width*0.02, // Align it to the left corner
                child: SafeArea(
                  child:
                  IconButton(
                    icon: Icon(Icons.menu, color: AppColors.blueish),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer(); // Open the drawer (sidebar)
                    },
                  ),
                ),

              ),
            ],
          ),
        ],
      ),
      );
  }

  Widget tabletLayout(BuildContext context) {
    // This is your original layout that will be used for desktop/laptop views
    return
      SingleChildScrollView( child:
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
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    // Indentation for the rows
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style: MyTextStyles.bethesdagomb_lila(context)),
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
                              width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                              child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_3",onUzenetKuldes: szamokBbeallitas,),

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
                                        szam1, // Your button text
                                        style: MyTextStyles.bluegomb(context),
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
                              color: AppColors.blueish, // Color of the border
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
                              color: AppColors.blueish, // Color of the border
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
                                style: MyTextStyles.bethesdagomb_lila(context),
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
                top: 0, // Position it at the top
                left: MediaQuery.of(context).size.width*0.05, // Align it to the left corner
                child: SafeArea(
                  child:
                  IconButton(
                    icon: Icon(Icons.menu, color: AppColors.blueish),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer(); // Open the drawer (sidebar)
                    },
                  ),
                ),

              ),
            ],
          ),
        ],
      ),
      );
  }

  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout(BuildContext context) {
    // This is your original layout that will be used for desktop/laptop views
    return
      SingleChildScrollView( child:
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
                                  style: MyTextStyles.bethesdagomb_lila(context)),
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

                              child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_3",onUzenetKuldes: szamokBbeallitas,),

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
                                        szam1, // Your button text
                                        style: MyTextStyles.bluegomb(context),
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
                              color: AppColors.blueish, // Color of the border
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
                              color: AppColors.blueish, // Color of the border
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
                                style: MyTextStyles.bethesdagomb_lila(context),
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
              SidebarLayout(
                iconSuffix: '_l',  // Here you pass the suffix you want
                weekScreens: {
                  '1-2.hét': {
                    'screenBuilder': (context) => ModuleHipno("$Azonosito"),
                    'isClickable': true,
                  },
                  '3-4.hét': {
                    'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
                    'isClickable': true,
                  },
                  '5-6.hét': {
                    'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
                    'isClickable': true,
                  },
                  '7-8.hét': {
                    'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
                    'isClickable': true,
                  },
                  '9-12.hét': {
                    'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
                    'isClickable': true,
                  },

                },
                selectedWeek: '3-4.hét', // Specify which week is selected
                weekTextStyles: {
                  '3-4.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
                  //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
                  // Add other weeks as needed with their respective styles
                },
                rectangleColor: AppColors.blueish, // You can change this color to any other color
              ),
            ],
          ),
        ],
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
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
                          labelStyle: MyTextStyles.kicsibekezdes2(context),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kérlek, töltsd ki a mezőt';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => colors[i] = value),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "${i + 1}. Érzés *",
                        labelStyle: MyTextStyles.kicsibekezdes2(context),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kérlek, töltsd ki a mezőt';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => feelings[i] = value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.01,),
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
                  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01, horizontal: MediaQuery.of(context).size.width*0.01,),
                ),
              ),
              child: Text(
                "Küldés!",
                style: MyTextStyles.bluegomb(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
