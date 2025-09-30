import 'package:bethesda_2/regisztracio/email_azonosito_3.dart';
import 'package:bethesda_2/regisztracio/regisztracio.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webview_flutter/webview_flutter.dart';

//import 'package:video_player/video_player.dart';
import 'constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file

import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'm3/ModuleOpening_M3.dart';
import 'hipnom3/hipnom3_12_ModuleHipno.dart';
import 'inter/ModuleOpening_inter.dart';
import 'standardcare/ModuleOpening_standardcare.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Android speciális konfigurációhoz
import 'package:webview_flutter_android/webview_flutter_android.dart';
// iOS speciális konfigurációhoz
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'hipno/ModuleOpening.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

void main() async{
  // Platform inicializálása WebView-hoz
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const  Size(1263, 551),
      // Set your design size based on your design prototype
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'Fájdalomkezelés bejelentkezés',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          useMaterial3: false,
        ),
        home:const  SelectionArea(
            child:
                 HomePageWidget()), // Make sure this is the widget you want to start with
      ),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  late WebSocketChannel _channel = WebSocketChannel.connect(
     //Uri.parse('wss://34.72.67.6:8089'),
     //Uri.parse('wss://prohuman.ddns.net:8889'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
   );


/*
  int calculateDateDifference(String message) {
    try {
      // Először megkeressük a zárójelben lévő részt
      int startIndex = message.indexOf('(');
      int endIndex = message.indexOf(')');

      if (startIndex == -1 || endIndex == -1) {
        throw FormatException('Nem található zárójelben lévő rész');
      }

      // Kivesszük a zárójelben lévő részt és feldaraboljuk vesszők mentén
      String bracketsContent = message.substring(startIndex + 1, endIndex);
      List<String> parts = bracketsContent.split(',').map((e) => e.trim()).toList();

      print("parts");
      print(parts);

      // A 8,9,10-es indexű részek tartalmazzák a regisztrációs dátumot
      // Eltávolítjuk az idézőjeleket
      String year = parts[2].replaceAll("'", "").trim();   // 2024
      String month = parts[3].replaceAll("'", "").trim();  // 12
      String day = parts[4].replaceAll("'", "").trim();    // 01

      // Összeállítjuk a regisztrációs dátumot
      DateTime registrationDate = DateTime(
          int.parse(year),
          int.parse(month),
          int.parse(day)
      );

      // A jelenlegi dátum a zárójel után van
      String currentDateStr = message.substring(endIndex + 2); // +2 a vessző és szóköz miatt
      DateTime currentDate = DateTime.parse(currentDateStr);

      // Különbség számítása napokban
      return currentDate.difference(registrationDate).inDays;

    } catch (e) {
      print('Hiba történt a dátumok feldolgozása során: $e');
      return -1;
    }
  }


  int calculateDateDifference(String message) {
    try {
      // A válasz formátuma: "True,2024-12-01" vagy "False"
      final parts = message.split(',');
      if (parts.length < 2 || parts
      [0] != "True") return -1;

      final regDateStr = parts[1].trim();
      final currentDate = DateTime.now();
      final regDate = DateTime.parse(regDateStr);

      return currentDate.difference(regDate).inDays;
    } catch (e) {
      print('Error calculating date difference: $e');
      return -1;
    }
  }
 */

  int calculateDateDifference(String message) {
    try {
      // A válasz formátuma: "True,2024-12-01" vagy "False"
      var parts = message.split('),');
      parts = parts[0].split(',');

      print("parts");
      //print(parts);

      String year = parts[7].replaceAll("'", "").trim();   // 2024
      String month = parts[8].replaceAll("'", "").trim();  // 12
      String day = parts[9].replaceAll("'", "").trim();    // 01

      //print(year);
      //print(month);
      //print(day);

      // Összeállítjuk a regisztrációs dátumot
      DateTime registrationDate = DateTime(
          int.parse(year),
          int.parse(month),
          int.parse(day)
      );

      //if (parts.length < 2 || parts[0] != "True") return -1;

      //final regDateStr = parts[1].trim();
      final currentDate = DateTime.now();
      //final regDate = DateTime.parse(regDateStr);
      //final regDate = registrationDate;

      //return currentDate.difference(regDate).inDays;
      return currentDate.difference(registrationDate).inDays;
    } catch (e) {
      print('Error calculating date difference: $e');
      return -1;
    }
  }



  //late VideoPlayerController _controller;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/animation.mp4')
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
  Widget orDivider(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(color: Colors.grey),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.005),
          child: Text(
            "VAGY",
            style: MyTextStyles.nagybekezdes(context),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.grey),
        ),
      ],
    );
  }
  Widget orDividermob(BuildContext context, double dividerWidth) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ensure the Row only takes up as much space as needed
        children: <Widget>[
          SizedBox(
            width: dividerWidth, // Use the provided width for the first divider
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02), // Adjust the padding for spacing
            child: Text(
              "VAGY",
              style: MyTextStyles.nagybekezdes(context),
            ),
          ),

          SizedBox(
            width: dividerWidth, // Use the provided width for the second divider
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return
     // GestureDetector(
      //onTap: () => _model.unfocusNode.canRequestFocus
          //? FocusScope.of(context).requestFocus(_model.unfocusNode)
        //  : FocusScope.of(context).unfocus(),
      //child:
      Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.lightshade,
        // backgroundColor: Colors.white70,
        drawer: Drawer(
          elevation: 16,
        ),
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
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              color: AppColors.lightaccentcolor,
              width: MediaQuery.of(context).size.width, // Adjusted width for full screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04, // Padding on the left
                      right: MediaQuery.of(context).size.width * 0.04, // Padding on the right
                      top: MediaQuery.of(context).size.height * 0.01, // Padding on the top
                      bottom: MediaQuery.of(context).size.height * 0.005, // Padding on the top
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align items horizontally to the start
                      crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/bethesda_gyermekkorhaz_logo.png",
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02, // Add space between image and text
                        ),
                        Expanded(
                          child: Text(
                            "Üdvözlünk a Bethesda Gyermekkórház Online Fájdalomkezelő weboldalán!",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.feherkovercim(context),
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Add space between the two containers
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02), // Space between fields

                  ListTile(
                    subtitle: Text(
                      'A továbblépéshez kérünk, jelentkezz be az e-mail címednek és a korábban megkapott kutatási azonosítódnak a megadásával.',
                      textAlign: TextAlign.center,
                      style: MyTextStyles.nemferde_bekezdes(context),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    tileColor: Colors.white,
                    dense: false,
                  ),
                  SizedBox( height:MediaQuery.of(context).size.width * 0.02),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6, // Adjusted width
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0,
                              MediaQuery.of(context).size.width * 0.03,
                              0,
                              0,
                            ),
                            child: Text(
                              'E-mail cím:',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.nagybekezdes(context),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightshade,
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 0.5, // Border thickness
                            ),
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              MediaQuery.of(context).size.width * 0.005,
                              0,
                              MediaQuery.of(context).size.width * 0.005,
                              0,
                            ),
                            child: TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero, // Remove padding
                                labelText: 'Kattints ide...',
                                labelStyle: MyTextStyles.kicsiszinesbekezdes(context),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white, // No visible border
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white, // No visible border
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, // Error color
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, // Error color
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: MyTextStyles.kicsibekezdes(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02), // Space between fields
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6, // Adjusted width
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0,
                              MediaQuery.of(context).size.width * 0.03,
                              0,
                              0,
                            ),
                            child: Text(
                              'Kutatási azonosító:',
                              textAlign: TextAlign.center,
                              style: MyTextStyles.nagybekezdes(context),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightshade,
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 0.5, // Border thickness
                            ),
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              MediaQuery.of(context).size.width * 0.005,
                              0,
                              MediaQuery.of(context).size.width * 0.005,
                              0,
                            ),
                            child: TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero, // Remove padding
                                labelText: 'Kattints ide...',
                                labelStyle: MyTextStyles.kicsiszinesbekezdes(context),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white, // No visible border
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white, // No visible border
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, // Error color
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red, // Error color
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: MyTextStyles.kicsibekezdes(context),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        ElevatedButton(
                          onPressed: () async {
                            // Handle login
                            print("Login pressed");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ModuleOpening('XY978',0),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.lightaccentcolor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.width * 0.01,
                                horizontal: MediaQuery.of(context).size.width * 0.01,
                              ),
                            ),
                          ),
                          child: Text(
                            " Bejelentkezés ",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                        child:
                        orDividermob(context, MediaQuery.of(context).size.width * 0.1),

                      ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            print("New user pressed");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Regisztracio(),
                                    //Email_3(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.whitewhite),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.width * 0.01,
                                horizontal: MediaQuery.of(context).size.width * 0.01,
                              ),
                            ),
                          ),
                          child: Text(
                            "Először jársz itt?",
                            textAlign: TextAlign.center,
                            style: MyTextStyles.szinesgomb(context),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width*0.08,
                        ),
                        Image.asset(
                          "assets/images/nyito_oldal_4_2.png",
                          width: MediaQuery.of(context).size.width * 0.8, // Adjusted width
                          fit: BoxFit.fill,
                        ),
                      ],

                    ),

                  ),
                ],

              ),

            ),
          ],
        ),
      ),
    );
  }


  Widget tabletLayout(){
    // This is your original layout that will be used for desktop/laptop views
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                Container(
                  color: AppColors.lightaccentcolor,
                  width: MediaQuery.of(context).size.width * 0.3, // The width of the entire container
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start, // Keep items aligned to the top
                    children: [
                      // Bethesda logo stays at the top
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.02, // Added top padding for spacing
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/bethesda_gyermekkorhaz_logo.png",
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005, // Add spacing after the logo
                      ),
                      // The last image now right below the logo
                      Image.asset(
                        "assets/images/nyito_oldal_4_2.png",
                        width: MediaQuery.of(context).size.width * 0.3, // Keep the same width
                        fit: BoxFit.fill, // Maintain fit
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02, // Add space between the image and the text
                      ),
                      Spacer(),

                      // Text section below the image
                      Text(
                        "Üdvözlünk a Bethesda Gyermekkórház Online Fájdalomkezelő weboldalán!",
                        textAlign: TextAlign.center,
                        style: MyTextStyles.feherkovercim(context),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),

                    ],
                  ),
                ),


                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        //title: Text(
                        //  'Bethesda Gyermekkórház Online Fájdalomkezelő',
                        // textAlign: TextAlign.center,
                        // style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),
                        //),
                        subtitle: Text(
                          'A továbblépéshez kérünk, jelentkezz be az e-mail címednek és a korábban megkapott kutatási azonosítódnak a megadásával.',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.nemferde_bekezdes(context),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.03,
                                    0,
                                    0),
                                child: Text(
                                  'E-mail cím:',
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.nagybekezdes(context),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightshade,
                                // Background color of the container
                                border: Border.all(
                                  color: Colors.grey, // Outline color
                                  width: 0.5, // Outline thickness
                                ),
                                // If you also want to have rounded corners, add the borderRadius property
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0),
                                child: TextFormField(
                                  controller: _model.textController1,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    // <-- Set contentPadding to zero
                                    labelText: 'Kattints ide...',
                                    labelStyle:
                                    MyTextStyles.kicsiszinesbekezdes(
                                        context),
                                    //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder:
                                    UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  style:
                                  MyTextStyles.kicsibekezdes(context),
                                  //validator: _model.textController1Validator.asValidator(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.03,
                                    0,
                                    0),
                                child: Text(
                                  'Kutatási azonosító:',
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.nagybekezdes(context),
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightshade,
                                // Background color of the container
                                border: Border.all(
                                  color: Colors.grey, // Outline color
                                  width: 0.5, // Outline thickness
                                ),
                                // If you also want to have rounded corners, add the borderRadius property
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0),
                                child: TextFormField(
                                  controller: _model.textController2,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    // <-- Set contentPadding to zero
                                    labelText: 'Kattints ide...',
                                    labelStyle:
                                    MyTextStyles.kicsiszinesbekezdes(
                                        context),
                                    //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white30,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder:
                                    UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  style:
                                  MyTextStyles.kicsibekezdes(context),
                                  //validator: _model.textController1Validator.asValidator(context),
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.05,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {

                                  _channel = WebSocketChannel.connect(
                                    //Uri.parse('wss://prohuman.ddns.net:8889'),
                                    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
                                  );
                              
                                  String? szov = _model.textController1?.text;
                                  String? szov2 = _model.textController2?.text;
                                  print("bejelentkezes|$szov-$szov2");
                              
                                  _channel.sink.add("bejelentkezes|$szov-$szov2");
                              
                                  _channel.stream.listen((message) {
                                  print('Received message: $message');
                              
                                  //if (message.startsWith("True")) {
                                  if (message.startsWith("(True")) {
                                  print("calculateDateDifference INDUL");
                                  int daysDifference = calculateDateDifference(message);
                    
                                  print("calculateDateDifference INDUL");
              
              
                                   daysDifference = calculateDateDifference(message);
                                   if (daysDifference >= 0) {
                                     print('A két dátum között eltelt napok száma: $daysDifference');
                                   } else {
                                     print('Hiba történt a számítás során');
                                   }
                                   print("calculateDateDifference vege");

                                  if (message.startsWith("(True")) {
                                  //if (message.startsWith("True")) {
                                    print("calculateDateDifference INDUL");
                                    int daysDifference = calculateDateDifference(message);

                                    if (daysDifference >= 0) {
                                    print('A két dátum között eltelt napok száma: $daysDifference');

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              //TO DO AZONOSITO ES IDO ALAPJAN MELYIK NYILJON MEG
                                              //ModuleOpening(szov2!,daysDifference), //hipno
                                              ModuleOpening_M3('Azonosito',daysDifference),
                                              //hipnom3_ModuleHipno('Azonosito'),
                                             // ModuleOpening_inter('Azonosito'),
                                              //ModuleOpening_standardcare('Azonosito'),

                                            ),
                                          );

                                    } else {
                                      _showErrorDialog("Hibás dátumformátum");
                                    }
                                  } else {
                                    _showErrorDialog("Hibás bejelentkezési adatok");
                                  }
                                  } else {
                                    _showErrorDialog("Hibás bejelentkezési adatok");
                                  }

                                 });

                                } catch (e) {
                                  _showErrorDialog("Váratlan hiba történt");
                                }


                                print("TODO: Küldes a szerverre");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.lightaccentcolor),
                                // Change the color to your desired color
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
                                      vertical:MediaQuery.of(context).size.width*0.01,
                                      horizontal:
                                      MediaQuery.of(context).size.width*0.01), // Adjust the padding as needed
                                ),
                              ),
                              child: Text(
                                "Bejelentkezés",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.gomb(context),
                              ),
                            ),

                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02,
                            ),
                          Center(child: orDivider(context),
                          ),

                            //Container(width: MediaQuery.of(context).size.width*0.4, height: MediaQuery.of(context).size.width*0.005, color: Colors.black),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02,
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                print("gomb");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Regisztracio(),
                                        //Email_3(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.whitewhite),
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
                                      vertical: MediaQuery.of(context).size.width*0.01,
                                      horizontal:
                                      MediaQuery.of(context).size.width*0.01), // Adjust the padding as needed
                                ), // Change the color to your desired color
                              ),
                              child: Text(
                                "Először jársz itt?",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.szinesgomb(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                Container(
                  color: AppColors.lightaccentcolor,
                  width: MediaQuery.of(context).size.width * 0.3, // The width of the entire container
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start, // Keep items aligned to the top
                    children: [
                      // Bethesda logo stays at the top
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.02, // Added top padding for spacing
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/bethesda_gyermekkorhaz_logo.png",
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005, // Add spacing after the logo
                      ),
                      // The last image now right below the logo
                      Image.asset(
                        "assets/images/nyito_oldal_4_2.png",
                        width: MediaQuery.of(context).size.width * 0.3, // Keep the same width
                        fit: BoxFit.fill, // Maintain fit
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02, // Add space between the image and the text
                      ),
                      Spacer(),

                      // Text section below the image
                      Text(
                        "Üdvözlünk a Bethesda Gyermekkórház Online Fájdalomkezelő weboldalán!",
                        textAlign: TextAlign.center,
                        style: MyTextStyles.feherkovercim(context),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),

                    ],
                  ),
                ),


                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        //title: Text(
                        //  'Bethesda Gyermekkórház Online Fájdalomkezelő',
                        // textAlign: TextAlign.center,
                        // style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),
                        //),
                        subtitle: Text(
                          'A továbblépéshez kérünk, jelentkezz be az e-mail címednek és a korábban megkapott kutatási azonosítódnak a megadásával.',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.nemferde_bekezdes(context),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.03,
                                    0,
                                    0),
                                child: Text(
                                  'E-mail cím:',
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.nagybekezdes(context),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightshade,
                                // Background color of the container
                                border: Border.all(
                                  color: Colors.grey, // Outline color
                                  width: 0.5, // Outline thickness
                                ),
                                // If you also want to have rounded corners, add the borderRadius property
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0),
                                child: TextFormField(
                                  controller: _model.textController1,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    // <-- Set contentPadding to zero
                                    labelText: 'Kattints ide...',
                                    labelStyle:
                                    MyTextStyles.kicsiszinesbekezdes(
                                        context),
                                    //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder:
                                    UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  style:
                                  MyTextStyles.kicsibekezdes(context),
                                  //validator: _model.textController1Validator.asValidator(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.03,
                                    0,
                                    0),
                                child: Text(
                                  'Kutatási azonosító:',
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.nagybekezdes(context),
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightshade,
                                // Background color of the container
                                border: Border.all(
                                  color: Colors.grey, // Outline color
                                  width: 0.5, // Outline thickness
                                ),
                                // If you also want to have rounded corners, add the borderRadius property
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0,
                                    MediaQuery.of(context).size.width *
                                        0.005,
                                    0),
                                child: TextFormField(
                                  controller: _model.textController2,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    // <-- Set contentPadding to zero
                                    labelText: 'Kattints ide...',
                                    labelStyle:
                                    MyTextStyles.kicsiszinesbekezdes(
                                        context),
                                    //hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white30,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder:
                                    UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                  ),
                                  style:
                                  MyTextStyles.kicsibekezdes(context),
                                  //validator: _model.textController1Validator.asValidator(context),
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.05,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {

                                  _channel = WebSocketChannel.connect(
                                    //Uri.parse('wss://prohuman.ddns.net:8889'),
                                    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8889'),
                                  );

                                  String? szov = _model.textController1?.text;
                                  String? szov2 = _model.textController2?.text;
                                  print("bejelentkezes|$szov-$szov2");

                                  _channel.sink.add("bejelentkezes|$szov-$szov2");

                                  _channel.stream.listen((message) {
                                    print('Received message: $message');

                                    //if (message.startsWith("True")) {
                                    if (message.startsWith("(True")) {
                                      print("calculateDateDifference INDUL");
                                      int daysDifference = calculateDateDifference(message);

                                      print("calculateDateDifference INDUL");


                                      daysDifference = calculateDateDifference(message);
                                      if (daysDifference >= 0) {
                                        print('A két dátum között eltelt napok száma: $daysDifference');
                                      } else {
                                        print('Hiba történt a számítás során');
                                      }
                                      print("calculateDateDifference vege");

                                      if (message.startsWith("(True")) {
                                      //if (message.startsWith("True")) {
                                        print("calculateDateDifference INDUL");
                                        int daysDifference = calculateDateDifference(message);

                                        if (daysDifference >= 0) {
                                          print('A két dátum között eltelt napok száma: $daysDifference');

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              //TO DO AZONOSITO ES IDO ALAPJAN MELYIK NYILJON MEG
                                              //ModuleOpening(szov2!,daysDifference), //hipno
                                              ModuleOpening_M3('Azonosito',daysDifference),
                                              //hipnom3_ModuleHipno('Azonosito'),
                                              // ModuleOpening_inter('Azonosito'),
                                              //ModuleOpening_standardcare('Azonosito'),
                                            ),
                                          );

                                        } else {
                                          _showErrorDialog("Hibás dátumformátum");
                                        }
                                      } else {
                                        _showErrorDialog("Hibás bejelentkezési adatok");
                                      }
                                    } else {
                                      _showErrorDialog("Hibás bejelentkezési adatok");
                                    }

                                  });

                                } catch (e) {
                                  _showErrorDialog("Váratlan hiba történt");
                                }


                                print("TODO: Küldes a szerverre");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.lightaccentcolor),
                                // Change the color to your desired color
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
                                      vertical:MediaQuery.of(context).size.width*0.01,
                                      horizontal:
                                      MediaQuery.of(context).size.width*0.01), // Adjust the padding as needed
                                ),
                              ),
                              child: Text(
                                "Bejelentkezés",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.gomb(context),
                              ),
                            ),

                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02,
                            ),
                          Center( child:
                          orDivider(context),
                          ),

                            //Container(width: MediaQuery.of(context).size.width*0.4, height: MediaQuery.of(context).size.width*0.005, color: Colors.black),
                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02,
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                print("gomb");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Regisztracio(),
                                        //Email_3(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    AppColors.whitewhite),
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
                                      vertical: MediaQuery.of(context).size.width*0.01,
                                      horizontal:
                                      MediaQuery.of(context).size.width*0.01), // Adjust the padding as needed
                                ), // Change the color to your desired color
                              ),
                              child: Text(
                                "Először jársz itt?",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.szinesgomb(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Hiba"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
