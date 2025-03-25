import 'dart:js';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/AudioPlayerPage.dart';
import 'hipnom3_34_ModuleOpening_M3.dart';
import 'hipnom3_12_ModuleHipno.dart';
import 'hipnom3_56_ModuleHipno_page2.dart';
import 'hipnom3_910_ModuleHipno_page3.dart';

export '../home_page_model.dart';
import '../appbar/appbar.dart';

class hipnom3_ModuleHipno extends StatelessWidget {
  hipnom3_ModuleHipno(String s, {super.key}){Azonosito=s;}
  String Azonosito = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HipnoM3',
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
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
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
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
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
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
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

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  int szam_lekerdezes(){
    int vissz = -1;
    print("uzenet elkuldve");
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
    );

    _channel.sink.add("szamlekerdezes|XY978,mp3_1") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');
      vissz = int.parse("$message");
    });
    return vissz;
  }

  late Duration _currentPosition;
  late AssetsAudioPlayer _assetsAudioPlayer;
  double _sliderValue = 0.0; // A csúszka értéke
  bool _isDraggingSlider = false;
  bool isOpened = false;
  String Azonosito = '';
  _hipnom3_ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  bool _play = false;

  void _playAudio() {
    print("play");
    if (isOpened == false){
      _assetsAudioPlayer.open(Audio("http://pigssh.ddns.net:8080/assets/assets/A_gondtalan_tengerpart_hangositott.mp3"));
      isOpened = true;
    }
    _assetsAudioPlayer.play();
  }




  late HomePageModel _model;
  bool is1TextVisible = false; // To control the visibility of the text section
  bool is2TextVisible = false; // To control the visibility of the text section
  bool is3TextVisible = false; // To control the visibility of the text section
  bool is4TextVisible = false; // To control the visibility of the text section
  bool is5TextVisible = false; // To control the visibility of the text section
  bool is6TextVisible = false; // To control the visibility of the text section
  bool is7TextVisible = false; // To control the visibility of the text section

  bool is1Checked = false; // Controls the state of the checkbox
  bool is2Checked = false; // Controls the state of the checkbox
  bool is3Checked = false; // Controls the state of the checkbox
  bool is4Checked = false; // Controls the state of the checkbox
  bool is5Checked = false; // Controls the state of the checkbox
  bool is6Checked = false; // Controls the state of the checkbox
  bool is7Checked = false; // Controls the state of the checkbox

  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  //late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;
  final ScrollController _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://www.bethesda.hu/');
  //AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.currentPosition.listen((duration) {
      //_currentPosition = 0;
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
      onTap: () => FocusScope.of(context).unfocus(),
      // To dismiss the keyboard when tapping outside of inputs

      child: Scaffold(
        key: scaffoldKey,
        appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.greenish, // Optional: Override the default background color
          iconColor: AppColors.greenish,),

        body: SingleChildScrollView(
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
                                    MediaQuery.of(context).size.width * 0.03),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Néhány rövid olvasnivaló:",
                                      style:
                                          MyTextStyles.vastagbekezdes(context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
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
                                        color: AppColors.greenish,
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
                                                : '1. Lecke - Mi az a hipnózis?',
                                            style:
                                                MyTextStyles.bekezdes(context),
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
                                        activeColor: AppColors.greenish,
                                        // Color when the checkbox is checked
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Colors
                                                .grey; // Color when the checkbox is disabled
                                          }
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors
                                                .greenish; // Color when the checkbox is selected
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    "Sokszor, amikor hipnózisról beszélünk, a gyerekek és a felnőttek is egy olyan embert képzelnek maguk elé, akinek ijesztő tekintetétől valamiféle önkívületi állapotba kerülünk vagy elalszunk. Azt hiszik, ennek az állapotnak a hatására nem fogunk emlékezni semmire. Sok gyerek még arról is meg van győződve, hogy ez az ijesztő, hipnotizáló ember átveheti a testük felett az irányítást és olyan dolgok megtételére kényszerítheti őket, amit nem is akarnak. Más gyermekek Ká-ra, a kígyóra gondolnak (A dzsungel könyvéből), aki a szemét használja, hogy a fiúcska, Maugli, valamiféle önkívületi állapotba essen és azután mozdulni se tudjon.",
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                          style: MyTextStyles
                                                              .bekezdes(
                                                                  context),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              'színpadi hipnózis',
                                                          style: MyTextStyles
                                                              .vastagbekezdes(
                                                                  context),
                                                        ),
                                                        TextSpan(
                                                            text:
                                                                ', de ennek semmi köze sincs az ',
                                                            style: MyTextStyles
                                                                .bekezdes(
                                                                    context)),
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
                                                                .bekezdes(
                                                                    context)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                          BorderRadius.circular(
                                                              7),
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                color: AppColors.greenish,
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
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  // This will justify the text according to textAlign
                                                  children: [
                                                    Text(
                                                      "A hipnózis:",
                                                      style: MyTextStyles
                                                          .feherkicsikovercim(
                                                              context),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
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
                                                            textAlign: TextAlign
                                                                .justify,
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
                                                      duration: Duration(milliseconds: 300),
                                                      curve: Curves.easeOut,
                                                    );
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
                                                    "Kész!",
                                                    style: MyTextStyles.greengomb(context),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
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
                                        color: AppColors.greenish,
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
                                                : '2. Lecke - A hipnózis hatása a hasfájásra',
                                            style:
                                                MyTextStyles.bekezdes(context),
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
                                        activeColor: AppColors.greenish,
                                        // Color when the checkbox is checked
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Colors
                                                .grey; // Color when the checkbox is disabled
                                          }
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors
                                                .greenish; // Color when the checkbox is selected
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                child: HtmlWidget(
                                                  '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://pigssh.ddns.net:8080/assets/assets/mi%C3%A9rt%20j%C3%B3%20a%20hipn%C3%B3zis%20hasi%20f%C3%A1jdalomra.mp4" ></video>',
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                        .bethesdagomb_zold(context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                color: AppColors.greenish,
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
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  // This will justify the text according to textAlign
                                                  children: [
                                                    Text(
                                                      "Tippek a gyakorlatok meghallgatásához:",
                                                      style: MyTextStyles
                                                          .feherkicsikovercim(
                                                              context),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
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
                                                            textAlign: TextAlign
                                                                .justify,
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
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeOut,
                                                  );
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
                                                  "Kész!",
                                                  style: MyTextStyles.greengomb(context),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
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
                                        color: AppColors.greenish,
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
                                                : '3. Lecke - Mi okozza a hasfájást?',
                                            style:
                                                MyTextStyles.bekezdes(context),
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
                                        activeColor: AppColors.greenish,
                                        // Color when the checkbox is checked
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Colors
                                                .grey; // Color when the checkbox is disabled
                                          }
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors
                                                .greenish; // Color when the checkbox is selected
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                child: HtmlWidget(
                                                  '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://pigssh.ddns.net:8080/assets/assets/hogyan%20alakul%20ki%20a%20%C3%BAl%C3%A9rz%C3%A9keny%20b%C3%A9lm%C5%B1k%C3%B6d%C3%A9s.mp4" ></video>',
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
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeOut,
                                                  );
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
                                                  "Kész!",
                                                  style: MyTextStyles.greengomb(context),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
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
                                        color: AppColors.greenish,
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
                                            style:
                                                MyTextStyles.bekezdes(context),
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
                                        activeColor: AppColors.greenish,
                                        // Color when the checkbox is checked
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Colors
                                                .grey; // Color when the checkbox is disabled
                                          }
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors
                                                .greenish; // Color when the checkbox is selected
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                      'assets/images/ordogikor_zold.png',
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
                                                          color:
                                                              AppColors.greenish,
                                                          // Your desired color of the border
                                                          width:
                                                              2, // The thickness of the border
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        // Optional: if you want rounded corners
                                                        color: AppColors
                                                            .whitewhite, // Set the background color for the surrounding area
                                                      ),
                                                      child: Text(
                                                        "Az (ön)hipnózis gyakorlatok segítségével megtörheted ezt a kört és megtanulhatod, hogyan tudod megállítani a fájdalmat és a fájdalommal kapcsolatos nehéz gondolatokat. \nOlyan gyerekektől tudjuk ezt, akik a gyakorlás által egyre jobban és jobban érzik magukat. Az ördögi kör megszakad, majd fokozatosan eltűnik.",
                                                        style: MyTextStyles
                                                            .bekezdes(context),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeOut,
                                                  );
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
                                                  "Kész!",
                                                  style: MyTextStyles.greengomb(context),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
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
                                        color: AppColors.greenish,
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
                                            style:
                                                MyTextStyles.bekezdes(context),
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
                                        activeColor: AppColors.greenish,
                                        // Color when the checkbox is checked
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.disabled)) {
                                            return Colors
                                                .grey; // Color when the checkbox is disabled
                                          }
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return AppColors
                                                .greenish; // Color when the checkbox is selected
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                color: AppColors.greenish,
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
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  // This will justify the text according to textAlign
                                                  children: [
                                                    Text(
                                                      "Megállapodás:",
                                                      style: MyTextStyles
                                                          .feherkicsikovercim(
                                                              context),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
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
                                                            textAlign: TextAlign
                                                                .justify,
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
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeOut,
                                                  );
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
                                                  "Kész!",
                                                  style: MyTextStyles.greengomb(context),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.04),

                            Row(
                              children: [
                                Expanded(
                                  // This will allow text to wrap within the row.
                                  child: Text("Itt találod a gyakorlataid:",
                                      style:
                                          MyTextStyles.vastagbekezdes(context)),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
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
                                        color: AppColors.greenish,
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
                                            style:
                                                MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Eddig ennyiszer hallgattad meg: ",
                                        style:
                                            MyTextStyles.kicsibekezdes(context),
                                      ),
                                      Text(
                                        szam_lekerdezes() as String,
                                        style: MyTextStyles.kicsigreenbekezdes(
                                            context),
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                  borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                                                ),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed

                                                  child:  AudioPlayerPage(url: "http://pigssh.ddns.net:8080/assets/assets/Progr_relax_nagyoknak.mp3",azonosito: "XY123",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
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
                                        color: AppColors.greenish,
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
                                            style:
                                                MyTextStyles.bekezdes(context),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Eddig ennyiszer hallgattad meg: ",
                                        style:
                                            MyTextStyles.kicsibekezdes(context),
                                      ),
                                      Text(
                                        szam_lekerdezes() as String,
                                        style: MyTextStyles.kicsigreenbekezdes(
                                            context),
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
                                            color: AppColors.greenish
                                                .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                5), // Shifts shadow downwards
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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                                  borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                                                ),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                                                  child:  AudioPlayerPage(url: "http://pigssh.ddns.net:8080/assets/assets/A szinek bolygoja.mp3",azonosito: "XY123",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

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
                                                    style:
                                                        MyTextStyles.bekezdes(
                                                            context),
                                                    textAlign:
                                                        TextAlign.justify,
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
                                height:
                                    MediaQuery.of(context).size.width * 0.02),
                            Text(
                              "Nos, ennyi volt erre a hétre. Az elkövetkező két hétben az a házi feladatod, hogy hallgasd meg mindkét gyakorlatot, legalább naponta egyszer. Észre fogod venni, hogy minél többet gyakorolsz, annál jobb hatással lesz a hasadra. Vannak, akik azt veszik észre, hogy a hasuk egy kicsit jobban érzi magát a gyakorlatok után, mások pedig lényegesen jobban érzik magukat tőlük. Érdekes lesz megfigyelni, te hogyan fogod érezni magad.",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.04),
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
                                height:
                                    MediaQuery.of(context).size.width * 0.05),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // itt volt scroll

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
                                      Image.asset('assets/images/5icon_b.png'),
                                  // Replace 'your_image.png' with your image path
                                  title: Text(
                                    '1-2. hét',
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
                                            hipnom3_ModuleHipno(Azonosito),
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
                                          hipnom3_ModuleOpening_M3('Azonosito',0),
                                    ),
                                  );
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
                                leading:
                                    Image.asset('assets/images/6icon_b.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '5-6. hét',
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
                                leading:
                                    Image.asset('assets/images/3icon_b.png'),
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
                                  print('Button pressed ...');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => hipnom3_ModuleHipno2('Azonosito'),
                                    ),
                                  );

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
                                leading:
                                    Image.asset('assets/images/7icon_b.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '9-10. hét',
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
                                      builder: (BuildContext context) => hipnom3_ModuleHipno3('Azonosito'),
                                    ),
                                  );
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
                                leading:
                                Image.asset('assets/images/7icon_b.png'),
                                // Replace 'your_image.png' with your image path
                                title: Text(
                                  '11-12. hét',
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
              //ide kell záró
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
