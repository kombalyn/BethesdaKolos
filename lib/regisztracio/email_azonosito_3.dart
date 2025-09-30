import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/styles.dart'; // Ensure this path is correct based on your project structure
import '../constants/colors.dart'; // Ensure this path is correct based on your project structure
import 'gdpr.dart'; // Ensure this module is correctly implemented
import '../main.dart';
import '../home_page_model.dart';
import '../appbar/appbar.dart';

class Email_3 extends StatelessWidget {
  const Email_3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
        cardTheme: CardTheme(
          color: Colors.white, // This sets the background color of cards to white
        ),
      ),
      home: const HomePageWidgetEmail(),
    );
  }
}

class HomePageWidgetEmail extends StatefulWidget {
  const HomePageWidgetEmail({Key? key}) : super(key: key);

  @override
  _HomePageWidgetEmailState createState() => _HomePageWidgetEmailState();
}

class _HomePageWidgetEmailState extends State<HomePageWidgetEmail> {
  // late WebSocketChannel _channel;

  late HomePageModel _model;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _channel = WebSocketChannel.connect(
    //   Uri.parse('wss://146.148.43.137:8089'),
    // );

    _model = HomePageModel();

    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    _model.textController3 = TextEditingController();
    _model.textController4 = TextEditingController();
    _model.textController5 = TextEditingController();
  }

  @override
  void dispose() {
    // _channel.sink.close();
    _model.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    // Check if the URL can be launched
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A következő oldal nem nyitható meg: $url'),
        ),
      );
    } else {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        //  appBar:   CustomAppBar(title: 'Kutatási fázis'),

        backgroundColor: AppColors.lightshade,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whitewhite,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.015,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Először, kérünk, töltsd ki az alábbi formot:",
                          textAlign: TextAlign.center,
                          style: MyTextStyles.nagybekezdes(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whitewhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                      // EZ AZ ÚJ KÓD: A beágyazott kérdőív helyett egy gombbal nyílik meg
                      Center(
                        child: Text(
                          "Kérjük, kattints az alábbi gombra a kérdőív kitöltéséhez.",
                          textAlign: TextAlign.center,
                          style: MyTextStyles.nagybekezdes(context),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          _launchURL('https://8080-cs-6f0bc9d6-03ef-40c1-855d-bea101900242.cs-europe-west4-fycr.cloudshell.dev/map');
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.bethesdacolor),
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
                          "Ugrás a kérdőívre",
                          style: MyTextStyles.gomb(context),
                        ),
                      ),
                      // EZ AZ ÚJ KÓD VÉGE

                      SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01), // Adjust the horizontal padding as needed
                        child: Text(
                          "Ha kitöltötted kezdhetjük is a feladatokat! \n Visszairányítunk a bejelentkező felületre ahol ezentúl az e-mail címeddel és kutatási azonosítóddal fogsz tudni belépni.",
                          textAlign: TextAlign.center,
                          style: MyTextStyles.nagybekezdes(context),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.width * 0.04),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePageWidget(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.bethesdacolor),
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
                          "Kitöltöttem, kezdjük!",
                          style: MyTextStyles.gomb(context),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.09),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
