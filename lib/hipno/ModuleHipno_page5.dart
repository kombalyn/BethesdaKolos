import 'dart:js';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:web_socket_channel/web_socket_channel.dart';
import 'ModuleHipno_page2.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno_page3.dart';
import 'ModuleHipno.dart';
import 'ModuleHipnomp3_1.dart';
import 'ModuleOpening.dart';
export '../home_page_model.dart';
import '../constants/AudioPlayerPage.dart';
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

class ModuleHipno5 extends StatelessWidget {
  ModuleHipno5(String s, {super.key}){Azonosito=s;}
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
  late HomePageModel _model;


  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
  );

  String szam1 = "-1";
  String szam2 = "-1";
  String szam3 = "-1";
  String szam4 = "-1";
  String szam5 = "-1";
  String szam6 = "-1";
  String szam7 = "-1";
  String szam8 = "-1";
  String szam9 = "-1";
  String szam10 = "-1";
  String szam11 = "-1";
  String szam12 = "-1";
  String szam13 = "-1";
  String szam14 = "-1";
  String szam15 = "-1";



  String adott_mp_lekerese(String mpfile){
    String szam = "-1";
    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8089'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    _channel.sink.add("szamlekerdezes|$Azonosito,$mpfile");
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      if(message=="0"){
        setState(() {
          szam = "0";
        });
      }

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        print("vissz " + szam);
      } catch (e) {
        print('Error: $e');
      }
    });
    return szam;
  }


  /*
  Future<void> szamokBbeallitas()async {

    setState(() {
      szam1 = adott_mp_lekerese("mp3_12");
      szam2 = adott_mp_lekerese("mp3_13");
      szam3 = adott_mp_lekerese("mp3_14");
      szam4 = adott_mp_lekerese("mp3_15");
      szam5 = adott_mp_lekerese("mp3_16");
      szam6 = adott_mp_lekerese("mp3_17");
      szam7 = adott_mp_lekerese("mp3_18");
      szam8 = adott_mp_lekerese("mp3_19");
      szam9 = adott_mp_lekerese("mp3_21");
      szam10 = adott_mp_lekerese("mp3_22");
      szam11 = adott_mp_lekerese("mp3_23");
      szam12 = adott_mp_lekerese("mp3_24");
      szam13 = adott_mp_lekerese("mp3_25");
      szam14 = adott_mp_lekerese("mp3_26");
      szam15 = adott_mp_lekerese("mp3_27");
    });
  }
   */


  Future<void> szamokBbeallitas()async {


    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8889'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
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
          szam11 = cleanMessage;
        });

        print("vissz " + szam11);
      } catch (e) {
        print('Error: $e');
      }
    });


    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8889'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    print("channel_azonosito $Azonosito");
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_2") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam12 = cleanMessage;
        });

        print("vissz " + szam12);
      } catch (e) {
        print('Error: $e');
      }
    });

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8889'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    print("channel_azonosito $Azonosito");
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_3") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam13 = cleanMessage;
        });

        print("vissz " + szam13);
      } catch (e) {
        print('Error: $e');
      }
    });

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8889'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    print("channel_azonosito $Azonosito");
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_4") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam14 = cleanMessage;
        });

        print("vissz " + szam14);
      } catch (e) {
        print('Error: $e');
      }
    });

    _channel = WebSocketChannel.connect(
      //Uri.parse('wss://34.72.67.6:8889'),
      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
    );
    print("channel_azonosito $Azonosito");
    _channel.sink.add("szamlekerdezes|$Azonosito,mp3_5") ;
    // //_channel.sink.add("mp3|$azonosito-$hangfajlszam");
    _channel.stream.listen((message) {
      print('Received message: $message');

      // Kapcsos zárójelek eltávolítása
      String cleanMessage = message.replaceAll(RegExp(r'[{}]'), "");
      try {
        // Számra konvertálás
        setState(() {
          szam15 = cleanMessage;
        });

        print("vissz " + szam15);
      } catch (e) {
        print('Error: $e');
      }
    });

    //szam1 = await szam_lekerdezes();
    //szam2 = await szam_lekerdezes();
  }


  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleHipnotState(String azonosito){Azonosito=azonosito;}

  final Uri _url = Uri.parse('https://www.bethesda.hu/');

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();


    //szamokBbeallitas();
    szamokBbeallitas();
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
        appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.blueish, // Optional: Override the default background color
          iconColor: AppColors.blueish,),
        drawer: Drawer(
          child:   SidebarLayout(
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
            selectedWeek: '9-12.hét', // Specify which week is selected
            weekTextStyles: {
              '9-12.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
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




  Widget mobileLayout(BuildContext context){
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
                            mainAxisAlignment: MainAxisAlignment.center, // Aligns the image to the center horizontally
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6, // Set a width for the image
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/vidam_fiatalok_illusztracio.png',
                                    fit: BoxFit.cover, // Ensure the image covers the container's space
                                  ),
                                ),
                              ),
                            ],
                          ),

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
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eltelt nyolc hét. \n \n A következő hetekben szabadon kiválaszthatod, hogy melyik nap melyik felvételt szeretnéd hallgatni. Aszerint válassz, hogy mi tetszett a legjobban és mi segített a legtöbbet. Váltogass a felvételek között bátran, ahogy neked jólesik. Vannak, akiknek ennyi idő után már nem is kell hallgatni a felvételeket, mert szóról szóra megtanulták őket és maguktól is tudják végezni a gyakorlatokat. Még arra is van lehetőség, hogy módosítsd a gyakorlatokat, átírd vagy kiegészítsd őket, ha úgy többet segítenek neked.\n\nA következő négy hétben hallgass meg mindennap egy vagy két gyakorlatot. Ahogyan ezt teszed, észre fogod venni, hogy a hasad egyre jobban és jobban érzi magát. Az is elképzelhető, hogy mostanra a pocakod teljesen egészségesnek érzi magát. Ilyenkor is fontos még folytatni a gyakorlást, mert ez segít abban, hogy a hasad megőrizze ezeket a jó érzéseket. Ha előfordul még hasfájás, akkor is folytasd a felvételek hallgatását, mert van akinek egy kicsit több időre és türelemre van szüksége ahhoz, hogy jobban érezze magát a hipnózisnak köszönhetően. Ez is teljesen rendben van.",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.03),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Sok sikert a következő hetekhez!",
                                  style: MyTextStyles.bethesdagomb_lila(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.05),


                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:
                                AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Relaxációs hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          "szam1", // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1"
                                  ,onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Biztonságos Hely hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam2, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
