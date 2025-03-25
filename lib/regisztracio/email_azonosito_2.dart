import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:web_socket_channel/web_socket_channel.dart';
import 'gdpr.dart'; // Ensure this module is correctly implemented
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../main.dart';
import '../constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bethesda_2/regisztracio/email_azonosito_3.dart';
import '../appbar/appbar.dart';

// Assuming 'main.dart' and 'home_page_model.dart' are correctly set up.

class Email_2 extends StatelessWidget {
  String azonosito = "azonosito";
  Email_2(String azonosito, {Key? key}) : super(key: key){
    this.azonosito=azonosito;
  }


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
      home:  HomePageWidgetEmail(azonosito),
    );
  }
}

class HomePageWidgetEmail extends StatefulWidget {
  String azonosito = "azonosito";
  HomePageWidgetEmail(String azonosito, {Key? key}) : super(key: key){
    this.azonosito=azonosito;
  }

  @override
  _HomePageWidgetEmailState createState() => _HomePageWidgetEmailState(azonosito);
}

class _HomePageWidgetEmailState extends State<HomePageWidgetEmail> {
  String azonosito = "azonosito";
  // late WebSocketChannel _channel = WebSocketChannel.connect(
  //   Uri.parse('wss://146.148.43.137:8089'),
  // );
  late WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  late HomePageModel _model;
  String? _selectedOption;
  bool _showBigContainer = false;

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void azonositoBeallitas(String azonosito){
    print(azonosito);
    _channel.sink.add("whatiscode|${azonosito}");
    _channel.stream.listen((message) {
      print(message);
      setState(() {
        this.azonosito=message;
      });
    });
  }

  _HomePageWidgetEmailState(String azonosito) {
    this.azonosito= azonosito;//"Az azonosítód látható lesz itt...";

    //azonositoBeallitas(azonosito);
    print("this.azonosito");
    print(this.azonosito);
  }

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    _model.textController3 = TextEditingController();
    _model.textController4 = TextEditingController();
    _model.textController5 = TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    if (!await canLaunch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    } else {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      //GestureDetector(
      //onTap: () => FocusScope.of(context).unfocus(),
      //child:
      Scaffold(
        key: scaffoldKey,
        //appBar:   CustomAppBar(title: 'Kutatási fázis'),

        backgroundColor: AppColors.lightshade,
        body:
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return mobileLayout();
            } else if (constraints.maxWidth < 1200) {
              // Tablet layout
              return tabletLayout();
            } else {
              // Desktop layout (original preserved layout)
              return desktopLayout();
            }
          },
        ),
      );
  }


// Define the mobile layout
  Widget mobileLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.width * 0.04),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), // Add padding inside the container
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Center(
                        child: Text(
                          "Kérünk, jegyezd fel magadnak az alábbi kutatási azonosítót, hogy a későbbiekben be tudj lépni a felületre, és elkezdhessük a közös munkát:",
                          style: MyTextStyles.nagybekezdes(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Divider(),
                      Center(
                        child: Text(
                          this.azonosito,
                          style: MyTextStyles.bethesdagomb(context),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Center(
                        child: Text(
                          "Ezt elküldtük a regisztrált szülőnek e-mailben is, ha elveszítenéd azt ahova most felírtad, ott is meg fogod találni.",
                          style: MyTextStyles.nagybekezdes(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Center(
                        child: ElevatedButton(
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Email_3(),
                              ),
                            );
                          },

                          child: Text(
                            "Felírtam",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      );
  }


  Widget tabletLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.width * 0.1,
                          bottom: MediaQuery.of(context).size.width * 0.04),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), // Add padding inside the container
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: Text(
                                "Kérünk, jegyezd fel magadnak az alábbi kutatási azonosítót, hogy a későbbiekben be tudj lépni a felületre, és elkezdhessük a közös munkát:",
                                style: MyTextStyles.nagybekezdes(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Divider(),
                            Center(
                              child: Text(
                                this.azonosito,
                                style: MyTextStyles.bethesdagomb(context),
                              ),
                            ),
                            Divider(),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: Text(
                                "Ezt elküldtük a regisztrált szülőnek e-mailben is, ha elveszítenéd azt ahova most felírtad, ott is meg fogod találni.",
                                style: MyTextStyles.nagybekezdes(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Email_3(),
                                    ),
                                  );
                                },

                                child: Text(
                                  "Felírtam",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.gomb(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

          ],
        ),
      );
  }


  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Opacity(
                      opacity: 0.6,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 1.2,
                        child: SvgPicture.asset(
                          "assets/images/reg.svg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.001,
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.width * 0.01,
                          bottom: MediaQuery.of(context).size.width * 0.03),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), // Add padding inside the container
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: Text(
                                "Kérünk, jegyezd fel magadnak az alábbi kutatási azonosítót, hogy a későbbiekben be tudj lépni a felületre, és elkezdhessük a közös munkát:",
                                style: MyTextStyles.nagybekezdes(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Divider(),
                            Center(
                              child: Text(
                                this.azonosito,
                                style: MyTextStyles.bethesdagomb(context),
                              ),
                            ),
                            Divider(),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: Text(
                                "Ezt elküldtük a regisztrált szülőnek e-mailben is, ha elveszítenéd azt ahova most felírtad, ott is meg fogod találni.",
                                style: MyTextStyles.nagybekezdes(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                            Center(
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Email_3(),
                                    ),
                                  );
                                },

                                child: Text(
                                  "Felírtam",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.gomb(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
