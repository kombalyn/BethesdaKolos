import 'dart:convert';
import 'dart:js';
import 'dart:typed_data';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct
import 'spec_7_8_ModuleHipno.dart';
import 'spec_7_8_ModuleHipno_page2.dart';
import 'spec_7_8_ModuleHipno_page3.dart';

import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../constants/AudioPlayerPage.dart';
import '../ModuleHipno_page2.dart';
import '../ModuleHipno_page5.dart';
import '../ModuleHipno_page4.dart';
import '../ModuleHipno_page3.dart';
import '../ModuleHipnomp3_1.dart';
import '../ModuleOpening.dart';

import '../ModuleHipno.dart';
export '../../home_page_model.dart';
import '../../appbar/appbar.dart';

class spec_7_8_ModuleHipno extends StatelessWidget {
  String Azonosito = '';

  spec_7_8_ModuleHipno(String s, {super.key}) {
    Azonosito = s;
  }

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
      home: spec_7_8_ModuleHipnoWidget(Azonosito),
    );
  }
}

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

class spec_7_8_ModuleHipnoWidget extends StatefulWidget {
  spec_7_8_ModuleHipnoWidget(String azonosito, {super.key}) {
    Azonosito = azonosito;
  }
  String Azonosito = '';

  @override
  State<spec_7_8_ModuleHipnoWidget> createState() => _spec_7_8_ModuleHipnotState(Azonosito);
}