//IDEKELL
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Színek Bolygója hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          "szam3", // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20gondtalan%20tengerpart.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),
                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A gondtalan tengerpart.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',

                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Gondtalan Tengerpart hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          "szam4", // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20csuszda.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // child: HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A csuszda.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg A Csúszda hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam5, // Your button text
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
                              MediaQuery.of(context).size.width * 0.07),

                          // You can add more rows as needed
                        ],
                      ),
                    ),
                  ],
                ),
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
                            mainAxisAlignment: MainAxisAlignment.center, // Aligns the image to the center horizontally
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6, // Set a width for the image
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/vidam_fiatalok_illusztracio.png',
                                    fit: BoxFit.cover, // Ensure the image covers the container's space
                                  ),
                                ),
                              ),
                            ],
                          ),

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
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eltelt nyolc hét. \n \n A következő hetekben szabadon kiválaszthatod, hogy melyik nap melyik felvételt szeretnéd hallgatni. Aszerint válassz, hogy mi tetszett a legjobban és mi segített a legtöbbet. Váltogass a felvételek között bátran, ahogy neked jólesik. Vannak, akiknek ennyi idő után már nem is kell hallgatni a felvételeket, mert szóról szóra megtanulták őket és maguktól is tudják végezni a gyakorlatokat. Még arra is van lehetőség, hogy módosítsd a gyakorlatokat, átírd vagy kiegészítsd őket, ha úgy többet segítenek neked.\n\nA következő négy hétben hallgass meg mindennap egy vagy két gyakorlatot. Ahogyan ezt teszed, észre fogod venni, hogy a hasad egyre jobban és jobban érzi magát. Az is elképzelhető, hogy mostanra a pocakod teljesen egészségesnek érzi magát. Ilyenkor is fontos még folytatni a gyakorlást, mert ez segít abban, hogy a hasad megőrizze ezeket a jó érzéseket. Ha előfordul még hasfájás, akkor is folytasd a felvételek hallgatását, mert van akinek egy kicsit több időre és türelemre van szüksége ahhoz, hogy jobban érezze magát a hipnózisnak köszönhetően. Ez is teljesen rendben van.",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.03),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Sok sikert a következő hetekhez!",
                                  style: MyTextStyles.bethesdagomb_lila(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.05),


                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:
                                AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Relaxációs hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam6, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1"
                                  ,onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Biztonságos Hely hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam7, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
