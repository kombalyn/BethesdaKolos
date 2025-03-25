import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:url_launcher/url_launcher.dart';
import 'gdpr.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file
import 'package:lottie/lottie.dart';
import '../main.dart';
export '../home_page_model.dart';
import 'dart:math';
import '../appbar/appbar.dart';

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
            // Ensure this is consistent and set to the right color
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
              // Make sure this is the correct white
              contentPadding: EdgeInsets.symmetric(
                  vertical: isMessage ? 20 : 15, horizontal: 20),
              // Adjust padding
              labelText: 'Kattints ide...',
              labelStyle: MyTextStyles.kicsisbethesdabekezdes(context),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              // Adjust as necessary
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1),
                // Ensure border color matches background
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
            // Allows multiple lines if it's the message field
            minLines: isMessage ? 5 : 1,
            // Sets a minimum line count for the message field
            style: MyTextStyles.kicsibekezdes(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whitewhite, // Set the background color of the Card
      elevation: 5,
      // Adjust margins here to match other components if necessary
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Padding(
        // Also adjust internal padding to ensure content alignment
        padding: EdgeInsets.all(16),
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
              SizedBox(height: 20),
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
                      return AppColors.bethesdacolor; // Default color
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          13), // Adjust the value as needed
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24), // Adjust the padding as needed
                  ), // Change the color to your desired color
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
    // Calculate dynamic sizes based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.005;
    double avatarRadius =
        screenWidth * 0.05; // Adjust this value as needed for your design
    double spaceWidth = screenWidth * 0.02; // Space between avatar and text

    return Card(
      elevation: 5, // Elevation to give depth
      color: AppColors.whitewhite,
      margin: EdgeInsets.all(paddingValue), // Margin for spacing
      child: Padding(
        padding: EdgeInsets.all(paddingValue), // Inner spacing
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // Use the minimum space that's necessary for the children
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/major_janos.png"),
              // Replace with your image path
              radius: avatarRadius, // Dynamically adjusted size
            ),
            SizedBox(width: spaceWidth),
            Flexible(
              // Makes the column flexible to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // Use the minimum space that's necessary for the children
                children: [
                  Flexible(
                    // Allows text to wrap if it's too long for the screen
                    child: Text(
                      "Vezető kutató:",
                      style: MyTextStyles.bethesdabekezdes(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.005),
                  Flexible(
                    // New text widget added
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

class Regisztracio extends StatelessWidget {
  const Regisztracio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        /*colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),*/
        useMaterial3: false,

        cardTheme: CardTheme(
          color: AppColors
              .whitewhite, // This sets the background color of cards to white
        ),
        // Other theme configurations
      ),
      home: const HomePageWidgetRegisztracio(),
    );
  }
}

class HomePageWidgetRegisztracio extends StatefulWidget {
  const HomePageWidgetRegisztracio({Key? key}) : super(key: key);

  @override
  State<HomePageWidgetRegisztracio> createState() =>
      _HomePageWidgetRegisztracioState();
}

class _HomePageWidgetRegisztracioState extends State<HomePageWidgetRegisztracio>
    with SingleTickerProviderStateMixin {
  late HomePageModel _model;
  late AnimationController _controller;

  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _model = HomePageModel(); // Initialize the model
    // Initialize other necessary fields here
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //GestureDetector(
        //onTap: () => _model.unfocusNode.canRequestFocus
        //  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
        // : FocusScope.of(context).unfocus(),
        // child:
        Scaffold(
      key: scaffoldKey,
      /* appBar: AppBar(
          backgroundColor: AppColors.whitewhite,  // Base color, but will be covered.
          elevation: 0,  // No shadow.
          leadingWidth: 0,  // Remove space for leading icon if not needed.
          titleSpacing: 0,  // Remove default spacing on all sides.
          title: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: kToolbarHeight,  // Use standard AppBar height.
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,  // 3 parts of the space for the left section.
                      child: Container(
                        color: AppColors.whitewhite,  // Color for the left section.
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),  // Optional, adjust as needed.
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/bethesda_gyermekkorhaz_logo.png",
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),  // Space between the logo and the text.
                            Expanded(
                              child: Text(
                                "Bethesda Gyermekkórház Fájdalomkezelő Centrum",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: MediaQuery.of(context).size.width * 0.016,
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,  // 1 part of the space for the right section.
                      child: Container(
                        color: AppColors.whitewhite,  // Color for the right section.
                        alignment: Alignment.center,
                        child: Text(
                          'Kutatási fázis',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: MediaQuery.of(context).size.width * 0.016,
                            color: AppColors.bethesdacolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          automaticallyImplyLeading: false,  // No back button or menu automatically implied.
        ), */

      backgroundColor: AppColors.lightshade,
      body: LayoutBuilder(
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
                      right: MediaQuery.of(context).size.width * 0.03),
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
                SizedBox(height: MediaQuery.of(context).size.width * 0.03),


                // Centered Card with a Button
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.001),
                    child: Card(
                      elevation: 5,
                      color: AppColors.whitewhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide( // Add the border side property
                          color: AppColors.bethesdacolor, // Choose your border color here
                          width: 2.0, // Set the border thickness
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                          Text("Te is szívesen részt vennél ebben a kutatásban?",
                              textAlign: TextAlign.center,
                              style: MyTextStyles.bekezdes(context)),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Gdpr()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.bethesdacolor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.width * 0.009,
                                  horizontal: MediaQuery.of(context).size.width * 0.005,
                                ),
                              ),
                            ),
                            child: Text("Igen,\n részt veszek!",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.gomb(context)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                        ],
                      ),
                    ),
                  ),
                ),

                // Final Image at the bottom
                Image.asset(
                  "assets/images/nyitokep_2_2.png",
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.fill, // This will stretch the image to fill the space, which might result in distortion
                ),
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
                          right: MediaQuery.of(context).size.width * 0.03),
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


                // Centered Card with a Button
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.001),
                    child: Card(
                      elevation: 5,
                      color: AppColors.whitewhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide( // Add the border side property
                          color: AppColors.bethesdacolor, // Choose your border color here
                          width: 2.0, // Set the border thickness
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                          Text("Te is szívesen részt vennél ebben a kutatásban?",
                              textAlign: TextAlign.center,
                              style: MyTextStyles.bekezdes(context)),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Gdpr()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.bethesdacolor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.width * 0.009,
                                  horizontal: MediaQuery.of(context).size.width * 0.005,
                                ),
                              ),
                            ),
                            child: Text("Igen,\n részt veszek!",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.gomb(context)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.007),
                        ],
                      ),
                    ),
                  ),
                ),

                // Final Image at the bottom
                Image.asset(
                  "assets/images/nyitokep_2_2.png",
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.fill, // This will stretch the image to fill the space, which might result in distortion
                ),
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
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.09), // Space between rectangle and card

            SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.05), // Space between rectangle and card
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  // Make only this column scrollable
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width *
                                0.05, // Left padding
                            MediaQuery.of(context).size.width *
                                0.02, // Top padding
                            MediaQuery.of(context).size.width *
                                0.03, // Right padding
                            MediaQuery.of(context).size.width *
                                0.02 // Bottom padding
                            ),
                        child: Card(
                          elevation: 5,
                          // Shadow effect
                          color: AppColors.whitewhite,
                          // Background color of the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            // Rounded corners for the card
                            /*side: BorderSide(
      color: AppColors.bethesdacolor, // Color of the border
      width: 1.0, // Thickness of the border
    ),*/
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            // Adjust the padding as needed
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
                            right: MediaQuery.of(context).size.width * 0.03),
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Aligns children to the top of the Row
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07),
                                              Text(
                                                "Te is szívesen részt vennél ebben a kutatásban?",
                                                textAlign: TextAlign.center,
                                                style: MyTextStyles
                                                    .bethesdabekezdes(context),
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              Text(
                                                "Amennyiben igen, kattints a jobb oldali gombra!",
                                                style: MyTextStyles.bekezdes(
                                                    context),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03), // Space between text and GIF
                                        Container(
                                          constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2, // Control the height of the GIF
                                          ),
                                          alignment: Alignment
                                              .topRight, // Aligns the GIF to the top-right within its container
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.rotationZ(-pi /
                                                2), // Rotate the GIF 90 degrees clockwise
                                            child: Lottie.asset(
                                              "assets/images/nyil.json",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Make sure the GIF stays square
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Ensure the GIF stays within these bounds
                                              fit: BoxFit
                                                  .contain, // Ensure the animation fits within the specified dimensions
                                            ),
                                          ),
                                        ),
                                      ],
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
              Expanded(
                flex: 1,
                child: Container(
                  color: AppColors.lightshade,
                  // Set your desired background color here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Aligns children to start, center, and end of main axis
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.17), // Adds more space at the top
                      Center(
                        // Centering the content vertically and horizontally
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          // Adjust width to 90% of screen width
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *
                                0.001, // Minimal horizontal margin
                          ),
                          child: Card(
                            elevation: 5,
                            // Set the elevation for the Card
                            color: AppColors.whitewhite,
                            // Background color for Card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                              side: BorderSide( // Add the border side property
                                color: AppColors.bethesdacolor, // Choose your border color here
                                width: 2.0, // Set the border thickness
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // Minimizes the column height to the height of its children
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.007),
                                // Space inside the card before text
                                Text(
                                    "Te is szívesen részt vennél ebben a kutatásban?",
                                    textAlign: TextAlign.center,
                                    // Center align text horizontally
                                    style: MyTextStyles.bekezdes(context)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.007),
                                // Space between text and button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Gdpr()), // Navigate to GDPR page
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.bethesdacolor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the value as needed
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.009,
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.005), // Adjust the padding as needed
                                    ), // Change the color to your desired color// Set the background color
                                  ),
                                  child: Text("Igen,\n részt veszek!",
                                      textAlign: TextAlign.center,
                                      style: MyTextStyles.gomb(context)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.007),
                                // Space inside the card after button
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(), // Pushes the card and image apart
                      Image.asset(
                        "assets/images/nyitokep_2_2.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        fit: BoxFit
                            .fill, // This will stretch the image to fill the space, which might result in distortion
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
/*
        bottomNavigationBar: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: MediaQuery.of(context).size.height*0.08,  // Custom height for the bottom navigation bar
              child: Row(
                children: [
                  Expanded(
                    flex: 4, // Taking up 4 parts of the space for the left and middle combined
                    child: Container(
                      color: AppColors.lightshade,  // Color for the left section
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                            ImageIcon(
                              AssetImage("assets/images/bethesda_gyerm_logo_nevvel.png"), // Path to your image asset
                              size: MediaQuery.of(context).size.width * 0.05, // Size of the icon image
                            ),

                          Expanded(
                            child: Center( // This will center the Text widget inside the Expanded widget
                              child: Text(
                                "Magyarországi Református Egyház Bethesda Gyermekkórháza\n1146 Budapest, Bethesda utca 3. (Zugló)",  // Example text
                                textAlign: TextAlign.center, // Centers the text horizontally in its line box
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: MediaQuery.of(context).size.width * 0.009,  // Adjust font size as necessary
                                  color: AppColors.bethesdacolor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,  // Aligns children to the right
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,  // Ensures text aligns to the right
                              children: [
                                Text(
                                  '+36 1 920 6000\nbethesda@bethesda.hu',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: MediaQuery.of(context).size.width * 0.009, // Font size
                                    color: AppColors.bethesdacolor,
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,  // 1 part of the space for the right section
                    child: Container(
                      color: AppColors.lightaccentcolor,  // Color for the right section
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

*/
  }
}