class _spec_7_8_ModuleHipnotState extends State<spec_7_8_ModuleHipnoWidget> {

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  Future<String> szam_lekerdezes() async{
    String vissz = "-1";
    print("uzenet elkuldve");
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_1") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        vissz = cleanMessage;
        print("vissz " + vissz);
      } catch (e) {
        print('Error: $e');
      }
    });
    return vissz;
  }

  late Duration _currentPosition;
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool _isDraggingSlider = false;
  bool isOpened = false;

  late HomePageModel _model;
  bool is0TextVisible = false; // To control the visibility of the text section
  bool is1TextVisible = false; // To control the visibility of the text section
  bool is2TextVisible = false; // To control the visibility of the text section
  bool is3TextVisible = false; // To control the visibility of the text section
  bool is4TextVisible = false; // To control the visibility of the text section
  bool is5TextVisible = false; // To control the visibility of the text section
  bool is6TextVisible = false; // To control the visibility of the text section
  bool is7TextVisible = false; // To control the visibility of the text section
  bool is0Checked = false; // Controls the state of the checkbox
  bool is1Checked = false; // Controls the state of the checkbox
  bool is2Checked = false; // Controls the state of the checkbox
  bool is3Checked = false; // Controls the state of the checkbox
  bool is4Checked = false; // Controls the state of the checkbox
  bool is5Checked = false; // Controls the state of the checkbox
  bool is6Checked = false; // Controls the state of the checkbox
  bool is7Checked = false; // Controls the state of the checkbox

  late bool toggle = true;
  final ScrollController _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _spec_7_8_ModuleHipnotState(String azonosito) {
    Azonosito = azonosito;
  }

  final Uri _url = Uri.parse('https://www.bethesda.hu/');
  //AudioPlayer _audioPlayer = AudioPlayer();

  String szam1 = "-1";
  String szam2 = "-1";

  Future<void> szamokBbeallitas()async {

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );
    print("channel_azonosito $Azonosito");
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_1") ;
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
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_2") ; //TODO ez majd mp3_2
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

    //szam1 = await szam_lekerdezes();
    //szam2 = await szam_lekerdezes();
  }

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    print("Azonosito: " + Azonosito);
    szamokBbeallitas();

    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.currentPosition.listen((duration) {
      //_currentPosition = 0;
      setState(() {
        if (!_isDraggingSlider) {
          _currentPosition = duration;
          //     _sliderValue = _currentPosition.inSeconds.toDouble();
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
      onTap: () => FocusScope.of(context).unfocus(),
      // To dismiss the keyboard when tapping outside of inputs

      child: Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          title: 'Kutatási fázis',
          backgroundColor: AppColors
              .blueish, // Optional: Override the default background color
          iconColor: AppColors.blueish,
        ),
        drawer: Drawer(
          child: SidebarLayout(
            iconSuffix: '_l',  // Here you pass the suffix you want
            weekScreens: {
              '1-2.hét': {
                'screenBuilder': (context) => spec_7_8_ModuleHipno('Azonosito'),
                'isClickable': true,
              },
              '3-4.hét': {
                'screenBuilder': (context) => spec_7_8_ModuleHipno2('Azonosito'),
                'isClickable': true,
              },
              '5-6.hét': {
                'screenBuilder': (context) => spec_7_8_ModuleHipno3('Azonosito'),
                'isClickable': true,
              },
              '7-8.hét': {
                'screenBuilder': (context) => ModuleHipno4('Azonosito'),
                'isClickable': true,
              },
              '9-12.hét': {
                'screenBuilder': (context) => ModuleHipno5('Azonosito'),
                'isClickable': false,
              },
            },
            selectedWeek: '1-2.hét', // Specify which week is selected
            weekTextStyles: {
              '1-2.hét':
                  MyTextStyles.vastagblueish(context), // Style for '1.hét'
              //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
              // Add other weeks as needed with their respective styles
            },
            rectangleColor: AppColors
                .blueish, // You can change this color to any other color
          ),
        ),
        body: LayoutBuilder(
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
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
                            height: MediaQuery.of(context).size.width * 0.08),
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
                            height: MediaQuery.of(context).size.width * 0.03),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: MJ_szia.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_szia.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text(
                                  "Ezen az oldalon találod az elolvasandó rövid anyagokat valamint a gyakorlataidat. Kérünk, olvasd el ezeket figyelmesen.",
                                  style: MyTextStyles.bekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Néhány rövid olvasnivaló:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        // ÚJ BETOLDÁSA
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is0TextVisible =
                                          !is0TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is0TextVisible
                                            ? 'Mi az a krónikus hasi fájdalom?'
                                            : '1. Lecke - Mi az a krónikus hasi fájdalom?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is0Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is0Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is0TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        // VIDEÓ
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is0Checked = true;
                                                is0TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE AZ ÚJNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),

                        //KEZDŐDIK AZ ELSŐ
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is1TextVisible =
                                          !is1TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is1TextVisible
                                            ? 'Mi az a hipnózis?'
                                            : '2. Lecke - Mi az a hipnózis?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is1Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is1Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is1TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mi_az_a_hipnózis.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mi_az_a_hipn%C3%B3zis.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              // Higher flex value for more space
                                              child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                      "Valóban ilyesmi a ",
                                                      style:
                                                      MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: 'színpadi hipnózis',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                        ', de ennek semmi köze sincs az ',
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                    TextSpan(
                                                        text:
                                                        "orvosi hipnózishoz.",
                                                        style: MyTextStyles
                                                            .vastagbekezdes(
                                                            context)),
                                                    TextSpan(
                                                        text:
                                                        " Az orvosi hipnózis sokkal inkább az álmodozáshoz hasonlít, álmodozni pedig a legtöbb gyerek szeret és elég jól is tud. Képzeld el, hogy épp az osztályteremben ülsz és valami érdekes dologra gondolsz. Mondjuk a kedvenc hobbidra, például a focira. A képzeletedben éppen focizol, látod a többi játékost, talán néhány barátodat is, odapasszolják neked a labdát, te pedig lőni készülsz…és akkor… A tanár hirtelen felszólít téged. Valószínűleg meglepődsz, mert fogalmad sincs, miről is beszélt a tanár mostanáig. Álmodoztál és ezért egészen másra figyeltél, máshol jártál a képzeletedben.",
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            // Space between the text and image
                                            Expanded(
                                              flex: 1,
                                              // Lower flex value for less space
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(7),
                                                  // Make sure this matches the container's border radius
                                                  child: Image.asset(
                                                    'assets/images/hipnózis_illusztráció.jpeg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az orvosi hipnózis valójában pont ilyen. Gyakorlatokat fogsz hallgatni és közben a gondolataidra figyelsz. Talán még azt is elfelejted majd, hogy a saját szobádban vagy. Ezeket a gyakorlatokat néha képzelet-gyakorlatoknak is nevezzük, mert ilyenkor képeket alkotsz a saját fejedben. Ezek szép és barátságos képek. Egy ilyen kép megmutathat téged egy különleges tengerparton vagy éppen megnézheted, hogy hogyan is néz ki a saját pocakod. Az önhipnózis során semmi olyan nem történhet, amit te nem szeretnél. A hipnózis során teljes mértékben te irányítod az eseményeket.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "A hipnózis:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Álmodozás \n• Szép dolgokról \n• Amit te irányítasz",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is1Checked = true;
                                                is1TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // VEGE AZ ELSŐNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A MÁSODIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is2TextVisible =
                                          !is2TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is2TextVisible
                                            ? 'A hipnózis hatása a hasfájásra:'
                                            : '3. Lecke - A hipnózis hatása a hasfájásra',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is2Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is2Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is2TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Bebizonyítottuk, hogy hipnózissal befolyásolható a hasfájás. Két vizsgálatban több mint 300, hozzád hasonlóan hasi problémákkal küzdő gyereknél figyeltük meg, hogy ezek a gyakorlatok sokat segítenek abban, hogy a pocakjuk jobban érezze magát. Fontos, hogy ezeket a gyakorlatokat mindennap hallgasd meg, hogy a módszer tényleg működhessen. Minél többet gyakorolsz, annál jobban működik. Olyan ez, mint amikor úszni vagy focizni tanulsz: minél többet gyakorolsz, annál ügyesebb leszel. Ebben a videóban Doktor Major János elmagyarázza, miért segít olyan sokat a hipnózis a hasfájás enyhítésében.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mint már tudod, öt hipnózis gyakorlatot rögzítettünk neked. Arra kérünk, hogy naponta legalább egyszer hallgasd meg ezeket a gyakorlatokat, de akár többször is meghallgathatod őket. Fontos, hogy senki ne zavarjon meg téged közben. Ezért az a legjobb, ha a gyakorlatokat a saját szobádban hallgatod. Mindenképpen szólj a többieknek, akik otthon vannak veled, hogy éppen gyakorlatot végzel, nehogy véletlenül besétáljanak a szobádba. A legtöbb gyereknek az működik a legjobban, ha minden nap ugyanabban az időpontban végzi a gyakorlatokat. Például közvetlenül mielőtt lefekszik aludni, vagy amikor hazaért az iskolából. Meg fogod tapasztalni, hogy neked mi válik be a legjobban. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A honlap segítségével nyomon követheted, hogy hányszor hallgattad a gyakorlatokat. Ez segít abban, hogy egészségesebbé és erősebbé válj. Naponta emlékeztetni fogod magadat arra, hogy te vagy a tested ura, és a gyakorlatokat minden egyes gyakorlással egyre ismerősebbnek és természetesebbnek fogod találni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Készen állsz? Akkor kezdjünk hozzá!",
                                                style: MyTextStyles
                                                    .bethesdagomb_lila(context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Tippek a gyakorlatok meghallgatásához:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Gyakorolj minden nap \n• Csendes helyen \n• Azonos időben",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is2Checked = true;
                                                is2TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A MÁSODIKNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A HARMADIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is3TextVisible =
                                          !is3TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is3TextVisible
                                            ? 'Mi okozza a hasfájást?'
                                            : '4. Lecke - Mi okozza a hasfájást?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is3Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is3Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is3TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Lehet, hogy az orvosod már beszélt erről veled. Ismételjünk át néhány dolgot annak érdekében, hogy te is és a szüleid is igazán jól megértsétek ezeket! Az irritábilis bélrendszerrel vagy krónikus hasi fájdalommal küzdő gyermekeknél a belek túlérzékennyé váltak. Mit is jelent ez?\nMindannyian tudjuk, hogy ha például megégetjük a kezünket, akkor hirtelen erős fájdalmat érzünk. Ez a fájdalom egy riasztás, ami jelzi, hogy valami nincs rendben a szervezetünkkel. Ha nem éreznénk a fájdalmat, nem lenne okunk arra, hogy elhúzzuk a kezünket a tűztől. A fájdalom tehát egy fontos figyelmeztető jelzés. Azonban a hasadban ez a riasztórendszer túlérzékennyé vált. Olyan ez, mint egy házban a riasztó: akkor kellene bekapcsolnia, amikor betörő van a házban, de ez a rendszer olyan érzékeny, hogy például egy házon átrepülő kis rovar is beindítja. Valami hasonló történik a hasadban is. Fájdalmat érezhetsz, ha például ettél egy megromlott szendvicset, de akkor is érzel fájdalmat, ha egy egészséges és friss szendvicset eszel, vagy akkor is, ha egyáltalán nem is eszel semmit. Bármikor és bárhol fájhat a hasad. Tudjuk, hogy valójában nincsen semmi komoly baja a hasadnak. A pocakod egyszerűen túl érzékennyé vált.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Nézd meg ezt a videót a túlérzékeny bélműködésről.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4" ></video>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is3Checked = true;
                                                is3TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // EDDIG A HARMADIK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK A NEGYEDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is4TextVisible =
                                          !is4TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is4TextVisible
                                            ? 'Az ördögi kör'
                                            : '6. Lecke - Az ördögi kör',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is4Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is4Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is4TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Amikor fájdalmat érzel, akkor olyan gondolataid lehetnek, mint: 'Remélem, hogy nem lesz rosszabb, mert iskolába akarok menni.' vagy 'El akarok menni arra a meccsre. Valószínűleg így nem fogok tudni.'. \nAmikor így gondolkodsz, az izmaid megfeszülnek, bár lehet, hogy észre sem veszed.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ettől aggódhatsz és szomorú lehetsz, a szíved elkezdhet gyorsabban verni, és mindezek miatt a fájdalmat még rosszabbnak érezheted. Lehet, hogy másképp is kezdesz lélegezni: a nyugodt, laza és mély hasi légzés helyett talán szaporán kapkodod a levegőt.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mindezek miatt olyan érzésed lehet, hogy egy negatív körben jársz körbe-körbe, amit mi 'ördögi körnek' hívunk. Úgy érezheted, hogy tehetetlen vagy. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Így néz ki ez az ördögi kör:",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            // First column for text
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                  'assets/images/ordogikor.png',
                                                ),
                                              ),
                                            ),
                                            // Second column for image
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors.blueish,
                                                      // Your desired color of the border
                                                      width:
                                                      2, // The thickness of the border
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    // Optional: if you want rounded corners
                                                    color: AppColors
                                                        .whitewhite, // Set the background color for the surrounding area
                                                  ),
                                                  child: Text(
                                                    "Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. \nOlyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.",
                                                    style:
                                                    MyTextStyles.bekezdes(
                                                        context),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is4Checked = true;
                                                is4TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A NEGYEDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK AZ ÖTÖDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is5TextVisible =
                                          !is5TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is5TextVisible
                                            ? 'Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?'
                                            : '7. Lecke - Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is5Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is5Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is5TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid állandóan a hasfájásodról kérdezgetnek? Sok szülő teszi ezt. A nagypapák, nagymamák és a barátaid is kérdezhetik, hogy vagy. Vagy talán te magad is állandóan mondod a szüleidnek, hogy éppen mennyire fáj a hasad. Nagyon fontos, hogy te és a körülötted élő emberek ne beszéljenek/kérdezzenek többet a hasfájásodról. Elmagyarázzuk, hogy miért!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid mostanra már valószínűleg felismerték, hogy nem igazán tudnak neked segíteni, amikor fáj a hasad. Már egy ideje tartanak ezek a problémáid, és bármit is tesznek, legtöbbször semmi sem segít. Korábban talán bevettél egy tablettát, melegítetted a pocakodat vagy lefeküdtél a kanapéra, hogy megpróbáld jobban érezni magad. Ilyenkor ez egy kicsit segíthet, de a hasfájás folyamatosan visszatér. Az orvosok azonban tudják, hogy minél többet beszélsz a fájdalmadról és minél több figyelmet szentelsz neki, annál jobban fogsz szenvedni tőle. Ezért azt javasoljuk, hogy mától kezdve ne mondd a szüleidnek, ha fáj a hasad. És ha valaki megkérdezi, hogy van a pocakod, akkor mondd, hogy nem szeretnél erről többet beszélni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mostantól kezdve arra kérünk, hogy ha ismét elkezd fájni a hasad, akkor végezd a gyakorlatokat, pontosan úgy, ahogyan ebben a füzetben szerepelnek. Észre fogod venni, hogy ezek a gyakorlatok segítenek abban, hogy a pocakod ismét jobban érezze magát.\nTermészetesen néha beszélhetsz azért a hasfájásról. Megállapodhatsz például a szüleiddel, hogy hetente egyszer vagy kétszer elmondod nekik, hogy hogyan alakulnak a panaszaid. Ha a szüleid a hasfájásodról máskor is kérdeznek, akkor egyszerűen csak mondd, hogy 'Anya/Apa, erről nem szeretnék most beszélni'. Vagy, hogy 'Elmegyek most a gyakorlataimat végezni.' ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.02),
                                        // You can add more rows as needed
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Megállapodás:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Ne beszéljünk többé a hasfájásról \n• Egyszerűen csak végezd a gyakorlatokat",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is5Checked = true;
                                                is5TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ÖTÖDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: Hipno_beve_1_PK.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/Hipno_beve_1_PK.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Itt találod a gyakorlataid:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        //ELSŐ GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is6TextVisible =
                                          !is6TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is6TextVisible
                                            ? 'Relaxációs Gyakorlat'
                                            : '1. Gyakorlat - Relaxációs Gyakorlat',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam1,
                                    style:
                                    MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is6TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Hamarosan az első gyakorlatot fogod hallani. Ez egy relaxációs gyakorlat, amit már nagyon sok gyerek hallgatott. Ebben a gyakorlatban megtanulod, hogyan tudod a testedben lévő összes különböző izmot megfeszíteni, majd újra ellazítani. Ez egy nagyon jó gyakorlat, amit akkor végezhetsz, ha egy kicsit feszült vagy bizonytalan vagy. Észre fogod venni, hogy ez nagyon meg tud nyugtatni. A legjobb az, ha ma legalább kétszer elvégzed a gyakorlatot, utána pedig majd meglátod mi a jobb neked: ha naponta egyszer, vagy ha inkább kétszer végzed. Most hallgasd meg a gyakorlatot.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        /*Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.play('http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3'),
                                                    child: Text('Play'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.pause(),
                                                    child: Text('Pause'),
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.9, // Adjust the width as needed

                                              child: AudioPlayerPage(
                                                  url:
                                                  "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tetszett? Ha valami nem világos, megkérheted a szüleidet, hogy segítsenek neked benne. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ELSŐ GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // MÁSODIK GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is7TextVisible =
                                          !is7TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is7TextVisible
                                            ? 'Biztonságos Hely'
                                            : '2. Gyakorlat - Biztonságos Hely',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam2,
                                    style:
                                    MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is7TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A következő gyakorlatnak Biztonságos Hely a címe. Ebben a gyakorlatban egy újfajta légzést tanulhatsz meg. Ráadásul azt is megmutatjuk, hogyan tudod a kezeidet a hasadra helyezve átmelegíteni a pocakodat, hogy az még jobban érezze magát. Ezt követően arra kérü nk majd, hogy alkoss egy képet a saját biztonsá gos helyedről. Sok gyerek szereti ezt a gyakorlatot, mert nyugodtnak és magabiztosnak érzi magát tő le.\nHallgasd meg a gyakorlatot!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.9, // Adjust the width as needed
                                              child: AudioPlayerPage(
                                                  url:
                                                  "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_2",onUzenetKuldes: szamokBbeallitas,),

                                              // HtmlWidget(
                                              //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                              //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                              // ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Na mit gondolsz, jól ment?",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE A MÁSODIK GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          "Nos, ennyi volt erre a hétre. Az elkövetkező két hétben az a házi feladatod, hogy hallgasd meg mindkét gyakorlatot, legalább naponta egyszer. Észre fogod venni, hogy minél többet gyakorolsz, annál jobb hatással lesz a hasadra. Vannak, akik azt veszik észre, hogy a hasuk egy kicsit jobban érzi magát a gyakorlatok után, mások pedig lényegesen jobban érzik magukat tőlük. Érdekes lesz megfigyelni, te hogyan fogod érezni magad.",
                          style: MyTextStyles.bekezdes(context),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
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
                            height: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
              // itt volt scroll

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
          //ide kell záró
        ],
      ),
    );
  }

  Widget tabletLayout(BuildContext context) {
    // This is your original layout that will be used for desktop/laptop views
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
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
                                  style:
                                      MyTextStyles.bethesdagomb_lila(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: MJ_szia.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_szia.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text(
                                  "Ezen az oldalon találod az elolvasandó rövid anyagokat valamint a gyakorlataidat. Kérünk, olvasd el ezeket figyelmesen.",
                                  style: MyTextStyles.bekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Néhány rövid olvasnivaló:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        // ÚJ BETOLDÁSA
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is0TextVisible =
                                          !is0TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is0TextVisible
                                            ? 'Mi az a krónikus hasi fájdalom?'
                                            : '1. Lecke - Mi az a krónikus hasi fájdalom?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is0Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is0Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is0TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        // VIDEÓ
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is0Checked = true;
                                                is0TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE AZ ÚJNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK AZ ELSŐ
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is1TextVisible =
                                          !is1TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is1TextVisible
                                            ? 'Mi az a hipnózis?'
                                            : '2. Lecke - Mi az a hipnózis?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is1Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is1Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is1TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mi_az_a_hipnózis.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mi_az_a_hipn%C3%B3zis.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              // Higher flex value for more space
                                              child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                      "Valóban ilyesmi a ",
                                                      style:
                                                      MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: 'színpadi hipnózis',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                        ', de ennek semmi köze sincs az ',
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                    TextSpan(
                                                        text:
                                                        "orvosi hipnózishoz.",
                                                        style: MyTextStyles
                                                            .vastagbekezdes(
                                                            context)),
                                                    TextSpan(
                                                        text:
                                                        " Az orvosi hipnózis sokkal inkább az álmodozáshoz hasonlít, álmodozni pedig a legtöbb gyerek szeret és elég jól is tud. Képzeld el, hogy épp az osztályteremben ülsz és valami érdekes dologra gondolsz. Mondjuk a kedvenc hobbidra, például a focira. A képzeletedben éppen focizol, látod a többi játékost, talán néhány barátodat is, odapasszolják neked a labdát, te pedig lőni készülsz…és akkor… A tanár hirtelen felszólít téged. Valószínűleg meglepődsz, mert fogalmad sincs, miről is beszélt a tanár mostanáig. Álmodoztál és ezért egészen másra figyeltél, máshol jártál a képzeletedben.",
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            // Space between the text and image
                                            Expanded(
                                              flex: 1,
                                              // Lower flex value for less space
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(7),
                                                  // Make sure this matches the container's border radius
                                                  child: Image.asset(
                                                    'assets/images/hipnózis_illusztráció.jpeg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az orvosi hipnózis valójában pont ilyen. Gyakorlatokat fogsz hallgatni és közben a gondolataidra figyelsz. Talán még azt is elfelejted majd, hogy a saját szobádban vagy. Ezeket a gyakorlatokat néha képzelet-gyakorlatoknak is nevezzük, mert ilyenkor képeket alkotsz a saját fejedben. Ezek szép és barátságos képek. Egy ilyen kép megmutathat téged egy különleges tengerparton vagy éppen megnézheted, hogy hogyan is néz ki a saját pocakod. Az önhipnózis során semmi olyan nem történhet, amit te nem szeretnél. A hipnózis során teljes mértékben te irányítod az eseményeket.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "A hipnózis:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Álmodozás \n• Szép dolgokról \n• Amit te irányítasz",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is1Checked = true;
                                                is1TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // VEGE AZ ELSŐNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A MÁSODIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is2TextVisible =
                                          !is2TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is2TextVisible
                                            ? 'A hipnózis hatása a hasfájásra:'
                                            : '3. Lecke - A hipnózis hatása a hasfájásra',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is2Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is2Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is2TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Bebizonyítottuk, hogy hipnózissal befolyásolható a hasfájás. Két vizsgálatban több mint 300, hozzád hasonlóan hasi problémákkal küzdő gyereknél figyeltük meg, hogy ezek a gyakorlatok sokat segítenek abban, hogy a pocakjuk jobban érezze magát. Fontos, hogy ezeket a gyakorlatokat mindennap hallgasd meg, hogy a módszer tényleg működhessen. Minél többet gyakorolsz, annál jobban működik. Olyan ez, mint amikor úszni vagy focizni tanulsz: minél többet gyakorolsz, annál ügyesebb leszel. Ebben a videóban Doktor Major János elmagyarázza, miért segít olyan sokat a hipnózis a hasfájás enyhítésében.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mint már tudod, öt hipnózis gyakorlatot rögzítettünk neked. Arra kérünk, hogy naponta legalább egyszer hallgasd meg ezeket a gyakorlatokat, de akár többször is meghallgathatod őket. Fontos, hogy senki ne zavarjon meg téged közben. Ezért az a legjobb, ha a gyakorlatokat a saját szobádban hallgatod. Mindenképpen szólj a többieknek, akik otthon vannak veled, hogy éppen gyakorlatot végzel, nehogy véletlenül besétáljanak a szobádba. A legtöbb gyereknek az működik a legjobban, ha minden nap ugyanabban az időpontban végzi a gyakorlatokat. Például közvetlenül mielőtt lefekszik aludni, vagy amikor hazaért az iskolából. Meg fogod tapasztalni, hogy neked mi válik be a legjobban. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A honlap segítségével nyomon követheted, hogy hányszor hallgattad a gyakorlatokat. Ez segít abban, hogy egészségesebbé és erősebbé válj. Naponta emlékeztetni fogod magadat arra, hogy te vagy a tested ura, és a gyakorlatokat minden egyes gyakorlással egyre ismerősebbnek és természetesebbnek fogod találni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Készen állsz? Akkor kezdjünk hozzá!",
                                                style: MyTextStyles
                                                    .bethesdagomb_lila(context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Tippek a gyakorlatok meghallgatásához:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Gyakorolj minden nap \n• Csendes helyen \n• Azonos időben",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is2Checked = true;
                                                is2TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A MÁSODIKNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A HARMADIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is3TextVisible =
                                          !is3TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is3TextVisible
                                            ? 'Mi okozza a hasfájást?'
                                            : '4. Lecke - Mi okozza a hasfájást?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is3Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is3Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is3TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Lehet, hogy az orvosod már beszélt erről veled. Ismételjünk át néhány dolgot annak érdekében, hogy te is és a szüleid is igazán jól megértsétek ezeket! Az irritábilis bélrendszerrel vagy krónikus hasi fájdalommal küzdő gyermekeknél a belek túlérzékennyé váltak. Mit is jelent ez?\nMindannyian tudjuk, hogy ha például megégetjük a kezünket, akkor hirtelen erős fájdalmat érzünk. Ez a fájdalom egy riasztás, ami jelzi, hogy valami nincs rendben a szervezetünkkel. Ha nem éreznénk a fájdalmat, nem lenne okunk arra, hogy elhúzzuk a kezünket a tűztől. A fájdalom tehát egy fontos figyelmeztető jelzés. Azonban a hasadban ez a riasztórendszer túlérzékennyé vált. Olyan ez, mint egy házban a riasztó: akkor kellene bekapcsolnia, amikor betörő van a házban, de ez a rendszer olyan érzékeny, hogy például egy házon átrepülő kis rovar is beindítja. Valami hasonló történik a hasadban is. Fájdalmat érezhetsz, ha például ettél egy megromlott szendvicset, de akkor is érzel fájdalmat, ha egy egészséges és friss szendvicset eszel, vagy akkor is, ha egyáltalán nem is eszel semmit. Bármikor és bárhol fájhat a hasad. Tudjuk, hogy valójában nincsen semmi komoly baja a hasadnak. A pocakod egyszerűen túl érzékennyé vált.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Nézd meg ezt a videót a túlérzékeny bélműködésről.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4" ></video>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is3Checked = true;
                                                is3TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // EDDIG A HARMADIK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK A NEGYEDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is4TextVisible =
                                              !is4TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is4TextVisible
                                            ? 'Az ördögi kör'
                                            : '5. Lecke - Az ördögi kör',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is4Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is4Checked =
                                            value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is4TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Amikor fájdalmat érzel, akkor olyan gondolataid lehetnek, mint: 'Remélem, hogy nem lesz rosszabb, mert iskolába akarok menni.' vagy 'El akarok menni arra a meccsre. Valószínűleg így nem fogok tudni.'. \nAmikor így gondolkodsz, az izmaid megfeszülnek, bár lehet, hogy észre sem veszed.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ettől aggódhatsz és szomorú lehetsz, a szíved elkezdhet gyorsabban verni, és mindezek miatt a fájdalmat még rosszabbnak érezheted. Lehet, hogy másképp is kezdesz lélegezni: a nyugodt, laza és mély hasi légzés helyett talán szaporán kapkodod a levegőt.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mindezek miatt olyan érzésed lehet, hogy egy negatív körben jársz körbe-körbe, amit mi 'ördögi körnek' hívunk. Úgy érezheted, hogy tehetetlen vagy. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Így néz ki ez az ördögi kör:",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            // First column for text
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                  'assets/images/ordogikor.png',
                                                ),
                                              ),
                                            ),
                                            // Second column for image
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors.blueish,
                                                      // Your desired color of the border
                                                      width:
                                                          2, // The thickness of the border
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    // Optional: if you want rounded corners
                                                    color: AppColors
                                                        .whitewhite, // Set the background color for the surrounding area
                                                  ),
                                                  child: Text(
                                                    "Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. \nOlyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.",
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is4Checked = true;
                                                is4TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A NEGYEDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK AZ ÖTÖDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is5TextVisible =
                                              !is5TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is5TextVisible
                                            ? 'Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?'
                                            : '6. Lecke - Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is5Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is5Checked =
                                            value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is5TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid állandóan a hasfájásodról kérdezgetnek? Sok szülő teszi ezt. A nagypapák, nagymamák és a barátaid is kérdezhetik, hogy vagy. Vagy talán te magad is állandóan mondod a szüleidnek, hogy éppen mennyire fáj a hasad. Nagyon fontos, hogy te és a körülötted élő emberek ne beszéljenek/kérdezzenek többet a hasfájásodról. Elmagyarázzuk, hogy miért!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid mostanra már valószínűleg felismerték, hogy nem igazán tudnak neked segíteni, amikor fáj a hasad. Már egy ideje tartanak ezek a problémáid, és bármit is tesznek, legtöbbször semmi sem segít. Korábban talán bevettél egy tablettát, melegítetted a pocakodat vagy lefeküdtél a kanapéra, hogy megpróbáld jobban érezni magad. Ilyenkor ez egy kicsit segíthet, de a hasfájás folyamatosan visszatér. Az orvosok azonban tudják, hogy minél többet beszélsz a fájdalmadról és minél több figyelmet szentelsz neki, annál jobban fogsz szenvedni tőle. Ezért azt javasoljuk, hogy mától kezdve ne mondd a szüleidnek, ha fáj a hasad. És ha valaki megkérdezi, hogy van a pocakod, akkor mondd, hogy nem szeretnél erről többet beszélni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mostantól kezdve arra kérünk, hogy ha ismét elkezd fájni a hasad, akkor végezd a gyakorlatokat, pontosan úgy, ahogyan ebben a füzetben szerepelnek. Észre fogod venni, hogy ezek a gyakorlatok segítenek abban, hogy a pocakod ismét jobban érezze magát.\nTermészetesen néha beszélhetsz azért a hasfájásról. Megállapodhatsz például a szüleiddel, hogy hetente egyszer vagy kétszer elmondod nekik, hogy hogyan alakulnak a panaszaid. Ha a szüleid a hasfájásodról máskor is kérdeznek, akkor egyszerűen csak mondd, hogy 'Anya/Apa, erről nem szeretnék most beszélni'. Vagy, hogy 'Elmegyek most a gyakorlataimat végezni.' ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        // You can add more rows as needed
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Megállapodás:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                          context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Ne beszéljünk többé a hasfájásról \n• Egyszerűen csak végezd a gyakorlatokat",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                                context),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is5Checked = true;
                                                is5TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ÖTÖDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: Hipno_beve_1_PK.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/Hipno_beve_1_PK.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Itt találod a gyakorlataid:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        //ELSŐ GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is6TextVisible =
                                              !is6TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is6TextVisible
                                            ? 'Relaxációs Gyakorlat'
                                            : '1. Gyakorlat - Relaxációs Gyakorlat',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam1,
                                    style:
                                        MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is6TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Hamarosan az első gyakorlatot fogod hallani. Ez egy relaxációs gyakorlat, amit már nagyon sok gyerek hallgatott. Ebben a gyakorlatban megtanulod, hogyan tudod a testedben lévő összes különböző izmot megfeszíteni, majd újra ellazítani. Ez egy nagyon jó gyakorlat, amit akkor végezhetsz, ha egy kicsit feszült vagy bizonytalan vagy. Észre fogod venni, hogy ez nagyon meg tud nyugtatni. A legjobb az, ha ma legalább kétszer elvégzed a gyakorlatot, utána pedig majd meglátod mi a jobb neked: ha naponta egyszer, vagy ha inkább kétszer végzed. Most hallgasd meg a gyakorlatot.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        /*Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.play('http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3'),
                                                    child: Text('Play'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.pause(),
                                                    child: Text('Pause'),
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9, // Adjust the width as needed

                                              child: AudioPlayerPage(
                                                  url:
                                                      "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tetszett? Ha valami nem világos, megkérheted a szüleidet, hogy segítsenek neked benne. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ELSŐ GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // MÁSODIK GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is7TextVisible =
                                              !is7TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is7TextVisible
                                            ? 'Biztonságos Hely'
                                            : '2. Gyakorlat - Biztonságos Hely',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam2,
                                    style:
                                        MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is7TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A következő gyakorlatnak Biztonságos Hely a címe. Ebben a gyakorlatban egy újfajta légzést tanulhatsz meg. Ráadásul azt is megmutatjuk, hogyan tudod a kezeidet a hasadra helyezve átmelegíteni a pocakodat, hogy az még jobban érezze magát. Ezt követően arra kérü nk majd, hogy alkoss egy képet a saját biztonsá gos helyedről. Sok gyerek szereti ezt a gyakorlatot, mert nyugodtnak és magabiztosnak érzi magát tő le.\nHallgasd meg a gyakorlatot!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9, // Adjust the width as needed
                                              child: AudioPlayerPage(
                                                  url:
                                                      "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_2",onUzenetKuldes: szamokBbeallitas,),

                                              // HtmlWidget(
                                              //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                              //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                              // ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Na mit gondolsz, jól ment?",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE A MÁSODIK GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          "Nos, ennyi volt erre a hétre. Az elkövetkező két hétben az a házi feladatod, hogy hallgasd meg mindkét gyakorlatot, legalább naponta egyszer. Észre fogod venni, hogy minél többet gyakorolsz, annál jobb hatással lesz a hasadra. Vannak, akik azt veszik észre, hogy a hasuk egy kicsit jobban érzi magát a gyakorlatok után, mások pedig lényegesen jobban érzik magukat tőlük. Érdekes lesz megfigyelni, te hogyan fogod érezni magad.",
                          style: MyTextStyles.bekezdes(context),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
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
                            height: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
              // itt volt scroll

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
          //ide kell záró
        ],
      ),
    );
  }

  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout(BuildContext context) {
    // This is your original layout that will be used for desktop/laptop views
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
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
                                  style:
                                      MyTextStyles.bethesdagomb_lila(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: MJ_szia.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_szia.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text(
                                  "Ezen az oldalon találod az elolvasandó rövid anyagokat valamint a gyakorlataidat. Kérünk, olvasd el ezeket figyelmesen.",
                                  style: MyTextStyles.bekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Néhány rövid olvasnivaló:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

                        // ÚJ BETOLDÁSA
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is0TextVisible =
                                          !is0TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is0TextVisible
                                            ? 'Mi az a krónikus hasi fájdalom?'
                                            : '1. Lecke - Mi az a krónikus hasi fájdalom?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is0Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is0Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is0TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                 // VIDEÓ
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mit_jelent_a_kronikus_hasi_fajdalom.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is0Checked = true;
                                                is0TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE AZ ÚJNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK AZ ELSŐ
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is1TextVisible =
                                          !is1TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is1TextVisible
                                            ? 'Mi az a hipnózis?'
                                            : '2. Lecke - Mi az a hipnózis?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is1Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is1Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is1TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_mi_az_a_hipnózis.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_mi_az_a_hipn%C3%B3zis.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              // Higher flex value for more space
                                              child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                      "Valóban ilyesmi a ",
                                                      style:
                                                      MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: 'színpadi hipnózis',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                        ', de ennek semmi köze sincs az ',
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                    TextSpan(
                                                        text:
                                                        "orvosi hipnózishoz.",
                                                        style: MyTextStyles
                                                            .vastagbekezdes(
                                                            context)),
                                                    TextSpan(
                                                        text:
                                                        " Az orvosi hipnózis sokkal inkább az álmodozáshoz hasonlít, álmodozni pedig a legtöbb gyerek szeret és elég jól is tud. Képzeld el, hogy épp az osztályteremben ülsz és valami érdekes dologra gondolsz. Mondjuk a kedvenc hobbidra, például a focira. A képzeletedben éppen focizol, látod a többi játékost, talán néhány barátodat is, odapasszolják neked a labdát, te pedig lőni készülsz…és akkor… A tanár hirtelen felszólít téged. Valószínűleg meglepődsz, mert fogalmad sincs, miről is beszélt a tanár mostanáig. Álmodoztál és ezért egészen másra figyeltél, máshol jártál a képzeletedben.",
                                                        style: MyTextStyles
                                                            .bekezdes(context)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            // Space between the text and image
                                            Expanded(
                                              flex: 1,
                                              // Lower flex value for less space
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(7),
                                                  // Make sure this matches the container's border radius
                                                  child: Image.asset(
                                                    'assets/images/hipnózis_illusztráció.jpeg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az orvosi hipnózis valójában pont ilyen. Gyakorlatokat fogsz hallgatni és közben a gondolataidra figyelsz. Talán még azt is elfelejted majd, hogy a saját szobádban vagy. Ezeket a gyakorlatokat néha képzelet-gyakorlatoknak is nevezzük, mert ilyenkor képeket alkotsz a saját fejedben. Ezek szép és barátságos képek. Egy ilyen kép megmutathat téged egy különleges tengerparton vagy éppen megnézheted, hogy hogyan is néz ki a saját pocakod. Az önhipnózis során semmi olyan nem történhet, amit te nem szeretnél. A hipnózis során teljes mértékben te irányítod az eseményeket.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "A hipnózis:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Álmodozás \n• Szép dolgokról \n• Amit te irányítasz",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is1Checked = true;
                                                is1TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // VEGE AZ ELSŐNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A MÁSODIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is2TextVisible =
                                          !is2TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is2TextVisible
                                            ? 'A hipnózis hatása a hasfájásra:'
                                            : '3. Lecke - A hipnózis hatása a hasfájásra',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is2Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is2Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is2TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Bebizonyítottuk, hogy hipnózissal befolyásolható a hasfájás. Két vizsgálatban több mint 300, hozzád hasonlóan hasi problémákkal küzdő gyereknél figyeltük meg, hogy ezek a gyakorlatok sokat segítenek abban, hogy a pocakjuk jobban érezze magát. Fontos, hogy ezeket a gyakorlatokat mindennap hallgasd meg, hogy a módszer tényleg működhessen. Minél többet gyakorolsz, annál jobban működik. Olyan ez, mint amikor úszni vagy focizni tanulsz: minél többet gyakorolsz, annál ügyesebb leszel. Ebben a videóban Doktor Major János elmagyarázza, miért segít olyan sokat a hipnózis a hasfájás enyhítésében.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/MJ_miert_jo_a_hipnozis_a_hasi_fajdalomra.mp4" ></video>',
                                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mint már tudod, öt hipnózis gyakorlatot rögzítettünk neked. Arra kérünk, hogy naponta legalább egyszer hallgasd meg ezeket a gyakorlatokat, de akár többször is meghallgathatod őket. Fontos, hogy senki ne zavarjon meg téged közben. Ezért az a legjobb, ha a gyakorlatokat a saját szobádban hallgatod. Mindenképpen szólj a többieknek, akik otthon vannak veled, hogy éppen gyakorlatot végzel, nehogy véletlenül besétáljanak a szobádba. A legtöbb gyereknek az működik a legjobban, ha minden nap ugyanabban az időpontban végzi a gyakorlatokat. Például közvetlenül mielőtt lefekszik aludni, vagy amikor hazaért az iskolából. Meg fogod tapasztalni, hogy neked mi válik be a legjobban. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A honlap segítségével nyomon követheted, hogy hányszor hallgattad a gyakorlatokat. Ez segít abban, hogy egészségesebbé és erősebbé válj. Naponta emlékeztetni fogod magadat arra, hogy te vagy a tested ura, és a gyakorlatokat minden egyes gyakorlással egyre ismerősebbnek és természetesebbnek fogod találni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Készen állsz? Akkor kezdjünk hozzá!",
                                                style: MyTextStyles
                                                    .bethesdagomb_lila(context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Tippek a gyakorlatok meghallgatásához:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                      context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Gyakorolj minden nap \n• Csendes helyen \n• Azonos időben",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                            context),
                                                        textAlign:
                                                        TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is2Checked = true;
                                                is2TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A MÁSODIKNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // KEZDŐDIK A HARMADIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is3TextVisible =
                                          !is3TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is3TextVisible
                                            ? 'Mi okozza a hasfájást?'
                                            : '4. Lecke - Mi okozza a hasfájást?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is3Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is3Checked =
                                        value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith<
                                        Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is3TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                        AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Lehet, hogy az orvosod már beszélt erről veled. Ismételjünk át néhány dolgot annak érdekében, hogy te is és a szüleid is igazán jól megértsétek ezeket! Az irritábilis bélrendszerrel vagy krónikus hasi fájdalommal küzdő gyermekeknél a belek túlérzékennyé váltak. Mit is jelent ez?\nMindannyian tudjuk, hogy ha például megégetjük a kezünket, akkor hirtelen erős fájdalmat érzünk. Ez a fájdalom egy riasztás, ami jelzi, hogy valami nincs rendben a szervezetünkkel. Ha nem éreznénk a fájdalmat, nem lenne okunk arra, hogy elhúzzuk a kezünket a tűztől. A fájdalom tehát egy fontos figyelmeztető jelzés. Azonban a hasadban ez a riasztórendszer túlérzékennyé vált. Olyan ez, mint egy házban a riasztó: akkor kellene bekapcsolnia, amikor betörő van a házban, de ez a rendszer olyan érzékeny, hogy például egy házon átrepülő kis rovar is beindítja. Valami hasonló történik a hasadban is. Fájdalmat érezhetsz, ha például ettél egy megromlott szendvicset, de akkor is érzel fájdalmat, ha egy egészséges és friss szendvicset eszel, vagy akkor is, ha egyáltalán nem is eszel semmit. Bármikor és bárhol fájhat a hasad. Tudjuk, hogy valójában nincsen semmi komoly baja a hasadnak. A pocakod egyszerűen túl érzékennyé vált.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Nézd meg ezt a videót a túlérzékeny bélműködésről.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43,
                                            // Adjust the width as needed
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.43 *
                                                (9 / 16),
                                            // Maintain a 16:9 aspect ratio
                                            //ádám: MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4
                                            child: HtmlWidget(
                                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_hogyan_alakul_ki_a_tulerzekeny_belmukodes.mp4" ></video>',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is3Checked = true;
                                                is3TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // EDDIG A HARMADIK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK A NEGYEDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is4TextVisible =
                                              !is4TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is4TextVisible
                                            ? 'Az ördögi kör'
                                            : '4. Lecke - Az ördögi kör',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is4Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is4Checked =
                                            value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is4TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Amikor fájdalmat érzel, akkor olyan gondolataid lehetnek, mint: 'Remélem, hogy nem lesz rosszabb, mert iskolába akarok menni.' vagy 'El akarok menni arra a meccsre. Valószínűleg így nem fogok tudni.'. \nAmikor így gondolkodsz, az izmaid megfeszülnek, bár lehet, hogy észre sem veszed.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ettől aggódhatsz és szomorú lehetsz, a szíved elkezdhet gyorsabban verni, és mindezek miatt a fájdalmat még rosszabbnak érezheted. Lehet, hogy másképp is kezdesz lélegezni: a nyugodt, laza és mély hasi légzés helyett talán szaporán kapkodod a levegőt.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mindezek miatt olyan érzésed lehet, hogy egy negatív körben jársz körbe-körbe, amit mi 'ördögi körnek' hívunk. Úgy érezheted, hogy tehetetlen vagy. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Így néz ki ez az ördögi kör:",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            // First column for text
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                  'assets/images/ordogikor.png',
                                                ),
                                              ),
                                            ),
                                            // Second column for image
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors.blueish,
                                                      // Your desired color of the border
                                                      width:
                                                          2, // The thickness of the border
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    // Optional: if you want rounded corners
                                                    color: AppColors
                                                        .whitewhite, // Set the background color for the surrounding area
                                                  ),
                                                  child: Text(
                                                    "Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. \nOlyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.",
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is4Checked = true;
                                                is4TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // VÉGE A NEGYEDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        //KEZDŐDIK AZ ÖTÖDIK
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is5TextVisible =
                                              !is5TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is5TextVisible
                                            ? 'Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?'
                                            : '5. Lecke - Folyton arról kérdezgetnek a szüleid, hogy fáj-e a hasad?',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    value: is5Checked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        is5Checked =
                                            value!; // Toggle the state of the checkbox
                                      });
                                    },
                                    activeColor: AppColors.blueish,
                                    // Color when the checkbox is checked
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .grey; // Color when the checkbox is disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueish; // Color when the checkbox is selected
                                      }
                                      return AppColors
                                          .whitewhite; // Default color for the unchecked checkbox
                                    }), // Color of the check mark
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is5TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid állandóan a hasfájásodról kérdezgetnek? Sok szülő teszi ezt. A nagypapák, nagymamák és a barátaid is kérdezhetik, hogy vagy. Vagy talán te magad is állandóan mondod a szüleidnek, hogy éppen mennyire fáj a hasad. Nagyon fontos, hogy te és a körülötted élő emberek ne beszéljenek/kérdezzenek többet a hasfájásodról. Elmagyarázzuk, hogy miért!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A szüleid mostanra már valószínűleg felismerték, hogy nem igazán tudnak neked segíteni, amikor fáj a hasad. Már egy ideje tartanak ezek a problémáid, és bármit is tesznek, legtöbbször semmi sem segít. Korábban talán bevettél egy tablettát, melegítetted a pocakodat vagy lefeküdtél a kanapéra, hogy megpróbáld jobban érezni magad. Ilyenkor ez egy kicsit segíthet, de a hasfájás folyamatosan visszatér. Az orvosok azonban tudják, hogy minél többet beszélsz a fájdalmadról és minél több figyelmet szentelsz neki, annál jobban fogsz szenvedni tőle. Ezért azt javasoljuk, hogy mától kezdve ne mondd a szüleidnek, ha fáj a hasad. És ha valaki megkérdezi, hogy van a pocakod, akkor mondd, hogy nem szeretnél erről többet beszélni.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Mostantól kezdve arra kérünk, hogy ha ismét elkezd fájni a hasad, akkor végezd a gyakorlatokat, pontosan úgy, ahogyan ebben a füzetben szerepelnek. Észre fogod venni, hogy ezek a gyakorlatok segítenek abban, hogy a pocakod ismét jobban érezze magát.\nTermészetesen néha beszélhetsz azért a hasfájásról. Megállapodhatsz például a szüleiddel, hogy hetente egyszer vagy kétszer elmondod nekik, hogy hogyan alakulnak a panaszaid. Ha a szüleid a hasfájásodról máskor is kérdeznek, akkor egyszerűen csak mondd, hogy 'Anya/Apa, erről nem szeretnék most beszélni'. Vagy, hogy 'Elmegyek most a gyakorlataimat végezni.' ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        // You can add more rows as needed
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: AppColors.blueish,
                                            border: Border.all(
                                                color: AppColors.whitewhite,
                                                width: 4),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              // This will justify the text according to textAlign
                                              children: [
                                                Text(
                                                  "Megállapodás:",
                                                  style: MyTextStyles
                                                      .feherkicsikovercim(
                                                          context),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "\n• Ne beszéljünk többé a hasfájásról \n• Egyszerűen csak végezd a gyakorlatokat",
                                                        style: MyTextStyles
                                                            .feherkicsikovercim(
                                                                context),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                // Additional widgets here if needed
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                is5Checked = true;
                                                is5TextVisible = false;
                                              });
                                              _scrollController.animateTo(
                                                0.0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeOut,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                AppColors.whitewhite,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 24),
                                              ),
                                            ),
                                            child: Text(
                                              "Kész!",
                                              style: MyTextStyles.bluegomb(
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ÖTÖDIKNEK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.43,
                            // Adjust the width as needed
                            height: MediaQuery.of(context)
                                .size
                                .width *
                                0.43 *
                                (9 / 16),
                            // Maintain a 16:9 aspect ratio
                            //ádám: Hipno_beve_1_PK.mp4
                            child: HtmlWidget(
                              '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/Hipno_beve_1_PK.mp4" ></video>',
                              // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Itt találod a gyakorlataid:",
                                  style: MyTextStyles.vastagbekezdes(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        //ELSŐ GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is6TextVisible =
                                              !is6TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is6TextVisible
                                            ? 'Relaxációs Gyakorlat'
                                            : '1. Gyakorlat - Relaxációs Gyakorlat',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam1,
                                    style:
                                        MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is6TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Hamarosan az első gyakorlatot fogod hallani. Ez egy relaxációs gyakorlat, amit már nagyon sok gyerek hallgatott. Ebben a gyakorlatban megtanulod, hogyan tudod a testedben lévő összes különböző izmot megfeszíteni, majd újra ellazítani. Ez egy nagyon jó gyakorlat, amit akkor végezhetsz, ha egy kicsit feszült vagy bizonytalan vagy. Észre fogod venni, hogy ez nagyon meg tud nyugtatni. A legjobb az, ha ma legalább kétszer elvégzed a gyakorlatot, utána pedig majd meglátod mi a jobb neked: ha naponta egyszer, vagy ha inkább kétszer végzed. Most hallgasd meg a gyakorlatot.",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        /*Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.play('http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3'),
                                                    child: Text('Play'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => _audioPlayer.pause(),
                                                    child: Text('Pause'),
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.43, // Adjust the width as needed

                                              child: AudioPlayerPage(
                                                  url:
                                                      "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tetszett? Ha valami nem világos, megkérheted a szüleidet, hogy segítsenek neked benne. ",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //VÉGE AZ ELSŐ GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        // MÁSODIK GYAKORLAT
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.blueish,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is7TextVisible =
                                              !is7TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        is7TextVisible
                                            ? 'Biztonságos Hely'
                                            : '2. Gyakorlat - Biztonságos Hely',
                                        style: MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Eddig ennyiszer hallgattad meg: ",
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  Text(
                                    szam2,
                                    style:
                                        MyTextStyles.kicsibluebekezdes(context),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is7TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color:
                                            AppColors.blueish.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A következő gyakorlatnak Biztonságos Hely a címe. Ebben a gyakorlatban egy újfajta légzést tanulhatsz meg. Ráadásul azt is megmutatjuk, hogyan tudod a kezeidet a hasadra helyezve átmelegíteni a pocakodat, hogy az még jobban érezze magát. Ezt követően arra kérü nk majd, hogy alkoss egy képet a saját biztonsá gos helyedről. Sok gyerek szereti ezt a gyakorlatot, mert nyugodtnak és magabiztosnak érzi magát tő le.\nHallgasd meg a gyakorlatot!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        // You can add more rows as needed
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Adjust the corner radius
                                            ),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.43, // Adjust the width as needed
                                              child: AudioPlayerPage(
                                                  url:
                                                      "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",
                                                  azonosito: "$Azonosito",
                                                  hangfajlszam: "mp3_2",onUzenetKuldes: szamokBbeallitas,),

                                              // HtmlWidget(
                                              //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                              //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                              // ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Na mit gondolsz, jól ment?",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //VÉGE A MÁSODIK GYAKORLATNAK
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          "Nos, ennyi volt erre a hétre. Az elkövetkező két hétben az a házi feladatod, hogy hallgasd meg mindkét gyakorlatot, legalább naponta egyszer. Észre fogod venni, hogy minél többet gyakorolsz, annál jobb hatással lesz a hasadra. Vannak, akik azt veszik észre, hogy a hasuk egy kicsit jobban érzi magát a gyakorlatok után, mások pedig lényegesen jobban érzik magukat tőlük. Érdekes lesz megfigyelni, te hogyan fogod érezni magad.",
                          style: MyTextStyles.bekezdes(context),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04),
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
                            height: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
              // itt volt scroll

              // Front Layer with Clickable parts
      SidebarLayout(
        iconSuffix: '_l',  // Here you pass the suffix you want
        weekScreens: {
          '1-2.hét': {
            'screenBuilder': (context) => spec_7_8_ModuleHipno('Azonosito'),
            'isClickable': true,
          },
          '3-4.hét': {
            'screenBuilder': (context) => spec_7_8_ModuleHipno2('Azonosito'),
            'isClickable': true,
          },
          '5-6.hét': {
            'screenBuilder': (context) => spec_7_8_ModuleHipno3('Azonosito'),
            'isClickable': true,
          },
          '7-8.hét': {
            'screenBuilder': (context) => ModuleHipno4('Azonosito'),
            'isClickable': true,
          },
          '9-12.hét': {
            'screenBuilder': (context) => ModuleHipno5('Azonosito'),
            'isClickable': false,
          },
        },
        selectedWeek: '1-2.hét', // Specify which week is selected
        weekTextStyles: {
          '1-2.hét':
          MyTextStyles.vastagblueish(context), // Style for '1.hét'
          //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
          // Add other weeks as needed with their respective styles
        },
        rectangleColor: AppColors
            .blueish, // You can change this color to any other color
      ),
            ],
          ),
          //ide kell záró
        ],
      ),
    );
  }
}



//nem működik ha kiszedem a kommentet
/*


  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
*/
