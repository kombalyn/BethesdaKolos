import 'dart:js';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/AudioPlayerPage.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipnomp3_1.dart';
import '../home_page_model.dart';
export '../home_page_model.dart';

import 'dart:js';
import '../constants/AudioPlayerPage.dart';

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
export '../home_page_model.dart';

import 'package:bethesda_2/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'ModuleHipno_page2.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'spec_5_6/spec_5_6_ModuleHipno.dart';
import 'spec_5_6/spec_5_6_ModuleHipno_page2.dart';

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

class ModuleHipno3 extends StatelessWidget {
  String Azonosito = '';
  ModuleHipno3(String s, {super.key}){Azonosito=s;}

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
  late HomePageModel _model;

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  String szam1 = "-1";
  String szam2 = "-1";
  String szam3 = "-1";

  Future<void> szamokBbeallitas()async {
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_4");
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
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_4"); //TODO ez majd mp3_2
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
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_4"); //TODO ez majd mp3_2
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




  late bool toggle = true;
  String Azonosito = '';
  _ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    szamokBbeallitas();

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
        appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.blueish, // Optional: Override the default background color
          iconColor: AppColors.blueish,),
        drawer: Drawer(
          child:  SidebarLayout(
            iconSuffix: '_l',  // Here you pass the suffix you want
            weekScreens: {
              '1-2.hét': {
                'screenBuilder': (context) => spec_5_6_ModuleHipno('Azonosito'),
                'isClickable': true,
              },
              '3-4.hét': {
                'screenBuilder': (context) => spec_5_6_ModuleHipno2('Azonosito'),
                'isClickable': true,
              },
              '5-6.hét': {
                'screenBuilder': (context) => ModuleHipno3('Azonosito'),
                'isClickable': true,
              },
              '7-8.hét': {
                'screenBuilder': (context) => ModuleHipno4('Azonosito'),
                'isClickable': false,
              },
              '9-12.hét': {
                'screenBuilder': (context) => ModuleHipno5('Azonosito'),
                'isClickable': false,
              },

            },
            selectedWeek: '5-6.hét', // Specify which week is selected
            weekTextStyles: {
              '5-6.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
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

      SingleChildScrollView(
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
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      // Indentation for the rows
                      child: Column(
                        children: [

                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.09),
                          Row(
                            children: [
                              Expanded(
                                // This will allow text to wrap within the row.
                                child: Text("Szia!",
                                    style:
                                    MyTextStyles.bethesdagomb_lila(context)),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text section
                              Text(
                                "Itt az ötödik hét, és itt az ideje egy újabb gyakorlatnak!\n \nA negyedik felvételnek Gondtalan Tengerpart a címe és abban segít majd, hogy kitisztítsd a fejedet, a gondolataidat. Vannak gyerekek, akiket nagyon sok minden nyugtalanít. Olyasmik, mint hogy az iskolában fogják-e bántani őket, hogy mi van a barátaikkal, hogyan sikerülnek a dolgozataik, és így tovább. Ettől lehet, hogy rosszabbul alszanak és még a hasuk is megfájdulhat tőle. \n \n Ez a gyakorlat abban segít, hogy elengedd ezeket az aggodalmakat és meg tudj nyugodni.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),

                              SizedBox(height: MediaQuery.of(context).size.width * 0.03),



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
                          Center(child:Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.6, // Set desired width for image
                            height: MediaQuery.of(context).size.width * 0.6 / 1.778, // Set height proportionally
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
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
                          ),



                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                                child:  AudioPlayerPage(url: "http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_mp3/A_gondtalan_tengerpart_hangositott.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_4",onUzenetKuldes: szamokBbeallitas,),

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
                                          szam1, // Your button text
                                          style:
                                          MyTextStyles.bluegomb(context),
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
                                  style: MyTextStyles.bethesdagomb_lila(context),
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

      SingleChildScrollView(
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
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      // Indentation for the rows
                      child: Column(
                        children: [

                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.05),
                          Row(
                            children: [
                              Expanded(
                                // This will allow text to wrap within the row.
                                child: Text("Szia!",
                                    style:
                                    MyTextStyles.bethesdagomb_lila(context)),
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
                                      "Itt az ötödik hét, és itt az ideje egy újabb gyakorlatnak!\n \nA negyedik felvételnek Gondtalan Tengerpart a címe és abban segít majd, hogy kitisztítsd a fejedet, a gondolataidat. Vannak gyerekek, akiket nagyon sok minden nyugtalanít. Olyasmik, mint hogy az iskolában fogják-e bántani őket, hogy mi van a barátaikkal, hogyan sikerülnek a dolgozataik, és így tovább. Ettől lehet, hogy rosszabbul alszanak és még a hasuk is megfájdulhat tőle. \n \n Ez a gyakorlat abban segít, hogy elengedd ezeket az aggodalmakat és meg tudj nyugodni.",
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
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                                child:  AudioPlayerPage(url: "http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_mp3/A_gondtalan_tengerpart_hangositott.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_4",onUzenetKuldes: szamokBbeallitas,),

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
                                          szam1, // Your button text
                                          style:
                                          MyTextStyles.bluegomb(context),
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
                                  style: MyTextStyles.bethesdagomb_lila(context),
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

      SingleChildScrollView(
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
                                    MyTextStyles.bethesdagomb_lila(context)),
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
                                      "Itt az ötödik hét, és itt az ideje egy újabb gyakorlatnak!\n \nA negyedik felvételnek Gondtalan Tengerpart a címe és abban segít majd, hogy kitisztítsd a fejedet, a gondolataidat. Vannak gyerekek, akiket nagyon sok minden nyugtalanít. Olyasmik, mint hogy az iskolában fogják-e bántani őket, hogy mi van a barátaikkal, hogyan sikerülnek a dolgozataik, és így tovább. Ettől lehet, hogy rosszabbul alszanak és még a hasuk is megfájdulhat tőle. \n \n Ez a gyakorlat abban segít, hogy elengedd ezeket az aggodalmakat és meg tudj nyugodni.",
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

                                child:  AudioPlayerPage(url: "http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_mp3/A_gondtalan_tengerpart_hangositott.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_4",onUzenetKuldes: szamokBbeallitas,),

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
                                          szam1, // Your button text
                                          style:
                                          MyTextStyles.bluegomb(context),
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
                                  style: MyTextStyles.bethesdagomb_lila(context),
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
        SidebarLayout(
          iconSuffix: '_l',  // Here you pass the suffix you want
          weekScreens: {
            '1-2.hét': {
              'screenBuilder': (context) => spec_5_6_ModuleHipno('Azonosito'),
              'isClickable': true,
            },
            '3-4.hét': {
              'screenBuilder': (context) => spec_5_6_ModuleHipno2('Azonosito'),
              'isClickable': true,
            },
            '5-6.hét': {
              'screenBuilder': (context) => ModuleHipno3('Azonosito'),
              'isClickable': true,
            },
            '7-8.hét': {
              'screenBuilder': (context) => ModuleHipno4('Azonosito'),
              'isClickable': false,
            },
            '9-12.hét': {
              'screenBuilder': (context) => ModuleHipno5('Azonosito'),
              'isClickable': false,
            },

          },
          selectedWeek: '5-6.hét', // Specify which week is selected
          weekTextStyles: {
            '5-6.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
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
