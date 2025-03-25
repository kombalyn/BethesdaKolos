import 'package:bethesda_2/regisztracio/email_azonosito_2.dart';
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
import '../appbar/appbar.dart';

// Assuming 'main.dart' and 'home_page_model.dart' are correctly set up.

/*class MyTextStyles {
  static final TextStyle myCommonStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    color: AppColors.darkshade,
  );
}*/

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

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
  late WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  int gombnyomva=0;

  String Azonosito = "Az azonosítód látható lesz itt...";
  late HomePageModel _model;
  String? _selectedOption;
  bool _showBigContainer = false;

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    _model.textController3 = TextEditingController();
    _model.textController4 = TextEditingController();
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
      // onTap: () => FocusScope.of(context).unfocus(),
      // child:
      Scaffold(
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
      );
  }

  Widget mobileLayout()
  {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView(
        child: Column(
          children: [

Center (child:
                Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.width * 0.1,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                              Center(
                                child: Text("Készítsük el a profilod", style: MyTextStyles.cim(context)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                              child: Text(
                                                'Kutatásban résztvevő gyermek neve:',
                                                textAlign: TextAlign.center,
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context).size.width * 0.005, 0,
                                                  MediaQuery.of(context).size.width * 0.005, 0),
                                              child: TextFormField(
                                                controller: _model.textController1,
                                                focusNode: _model.textFieldFocusNode1,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  labelText: '...',
                                                  labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  errorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedErrorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                style: MyTextStyles.kicsibekezdes(context),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Kérjük, töltse ki ezt a mezőt';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //EMAIL
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                              child: Text(
                                                'Kutatásban résztvevő gyermek e-mail címe:',
                                                textAlign: TextAlign.center,
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context).size.width * 0.005, 0,
                                                  MediaQuery.of(context).size.width * 0.005, 0),
                                              child: TextFormField(
                                                controller: _model.textController2,
                                                focusNode: _model.textFieldFocusNode1,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  labelText: '...',
                                                  labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  errorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedErrorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                style: MyTextStyles.kicsibekezdes(context),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Kérjük, töltse ki ezt a mezőt';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //DÖNTÉS
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                              child: Text(
                                                'Kutatásban résztvevő szülő neve:',
                                                textAlign: TextAlign.center,
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context).size.width * 0.005, 0,
                                                  MediaQuery.of(context).size.width * 0.005, 0),
                                              child: TextFormField(
                                                controller: _model.textController3,
                                                focusNode: _model.textFieldFocusNode1,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  labelText: '...',
                                                  labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  errorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedErrorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                style: MyTextStyles.kicsibekezdes(context),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Kérjük, töltse ki ezt a mezőt';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //ROKON ADAT
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                              child: Text(
                                                'Kutatásban résztvevő szülő e-mail címe:',
                                                textAlign: TextAlign.center,
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
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  MediaQuery.of(context).size.width * 0.005, 0,
                                                  MediaQuery.of(context).size.width * 0.005, 0),
                                              child: TextFormField(
                                                controller: _model.textController4,
                                                focusNode: _model.textFieldFocusNode1,
                                                autofocus: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  labelText: '...',
                                                  labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  errorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedErrorBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                style: MyTextStyles.kicsibekezdes(context),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Kérjük, töltse ki ezt a mezőt';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                    ElevatedButton(
                                      onPressed: () {
                                        if(gombnyomva==0) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() async {
                                              print("regisztracio most en");
                                              _showBigContainer = true;

                                              String? szov1 = _model
                                                  .textController1?.text;
                                              String? szov2 = _model
                                                  .textController2?.text;
                                              String? szov3 = _model
                                                  .textController3?.text;
                                              String? szov4 = _model
                                                  .textController4?.text;
                                              String? szov5 = _model
                                                  .textController5?.text;
                                              if (szov2 != null &&
                                                  szov2.contains('@')) {
                                                print(
                                                    "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");

                                                _channel =
                                                    WebSocketChannel.connect(
                                                      Uri.parse(
                                                          'wss://szerver.hasifajdalomkezeles.hu:8089'),
                                                    );
                                                _channel.sink.add(
                                                    "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");
                                                final String message = await _channel
                                                    .stream.first;
                                                print(
                                                    'Received message: $message');
                                                setState(() {
                                                  Azonosito = message;
                                                });
                                                /* if (message == "True") {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztrációs Hiba"),
                                                      content: Text(
                                                          "A bevitt adatokkal már regisztráltak. Kérem lépjen be regisztráció helyett a létező fiókjába az email-ben kapott azonosító segítségével."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: Text('OK', style: TextStyle(color: AppColors.bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => HomePageWidget(),
                                                    ),
                                                  );
                                                } else {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztráció Sikeres"),
                                                      content: Text("Regisztrációját sikeresen mentettük."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: Text('OK', style: TextStyle(color: AppColors.bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) => Email_2(),
                                                    ),
                                                  );
                                                } */
                                                //});
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) =>
                                                        Email_2(Azonosito),
                                                  ),
                                                );
                                              } else {
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                            "Regisztrációs Hiba"),
                                                        content: Text(
                                                            "A bevitt email cimek valamelyike hibas."),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'OK'),
                                                            child: Text('OK',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .bethesdacolor)),
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              }


                                              print("regisztracio vege");
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Kérjük, töltse ki az összes mezőt.'),
                                              ),
                                            );
                                          }
                                          setState(() {
                                          gombnyomva=1;
                                          });
                                          print("GOMB BENYOMVA");
                                          }else{
                                          print("UTANAMAR");
                                          }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            AppColors.bethesdacolor),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 24),
                                        ),
                                      ),
                                      child: Text(
                                        "Regisztrálok",
                                        textAlign: TextAlign.center,
                                        style: MyTextStyles.gomb(context),
                                      ),
                                    ),

                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
),

          ],
        ),
      );
  }

   Widget tabletLayout()
   {
     // This is your original layout that will be used for desktop/laptop views
     return

       SingleChildScrollView(
         child: Column(
           children: [

             Center (child:
             Container(
               child: Padding(
                 padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width * 0.1,
                     right: MediaQuery.of(context).size.width * 0.1,
                     top: MediaQuery.of(context).size.width * 0.1,
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
                   child: Form(
                     key: _formKey,
                     child: Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                         Center(
                           child: Text("Készítsük el a profilod", style: MyTextStyles.cim(context)),
                         ),
                         Container(
                           width: MediaQuery.of(context).size.width * 0.35,
                           child: Column(
                             children: [
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.35,
                                 child: Column(
                                   children: [
                                     Align(
                                       alignment: AlignmentDirectional.centerStart,
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                         child: Text(
                                           'Kutatásban résztvevő gyermek neve:',
                                           textAlign: TextAlign.center,
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
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             MediaQuery.of(context).size.width * 0.005, 0,
                                             MediaQuery.of(context).size.width * 0.005, 0),
                                         child: TextFormField(
                                           controller: _model.textController1,
                                           focusNode: _model.textFieldFocusNode1,
                                           autofocus: true,
                                           obscureText: false,
                                           decoration: InputDecoration(
                                             contentPadding: EdgeInsets.zero,
                                             labelText: '...',
                                             labelStyle: MyTextStyles.kicsibekezdes2(context),
                                             enabledBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             errorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedErrorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           style: MyTextStyles.kicsibekezdes(context),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Kérjük, töltse ki ezt a mezőt';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                               //EMAIL
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.35,
                                 child: Column(
                                   children: [
                                     Align(
                                       alignment: AlignmentDirectional.centerStart,
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                         child: Text(
                                           'Kutatásban résztvevő gyermek e-mail címe:',
                                           textAlign: TextAlign.center,
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
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             MediaQuery.of(context).size.width * 0.005, 0,
                                             MediaQuery.of(context).size.width * 0.005, 0),
                                         child: TextFormField(
                                           controller: _model.textController2,
                                           focusNode: _model.textFieldFocusNode1,
                                           autofocus: true,
                                           obscureText: false,
                                           decoration: InputDecoration(
                                             contentPadding: EdgeInsets.zero,
                                             labelText: '...',
                                             labelStyle: MyTextStyles.kicsibekezdes2(context),
                                             enabledBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             errorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedErrorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           style: MyTextStyles.kicsibekezdes(context),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Kérjük, töltse ki ezt a mezőt';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                               //DÖNTÉS
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.35,
                                 child: Column(
                                   children: [
                                     Align(
                                       alignment: AlignmentDirectional.centerStart,
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                         child: Text(
                                           'Kutatásban résztvevő szülő neve:',
                                           textAlign: TextAlign.center,
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
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             MediaQuery.of(context).size.width * 0.005, 0,
                                             MediaQuery.of(context).size.width * 0.005, 0),
                                         child: TextFormField(
                                           controller: _model.textController3,
                                           focusNode: _model.textFieldFocusNode1,
                                           autofocus: true,
                                           obscureText: false,
                                           decoration: InputDecoration(
                                             contentPadding: EdgeInsets.zero,
                                             labelText: '...',
                                             labelStyle: MyTextStyles.kicsibekezdes2(context),
                                             enabledBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             errorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedErrorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           style: MyTextStyles.kicsibekezdes(context),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Kérjük, töltse ki ezt a mezőt';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

                               //ROKON ADAT
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.35,
                                 child: Column(
                                   children: [
                                     Align(
                                       alignment: AlignmentDirectional.centerStart,
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                         child: Text(
                                           'Kutatásban résztvevő szülő e-mail címe:',
                                           textAlign: TextAlign.center,
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
                                       child: Padding(
                                         padding: EdgeInsetsDirectional.fromSTEB(
                                             MediaQuery.of(context).size.width * 0.005, 0,
                                             MediaQuery.of(context).size.width * 0.005, 0),
                                         child: TextFormField(
                                           controller: _model.textController4,
                                           focusNode: _model.textFieldFocusNode1,
                                           autofocus: true,
                                           obscureText: false,
                                           decoration: InputDecoration(
                                             contentPadding: EdgeInsets.zero,
                                             labelText: '...',
                                             labelStyle: MyTextStyles.kicsibekezdes2(context),
                                             enabledBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.white,
                                                 width: 0,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             errorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                             focusedErrorBorder: UnderlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: Colors.red,
                                                 width: 2,
                                               ),
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           style: MyTextStyles.kicsibekezdes(context),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Kérjük, töltse ki ezt a mezőt';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),


                               SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                               ElevatedButton(
                                 onPressed: () {
                                    if(gombnyomva==0) {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() async {
                                          print("regisztracio most en");
                                          _showBigContainer = true;

                                          String? szov1 = _model.textController1
                                              ?.text;
                                          String? szov2 = _model.textController2
                                              ?.text;
                                          String? szov3 = _model.textController3
                                              ?.text;
                                          String? szov4 = _model.textController4
                                              ?.text;
                                          String? szov5 = _model.textController5
                                              ?.text;
                                          if (szov2 != null &&
                                              szov2.contains('@')) {
                                            print(
                                                "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");

                                            _channel = WebSocketChannel.connect(
                                              Uri.parse(
                                                  'wss://szerver.hasifajdalomkezeles.hu:8089'),
                                            );
                                            _channel.sink.add(
                                                "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");
                                            final String message = await _channel
                                                .stream.first;
                                            print('Received message: $message');
                                            setState(() {
                                              Azonosito = message;
                                            });
                                            if (message == "True") {
                                              showDialog<String>(
                                                context: context,
                                                builder: (
                                                    BuildContext context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          "Regisztrációs Hiba"),
                                                      content: Text(
                                                          "A bevitt adatokkal már regisztráltak. Kérem lépjen be regisztráció helyett a létező fiókjába az email-ben kapott azonosító segítségével."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: Text('OK',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) =>
                                                      HomePageWidget(),
                                                ),
                                              );
                                            } else {
                                              showDialog<String>(
                                                context: context,
                                                builder: (
                                                    BuildContext context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          "Regisztráció Sikeres"),
                                                      content: Text(
                                                          "Regisztrációját sikeresen mentettük."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: Text('OK',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) =>
                                                      Email_2(Azonosito),
                                                ),
                                              );
                                            }
                                            //});
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (
                                                    BuildContext context) =>
                                                    Email_2(Azonosito),
                                              ),
                                            );
                                          } else {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        "Regisztrációs Hiba"),
                                                    content: Text(
                                                        "A bevitt email cimek valamelyike hibas."),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: Text('OK',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .bethesdacolor)),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          }

                                          /*Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(
                                           builder: (BuildContext context) => Email_2(),
                                         ),
                                       );

                                        */
                                          print("regisztracio vege");
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Kérjük, töltse ki az összes mezőt.'),
                                          ),
                                        );
                                      }
                                      setState(() {
                                        gombnyomva=1;
                                      });
                                      print("GOMB BENYOMVA");
                                    }else{
                                      print("UTANAMAR");
                                    }
                                 },
                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateProperty.all<Color>(
                                       AppColors.bethesdacolor),
                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                   ),
                                   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                     EdgeInsets.symmetric(
                                         vertical: 12, horizontal: 24),
                                   ),
                                 ),
                                 child: Text(
                                   "Regisztrálok",
                                   textAlign: TextAlign.center,
                                   style: MyTextStyles.gomb(context),
                                 ),
                               ),

                               SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
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
                         child: Form(
                           key: _formKey,
                           child: Column(
                             children: [
                               SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                               Center(
                                 child: Text("Készítsük el a profilod", style: MyTextStyles.cim(context)),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width * 0.35,
                                 child: Column(
                                   children: [
                                     Container(
                                       width: MediaQuery.of(context).size.width * 0.35,
                                       child: Column(
                                         children: [
                                           Align(
                                             alignment: AlignmentDirectional.centerStart,
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                               child: Text(
                                                 'Kutatásban résztvevő gyermek neve:',
                                                 textAlign: TextAlign.center,
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
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   MediaQuery.of(context).size.width * 0.005, 0,
                                                   MediaQuery.of(context).size.width * 0.005, 0),
                                               child: TextFormField(
                                                 controller: _model.textController1,
                                                 focusNode: _model.textFieldFocusNode1,
                                                 autofocus: true,
                                                 obscureText: false,
                                                 decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.zero,
                                                   labelText: '...',
                                                   labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                   enabledBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   errorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedErrorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                 ),
                                                 style: MyTextStyles.kicsibekezdes(context),
                                                 validator: (value) {
                                                   if (value == null || value.isEmpty) {
                                                     return 'Kérjük, töltse ki ezt a mezőt';
                                                   }
                                                   return null;
                                                 },
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),

                                     //EMAIL
                                     Container(
                                       width: MediaQuery.of(context).size.width * 0.35,
                                       child: Column(
                                         children: [
                                           Align(
                                             alignment: AlignmentDirectional.centerStart,
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                               child: Text(
                                                 'Kutatásban résztvevő gyermek e-mail címe:',
                                                 textAlign: TextAlign.center,
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
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   MediaQuery.of(context).size.width * 0.005, 0,
                                                   MediaQuery.of(context).size.width * 0.005, 0),
                                               child: TextFormField(
                                                 controller: _model.textController2,
                                                 focusNode: _model.textFieldFocusNode1,
                                                 autofocus: true,
                                                 obscureText: false,
                                                 decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.zero,
                                                   labelText: '...',
                                                   labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                   enabledBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   errorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedErrorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                 ),
                                                 style: MyTextStyles.kicsibekezdes(context),
                                                 validator: (value) {
                                                   if (value == null || value.isEmpty) {
                                                     return 'Kérjük, töltse ki ezt a mezőt';
                                                   }
                                                   return null;
                                                 },
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),

                                     //DÖNTÉS
                                     Container(
                                       width: MediaQuery.of(context).size.width * 0.35,
                                       child: Column(
                                         children: [
                                           Align(
                                             alignment: AlignmentDirectional.centerStart,
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                               child: Text(
                                                 'Kutatásban résztvevő szülő neve:',
                                                 textAlign: TextAlign.center,
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
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   MediaQuery.of(context).size.width * 0.005, 0,
                                                   MediaQuery.of(context).size.width * 0.005, 0),
                                               child: TextFormField(
                                                 controller: _model.textController3,
                                                 focusNode: _model.textFieldFocusNode1,
                                                 autofocus: true,
                                                 obscureText: false,
                                                 decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.zero,
                                                   labelText: '...',
                                                   labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                   enabledBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   errorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedErrorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                 ),
                                                 style: MyTextStyles.kicsibekezdes(context),
                                                 validator: (value) {
                                                   if (value == null || value.isEmpty) {
                                                     return 'Kérjük, töltse ki ezt a mezőt';
                                                   }
                                                   return null;
                                                 },
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),

                                     //ROKON ADAT
                                     Container(
                                       width: MediaQuery.of(context).size.width * 0.35,
                                       child: Column(
                                         children: [
                                           Align(
                                             alignment: AlignmentDirectional.centerStart,
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   0, MediaQuery.of(context).size.width * 0.03, 0, 0),
                                               child: Text(
                                                 'Kutatásban résztvevő szülő e-mail címe:',
                                                 textAlign: TextAlign.center,
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
                                             child: Padding(
                                               padding: EdgeInsetsDirectional.fromSTEB(
                                                   MediaQuery.of(context).size.width * 0.005, 0,
                                                   MediaQuery.of(context).size.width * 0.005, 0),
                                               child: TextFormField(
                                                 controller: _model.textController4,
                                                 focusNode: _model.textFieldFocusNode1,
                                                 autofocus: true,
                                                 obscureText: false,
                                                 decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.zero,
                                                   labelText: '...',
                                                   labelStyle: MyTextStyles.kicsibekezdes2(context),
                                                   enabledBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.white,
                                                       width: 0,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   errorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   focusedErrorBorder: UnderlineInputBorder(
                                                     borderSide: BorderSide(
                                                       color: Colors.red,
                                                       width: 2,
                                                     ),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                 ),
                                                 style: MyTextStyles.kicsibekezdes(context),
                                                 validator: (value) {
                                                   if (value == null || value.isEmpty) {
                                                     return 'Kérjük, töltse ki ezt a mezőt';
                                                   }
                                                   return null;
                                                 },
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),


                                     SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                     ElevatedButton(
                                       onPressed: () {
                                         if(gombnyomva==0) {
                                           if (_formKey.currentState!
                                               .validate()) {
                                             setState(() async {
                                               print("regisztracio most en");
                                               _showBigContainer = true;

                                               String? szov1 = _model
                                                   .textController1?.text;
                                               String? szov2 = _model
                                                   .textController2?.text;
                                               String? szov3 = _model
                                                   .textController3?.text;
                                               String? szov4 = _model
                                                   .textController4?.text;
                                               String? szov5 = _model
                                                   .textController5?.text;
                                               if (szov2 != null &&
                                                   szov2.contains('@')) {
                                                 print(
                                                     "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");

                                                 _channel =
                                                     WebSocketChannel.connect(
                                                       Uri.parse(
                                                           'wss://szerver.hasifajdalomkezeles.hu:8089'),
                                                     );
                                                 print("email $szov3");
                                                 _channel.sink.add(
                                                     "regisztracio|$szov2-$szov1,$szov3,$_selectedOption,$szov4,$szov5");
                                                 final String message = await _channel
                                                     .stream.first;
                                                 print(message);
                                                 setState(() {
                                                   Azonosito = message;
                                                 });
                                                 print('Received message: $message');
                                                 if (message == "mar_van_ilyen_regisztralva") {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztrációs Hiba"),
                                                      content: Text(
                                                          "A bevitt adatokkal már regisztráltak. Kérem lépjen be regisztráció helyett a létező fiókjába az email-ben kapott azonosító segítségével."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: Text('OK', style: TextStyle(color: AppColors.bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                                  );

                                                } else {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: Text("Regisztráció Sikeres"),
                                                      content: Text("Regisztrációját sikeresen mentettük."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: Text('OK', style: TextStyle(color: AppColors.bethesdacolor)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) =>
                                                          Email_2(Azonosito),
                                                    ),
                                                  );
                                                }
                                                 //});

                                               } else {
                                                 showDialog<String>(
                                                   context: context,
                                                   builder: (
                                                       BuildContext context) =>
                                                       AlertDialog(
                                                         title: Text(
                                                             "Regisztrációs Hiba"),
                                                         content: Text(
                                                             "A bevitt email cimek valamelyike hibas."),
                                                         actions: <Widget>[
                                                           TextButton(
                                                             onPressed: () =>
                                                                 Navigator.pop(
                                                                     context,
                                                                     'OK'),
                                                             child: Text('OK',
                                                                 style: TextStyle(
                                                                     color: AppColors
                                                                         .bethesdacolor)),
                                                           ),
                                                         ],
                                                       ),
                                                 );
                                               }


                                               print("regisztracio vege");
                                             });
                                           } else {
                                             ScaffoldMessenger.of(context)
                                                 .showSnackBar(
                                               SnackBar(
                                                 content: Text(
                                                     'Kérjük, töltse ki az összes mezőt.'),
                                               ),
                                             );
                                           }
                                           setState(() {
                                             gombnyomva=1;
                                           });
                                           print("GOMB BENYOMVA");
                                         }else{
                                           print("UTANAMAR");
                                         }
                                       },
                                       style: ButtonStyle(
                                         backgroundColor: MaterialStateProperty.all<Color>(
                                             AppColors.bethesdacolor),
                                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                           RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(10),
                                           ),
                                         ),
                                         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                           EdgeInsets.symmetric(
                                               vertical: 12, horizontal: 24),
                                         ),
                                       ),
                                       child: Text(
                                         "Regisztrálok",
                                         textAlign: TextAlign.center,
                                         style: MyTextStyles.gomb(context),
                                       ),
                                     ),

                                     SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                   ],
                                 ),
                               ),
                             ],
                           ),
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
