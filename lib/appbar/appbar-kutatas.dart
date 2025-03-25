import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:url_launcher/url_launcher.dart';
import '../regisztracio/gdpr.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file
import 'package:lottie/lottie.dart';
import '../main.dart';
export '../home_page_model.dart';
import 'dart:math';
import 'appbar.dart';
import 'appbar-kapcsolat.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _isPressed = false; // State variable to track if the button is pressed

  Future<void> sendEmail(String name, String email, String message) async {
    String username = 'your-email@gmail.com';
    String password = 'your-email-password';
    final smtpServer = gmail(username, password);

    final mailMessage = Message()
      ..from = Address(username, 'Your Name or App Name')
      ..recipients.add('destination-email@example.com')
      ..subject = 'New Contact Message from $name'
      ..text = 'Név: $name\nE-mail: $email\nÜzenet: $message';

    try {
      final sendReport = await send(mailMessage, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sikeres üzenetküldés!"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sikertelen üzenetküldés."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget formField(String label, TextEditingController controller,
      {bool isMessage = false}) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Text(
              label,
              style: MyTextStyles.bekezdes(context),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whitewhite,
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whitewhite,
              contentPadding: EdgeInsets.symmetric(
                  vertical: isMessage ? 20 : 15, horizontal: 20),
              labelText: 'Kattints ide...',
              labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: AppColors.bethesdacolor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType:
            isMessage ? TextInputType.multiline : TextInputType.text,
            maxLines: isMessage ? null : 1,
            minLines: isMessage ? 5 : 1,
            style: MyTextStyles.kicsibekezdes(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whitewhite,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical:                     MediaQuery.of(context).size.width * 0.01),
      child: Padding(
        padding: EdgeInsets.all(                    MediaQuery.of(context).size.width * 0.02,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ha kérdésed van, küldj nekünk üzenetet!',
                style: MyTextStyles.bethesdabekezdes(context),
              ),
              formField('Név:', nameController),
              formField('Email cím:', emailController),
              formField('Üzenet:', messageController, isMessage: true),
              SizedBox(height:                     MediaQuery.of(context).size.width * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    sendEmail(nameController.text, emailController.text,
                        messageController.text);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return AppColors.bethesdacolor;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical:                     MediaQuery.of(context).size.width * 0.01, horizontal:                     MediaQuery.of(context).size.width * 0.02),
                  ),
                ),
                child: Text(
                  'Üzenet küldése',
                  style: MyTextStyles.gomb(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResearcherCard extends StatelessWidget {
  const ResearcherCard({Key? key}) : super(key: key);

  final String _url = "https://scholar.semmelweis.hu/majorjanos/";

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.005;
    double avatarRadius = screenWidth * 0.05;
    double spaceWidth = screenWidth * 0.02;

    return Card(
      elevation: 5,
      color: AppColors.whitewhite,
      margin: EdgeInsets.all(paddingValue),
      child: Padding(
        padding: EdgeInsets.all(paddingValue),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/major_janos.png"),
              radius: avatarRadius,
            ),
            SizedBox(width: spaceWidth),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      "Vezető kutató:",
                      style: MyTextStyles.bethesdabekezdes(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.005),
                  Flexible(
                    child: Text(
                      "Dr Major János, PhD",
                      style: MyTextStyles.bekezdes(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.005),
                  InkWell(
                    onTap: _launchURL,
                    child: Text(
                      _url,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class appbar_kutatas extends StatelessWidget {
  const appbar_kutatas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés kutatás',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
        cardTheme: CardTheme(
          color: AppColors.whitewhite,
        ),
      ),
      home: const Appbar_kutatas(),
    );
  }
}

class Appbar_kutatas extends StatefulWidget {
  const Appbar_kutatas({Key? key}) : super(key: key);

  @override
  State<Appbar_kutatas> createState() => _Appbar_kutatasState();
}

class _Appbar_kutatasState extends State<Appbar_kutatas>
    with SingleTickerProviderStateMixin {
  late HomePageModel _model;
  late AnimationController _controller;

  late double _currentPointOnFunction = 0;
  late double _sliderValue = 0.0;
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _model = HomePageModel();
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
        appBar:  CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.bethesdacolor, // Optional: Override the default background color
    iconColor: AppColors.bethesdacolor, ),
        key: scaffoldKey,
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
    ),
    );
  }


// Define the mobile layout
  Widget mobileLayout() {
    return SingleChildScrollView( // Make the entire layout scrollable if content overflows
      child: Column(
        children: [
          Container(
            color: AppColors.lightshade,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align to top by default
              children: [
                // First card
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Card(
                    elevation: 5,
                    color: AppColors.whitewhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(                    MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Text(
                        "Funkcionális hasi fájdalomzavarok online hipnózis és mozgás-motivációs tréning kezelésének hatásvizsgálata tizenévesek körében",
                        textAlign: TextAlign.center,
                        style: MyTextStyles.bethesdabekezdes(context),
                      ),
                    ),
                  ),
                ),

                // Content Container with Padding


                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whitewhite,
                      // Background color of the Container
                      borderRadius: BorderRadius.circular(0),
                      // Rounded corners for the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // Shadow color with some transparency
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(
                              0, 4), // Vertical offset for the shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right:
                          MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A kutatás célja",
                            style: MyTextStyles.bethesdabekezdes(context),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A funkcionális hasi fájdalomzavarral élő serdülők részére kifejlesztett, különböző online és személyes terápiás módszerek összehasonlítása és azok hatékonyságának vizsgálata. \nEz a kutatás nagy előrelépést jelenthet a krónikus gyermekkori hasi fájdalom kezelésében, ami gyakran jelentős terhet jelent a betegek és családjaik számára. Az eredmények segíthetnek optimalizálni a kezelési protokollokat és módszereket, hogy hatékonyabb és kevésbé invazív megközelítést biztosítsanak a fájdalom csillapítására. Ezenkívül az online terápiás lehetőségek fejlesztése és hatékonyságának igazolása segíthet elérhetővé tenni az ilyen típusú kezeléseket az olyan területeken élő fiatalok számára is, ahol ezek a terápiás lehetőségek nehezen elérhetőek.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign
                                .justify, // This ensures the text is justified within the padding
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.03),
                          Text(
                            "Miért érdemes részt venned a kutatásban?",
                            style: MyTextStyles.bethesdabekezdes(context),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A legjobb dolog, amit tehetsz, hogy minél jobban megismered a saját fájdalmadat és tanulsz róla. Ugyanis minél jobban ismered a fájdalmadat, annál több mindent tudsz tenni azért, hogy jobban legyél! Mi ebben tudunk segíteni Neked. Magyarországon elsőként próbálhatsz ki akár több olyan online és személyes terápiát is, amelyeket kifejezetten funkcionális hasi fájdalmakkal élő serdülőknek fejlesztettünk ki.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign
                                .justify, // This ensures the text is justified within the padding
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.02),
                          Material(
                            elevation: 5.0,
                            // Set your desired elevation here
                            borderRadius: BorderRadius.circular(13),
                            // Maintain the border radius for consistent design
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                // Replace with your desired background color
                                borderRadius: BorderRadius.circular(13),
                                /* border: Border.all(
                                color: AppColors.bethesdacolor,  // Outline with your custom Bethesda color
                                width: 1,  // Outline thickness
                              ),   */
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width *
                                        0.01),
                                // Add padding around the texts within the container
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // Use the minimum space necessary to fit the children
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  // Align texts to the start (left side)
                                  children: [
                                    Text(
                                      "Ez mit foglal magában?",
                                      style:
                                      MyTextStyles.bethesdabekezdes(
                                          context),
                                      textAlign: TextAlign
                                          .justify, // This ensures the text is justified within the padding
                                    ),
                                    SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.01),
                                    Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Milyen terápiákról van szó?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "Online hipnózis terápia, mely a hasi régióra fókuszál\nOnline mozgás-motivációs tréning (M3 Tréning)\nPszichoedukáció a krónikus hasi fájdalmakról\nInterdiszciplináris, multimodális fájdalomterápia",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Hogy néz ki a folyamat?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "1. szakasz: első terápiás lehetőség 12 hétig\n2. szakasz: második terápiás lehetőség újabb 12 hétig\n+ 1 terápiás lehetőség, ha még a panaszok fennállnak: interdiszciplináris, multimodális fájdalomterápia",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Meddig tart a kutatás?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "A kutatás teljes hossza 6+3 hónap, mely 2+1 szakaszra bontható",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Hány alkalommal keresünk meg Téged a vizsgálat alatt?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "Tippelek: 12-18 alkalom",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Add more Text widgets as needed
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // First Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    // You can adjust flex ratios if needed for better spacing
                                    child: Text(
                                        "A kutatás engedélyszáma:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    // Providing more space for the value
                                    child: Text("BM/9151-1/2024",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),

                              // Second Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text("A kutatás kezdete:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("2024.06.01",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),

                              // Third Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text("A bevonási időszak:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        "2024. 04. 01. - 2026. 02. 28.",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.03),
                              Center(
                                child: ResearcherCard(),
                              ),

                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              Center(
                                child: ContactForm(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),


                // Final Image at the botto
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget tabletLayout() {
    return SingleChildScrollView( // Make the entire layout scrollable if content overflows
      child: Column(
        children: [
          Container(
            color: AppColors.lightshade,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align to top by default
              children: [
                // First card
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Card(
                    elevation: 5,
                    color: AppColors.whitewhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Funkcionális hasi fájdalomzavarok online hipnózis és mozgás-motivációs tréning kezelésének hatásvizsgálata tizenévesek körében",
                        textAlign: TextAlign.center,
                        style: MyTextStyles.bethesdabekezdes(context),
                      ),
                    ),
                  ),
                ),

                // Content Container with Padding


                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whitewhite,
                      // Background color of the Container
                      borderRadius: BorderRadius.circular(0),
                      // Rounded corners for the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // Shadow color with some transparency
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(
                              0, 4), // Vertical offset for the shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right:
                          MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A kutatás célja",
                            style: MyTextStyles.bethesdabekezdes(context),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A funkcionális hasi fájdalomzavarral élő serdülők részére kifejlesztett, különböző online és személyes terápiás módszerek összehasonlítása és azok hatékonyságának vizsgálata. \nEz a kutatás nagy előrelépést jelenthet a krónikus gyermekkori hasi fájdalom kezelésében, ami gyakran jelentős terhet jelent a betegek és családjaik számára. Az eredmények segíthetnek optimalizálni a kezelési protokollokat és módszereket, hogy hatékonyabb és kevésbé invazív megközelítést biztosítsanak a fájdalom csillapítására. Ezenkívül az online terápiás lehetőségek fejlesztése és hatékonyságának igazolása segíthet elérhetővé tenni az ilyen típusú kezeléseket az olyan területeken élő fiatalok számára is, ahol ezek a terápiás lehetőségek nehezen elérhetőek.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign
                                .justify, // This ensures the text is justified within the padding
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.03),
                          Text(
                            "Miért érdemes részt venned a kutatásban?",
                            style: MyTextStyles.bethesdabekezdes(context),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.01),
                          Text(
                            "A legjobb dolog, amit tehetsz, hogy minél jobban megismered a saját fájdalmadat és tanulsz róla. Ugyanis minél jobban ismered a fájdalmadat, annál több mindent tudsz tenni azért, hogy jobban legyél! Mi ebben tudunk segíteni Neked. Magyarországon elsőként próbálhatsz ki akár több olyan online és személyes terápiát is, amelyeket kifejezetten funkcionális hasi fájdalmakkal élő serdülőknek fejlesztettünk ki.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign
                                .justify, // This ensures the text is justified within the padding
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.02),
                          Material(
                            elevation: 5.0,
                            // Set your desired elevation here
                            borderRadius: BorderRadius.circular(13),
                            // Maintain the border radius for consistent design
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                // Replace with your desired background color
                                borderRadius: BorderRadius.circular(13),
                                /* border: Border.all(
                                color: AppColors.bethesdacolor,  // Outline with your custom Bethesda color
                                width: 1,  // Outline thickness
                              ),   */
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width *
                                        0.01),
                                // Add padding around the texts within the container
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // Use the minimum space necessary to fit the children
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  // Align texts to the start (left side)
                                  children: [
                                    Text(
                                      "Ez mit foglal magában?",
                                      style:
                                      MyTextStyles.bethesdabekezdes(
                                          context),
                                      textAlign: TextAlign
                                          .justify, // This ensures the text is justified within the padding
                                    ),
                                    SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.01),
                                    Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Milyen terápiákról van szó?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "Online hipnózis terápia, mely a hasi régióra fókuszál\nOnline mozgás-motivációs tréning (M3 Tréning)\nPszichoedukáció a krónikus hasi fájdalmakról\nInterdiszciplináris, multimodális fájdalomterápia",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Hogy néz ki a folyamat?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "1. szakasz: első terápiás lehetőség 12 hétig\n2. szakasz: második terápiás lehetőség újabb 12 hétig\n+ 1 terápiás lehetőség, ha még a panaszok fennállnak: interdiszciplináris, multimodális fájdalomterápia",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Meddig tart a kutatás?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "A kutatás teljes hossza 6+3 hónap, mely 2+1 szakaszra bontható",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "Hány alkalommal keresünk meg Téged a vizsgálat alatt?",
                                                    style: MyTextStyles
                                                        .bethesdabekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                  Text(
                                                    "Tippelek: 12-18 alkalom",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),
                                                    textAlign: TextAlign
                                                        .justify, // This ensures the text is justified within the padding
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Add more Text widgets as needed
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width *
                                  0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // First Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    // You can adjust flex ratios if needed for better spacing
                                    child: Text(
                                        "A kutatás engedélyszáma:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    // Providing more space for the value
                                    child: Text("BM/9151-1/2024",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),

                              // Second Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text("A kutatás kezdete:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("2024.06.01",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),

                              // Third Row
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text("A bevonási időszak:",
                                        style:
                                        MyTextStyles.bethesdabekezdes(
                                            context)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        "2024. 04. 01. - 2026. 02. 28.",
                                        style: MyTextStyles.bekezdes(
                                            context)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.03),
                              Center(
                                child: ResearcherCard(),
                              ),

                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.width *
                                      0.02),
                              Center(
                                child: ContactForm(),
                              ),


                              Center(
                                child: Image.asset(
                                  'assets/images/dokik.png',
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the container's space
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                // Final Image at the bottom

              ],
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


      Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.width * 0.02,
                              MediaQuery.of(context).size.width * 0.03,
                              MediaQuery.of(context).size.width * 0.02),
                          child: Card(
                            elevation: 5,
                            color: AppColors.whitewhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Funkcionális hasi fájdalomzavarok online hipnózis és mozgás-motivációs tréning kezelésének hatásvizsgálata tizenévesek körében",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.bethesdabekezdes(context),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right:
                              MediaQuery.of(context).size.width * 0.05),
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
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.01,
                                  right: MediaQuery.of(context).size.width *
                                      0.01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.01),
                                  Text(
                                    "A kutatás célja",
                                    style: MyTextStyles.bethesdabekezdes(
                                        context),
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.01),
                                  Text(
                                    "A funkcionális hasi fájdalomzavarral élő serdülők részére kifejlesztett, különböző online és személyes terápiás módszerek összehasonlítása és azok hatékonyságának vizsgálata. \nEz a kutatás nagy előrelépést jelenthet a krónikus gyermekkori hasi fájdalom kezelésében, ami gyakran jelentős terhet jelent a betegek és családjaik számára. Az eredmények segíthetnek optimalizálni a kezelési protokollokat és módszereket, hogy hatékonyabb és kevésbé invazív megközelítést biztosítsanak a fájdalom csillapítására. Ezenkívül az online terápiás lehetőségek fejlesztése és hatékonyságának igazolása segíthet elérhetővé tenni az ilyen típusú kezeléseket az olyan területeken élő fiatalok számára is, ahol ezek a terápiás lehetőségek nehezen elérhetőek.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.03),
                                  Text(
                                    "Miért érdemes részt venned a kutatásban?",
                                    style: MyTextStyles.bethesdabekezdes(
                                        context),
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.01),
                                  Text(
                                    "A legjobb dolog, amit tehetsz, hogy minél jobban megismered a saját fájdalmadat és tanulsz róla. Ugyanis minél jobban ismered a fájdalmadat, annál több mindent tudsz tenni azért, hogy jobban legyél! Mi ebben tudunk segíteni Neked. Magyarországon elsőként próbálhatsz ki akár több olyan online és személyes terápiát is, amelyeket kifejezetten funkcionális hasi fájdalmakkal élő serdülőknek fejlesztettünk ki.",
                                    style: MyTextStyles.bekezdes(context),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.02),
                                  Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(13),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius:
                                        BorderRadius.circular(13),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ez mit foglal magában?",
                                              style: MyTextStyles
                                                  .bethesdabekezdes(context),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            Table(
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Milyen terápiákról van szó?",
                                                            style: MyTextStyles
                                                                .bethesdabekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          Text(
                                                            "Online hipnózis terápia, mely a hasi régióra fókuszál\nOnline mozgás-motivációs tréning (M3 Tréning)\nPszichoedukáció a krónikus hasi fájdalmakról\nInterdiszciplináris, multimodális fájdalomterápia",
                                                            style: MyTextStyles
                                                                .bekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Hogy néz ki a folyamat?",
                                                            style: MyTextStyles
                                                                .bethesdabekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          Text(
                                                            "1. szakasz: első terápiás lehetőség 12 hétig\n2. szakasz: második terápiás lehetőség újabb 12 hétig\n+ 1 terápiás lehetőség, ha még a panaszok fennállnak: interdiszciplináris, multimodális fájdalomterápia",
                                                            style: MyTextStyles
                                                                .bekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Meddig tart a kutatás?",
                                                            style: MyTextStyles
                                                                .bethesdabekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          Text(
                                                            "A kutatás teljes hossza 6+3 hónap, mely 2+1 szakaszra bontható",
                                                            style: MyTextStyles
                                                                .bekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Hány alkalommal keresünk meg Téged a vizsgálat alatt?",
                                                            style: MyTextStyles
                                                                .bethesdabekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          Text(
                                                            "Tippelek: 12-18 alkalom",
                                                            style: MyTextStyles
                                                                .bekezdes(
                                                                context),
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.03),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                "A kutatás engedélyszáma:",
                                                style: MyTextStyles
                                                    .bethesdabekezdes(
                                                    context)),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text("BM/9151-1/2024",
                                                style: MyTextStyles.bekezdes(
                                                    context)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.02),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Text("A kutatás kezdete:",
                                                style: MyTextStyles
                                                    .bethesdabekezdes(
                                                    context)),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text("2024.06.01",
                                                style: MyTextStyles.bekezdes(
                                                    context)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.02),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Text("A bevonási időszak:",
                                                style: MyTextStyles
                                                    .bethesdabekezdes(
                                                    context)),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                "2024. 04. 01. - 2026. 02. 28.",
                                                style: MyTextStyles.bekezdes(
                                                    context)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.03),
                                      Center(
                                        child: ResearcherCard(),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.02),
                                      Center(
                                        child: ContactForm(),
                                      ),

                                      Center(
                                        child: Image.asset(
                                          'assets/images/dokik.png',
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the container's space
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
        ],
      );
  }
}