//IDEKELL
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Színek Bolygója hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam8, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20gondtalan%20tengerpart.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),
                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A gondtalan tengerpart.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',

                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Gondtalan Tengerpart hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam9, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9, // Adjust the width as needed

                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20csuszda.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // child: HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A csuszda.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg A Csúszda hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          "szam10", // Your button text
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
                              MediaQuery.of(context).size.width * 0.07),

                          // You can add more rows as needed
                        ],
                      ),
                    ),
                  ],
                ),
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
                              MediaQuery.of(context).size.width * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Aligns the image to the center horizontally
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6, // Set a width for the image
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/vidam_fiatalok_illusztracio.png',
                                    fit: BoxFit.cover, // Ensure the image covers the container's space
                                  ),
                                ),
                              ),
                            ],
                          ),

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
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eltelt nyolc hét. \n \n A következő hetekben szabadon kiválaszthatod, hogy melyik nap melyik felvételt szeretnéd hallgatni. Aszerint válassz, hogy mi tetszett a legjobban és mi segített a legtöbbet. Váltogass a felvételek között bátran, ahogy neked jólesik. Vannak, akiknek ennyi idő után már nem is kell hallgatni a felvételeket, mert szóról szóra megtanulták őket és maguktól is tudják végezni a gyakorlatokat. Még arra is van lehetőség, hogy módosítsd a gyakorlatokat, átírd vagy kiegészítsd őket, ha úgy többet segítenek neked.\n\nA következő négy hétben hallgass meg mindennap egy vagy két gyakorlatot. Ahogyan ezt teszed, észre fogod venni, hogy a hasad egyre jobban és jobban érzi magát. Az is elképzelhető, hogy mostanra a pocakod teljesen egészségesnek érzi magát. Ilyenkor is fontos még folytatni a gyakorlást, mert ez segít abban, hogy a hasad megőrizze ezeket a jó érzéseket. Ha előfordul még hasfájás, akkor is folytasd a felvételek hallgatását, mert van akinek egy kicsit több időre és türelemre van szüksége ahhoz, hogy jobban érezze magát a hipnózisnak köszönhetően. Ez is teljesen rendben van.",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.03),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Sok sikert a következő hetekhez!",
                                  style: MyTextStyles.bethesdagomb_lila(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                              height:
                              MediaQuery.of(context).size.width * 0.05),


                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                                child:
                                AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Relaxációs hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam11, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/Progr_relax_nagyoknak.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_3"
                                  ,onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/Progr_relax_nagyoknak.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Biztonságos Hely hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam12, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
//IDEKELL
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20szinek%20bolygoja.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_1",onUzenetKuldes: szamokBbeallitas,),

                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Színek Bolygója hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam13, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),

                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed
                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20gondtalan%20tengerpart.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_4",onUzenetKuldes: szamokBbeallitas,),
                                // HtmlWidget(
                                //     '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A gondtalan tengerpart.mp3" ></audio>',
                                //     // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',

                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg a Gondtalan Tengerpart hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam14, // Your button text
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
                              height: MediaQuery.of(context).size.width *
                                  0.05),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the corner radius
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.43, // Adjust the width as needed

                                child:  AudioPlayerPage(url: "https://storage.googleapis.com/lomeeibucket/A%20csuszda.mp3",azonosito: "$Azonosito",hangfajlszam: "mp3_5",onUzenetKuldes: szamokBbeallitas,),

                                // child: HtmlWidget(
                                //   '<audio controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A csuszda.mp3" ></audio>',
                                //   // '<iframe style="border:none; margin:0; padding:0; width:100%; height:100%;" src="http://baby.analogic.sztaki.hu/assets/nas/data/PUBLIC/anagy/Bethesda_vids/A szinek bolygoja.mp3" frameborder="0" allowfullscreen></iframe>',
                                // ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                // This ensures the text fits within the available space and wraps.
                                child: Text(
                                  "Eddig ennyiszer hallgattad meg A Csúszda hanganyagot:",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.03),
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
                                          szam15, // Your button text
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
                              MediaQuery.of(context).size.width * 0.07),

                          // You can add more rows as needed
                        ],
                      ),
                    ),
                  ],
                ),
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
                  selectedWeek: '9-12.hét', // Specify which week is selected
                  weekTextStyles: {
                    '9-12.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
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
