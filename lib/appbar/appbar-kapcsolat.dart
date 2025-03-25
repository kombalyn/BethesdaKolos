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
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Padding(
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
              Center( child:
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
                        vertical: 12, horizontal: 24),
                  ),
                ),
                child: Text(
                  'Üzenet küldése',
                  style: MyTextStyles.gomb(context),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}


class appbar_kapcsolat extends StatelessWidget {
  const appbar_kapcsolat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés kapcsolat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
        cardTheme: CardTheme(
          color: AppColors.whitewhite,
        ),
      ),
      home: const Appbar_kapcsolat(),
    );
  }
}

class Appbar_kapcsolat extends StatefulWidget {
  const Appbar_kapcsolat({Key? key}) : super(key: key);

  @override
  State<Appbar_kapcsolat> createState() => _Appbar_kapcsolatState();
}

class _Appbar_kapcsolatState extends State<Appbar_kapcsolat>
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
    // This is your original layout that will be used for desktop/laptop views
    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Contact form at the top
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.width * 0.02,
                MediaQuery.of(context).size.width * 0.05,
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
                    "Kapcsolat",
                    textAlign: TextAlign.center,
                    style: MyTextStyles.bethesdavastagbekezdes(context),
                  ),
                ),
              ),
            ),

            // Contact Form section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
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
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                      Center(
                        child: ContactForm(),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_bethesda.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('Fájdalomcentrum', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'Magyarországi Református Egyház \n Bethesda Gyermekkórháza',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1146 Budapest, Bethesda utca 3. (Zugló)', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      // Second information card (ELTE PPK)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_elte.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('ELTE PPK', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'Eötvös Loránd Tudományegyetem \n Pedagógiai és Pszichológiai Kar',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1075 Budapest, Kazinczy utca 23-27.', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      // Third information card (HUN-REN SZTAKI)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_sztaki.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('HUN-REN SZTAKI', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'HUN-REN Számítástechnikai és \n Automatizálási Kutatóintézet',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1111 Budapest, Kende utca 13-17.', textAlign: TextAlign.center),
                            ),
                            SizedBox(                    height: MediaQuery.of(context).size.width * 0.1,)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            // First information card (Fájdalomcentrum)

          ],
        ),
      ),
    );
  }


  Widget tabletLayout(){
    // This is your original layout that will be used for desktop/laptop views
    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Contact form at the top
            Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.width * 0.02,
                MediaQuery.of(context).size.width * 0.05,
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
                    "Kapcsolat",
                    textAlign: TextAlign.center,
                    style: MyTextStyles.bethesdavastagbekezdes(context),
                  ),
                ),
              ),
            ),

            // Contact Form section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
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
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                      Center(
                        child: ContactForm(),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_bethesda.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('Fájdalomcentrum', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'Magyarországi Református Egyház \n Bethesda Gyermekkórháza',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1146 Budapest, Bethesda utca 3. (Zugló)', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      // Second information card (ELTE PPK)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_elte.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('ELTE PPK', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'Eötvös Loránd Tudományegyetem \n Pedagógiai és Pszichológiai Kar',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1075 Budapest, Kazinczy utca 23-27.', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),

                      // Third information card (HUN-REN SZTAKI)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset('assets/images/logo_sztaki.png', fit: BoxFit.contain),
                            ),
                            Center(
                              child: Text('HUN-REN SZTAKI', style: MyTextStyles.bethesdabekezdes(context)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Center(
                              child: Text(
                                'HUN-REN Számítástechnikai és \n Automatizálási Kutatóintézet',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Center(
                              child: Text('1111 Budapest, Kende utca 13-17.', textAlign: TextAlign.center),
                            ),
                            SizedBox(                    height: MediaQuery.of(context).size.width * 0.1,)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            // First information card (Fájdalomcentrum)

          ],
        ),
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
                              MediaQuery.of(context).size.width * 0.05,
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
                                "Kapcsolat",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.bethesdavastagbekezdes(context),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right:
                              MediaQuery.of(context).size.width * 0.03),
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
                                      0.03,
                                  right: MediaQuery.of(context).size.width *
                                      0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.01),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.1, // Set desired width
                                                  height: MediaQuery.of(context).size.width*0.1, // Set desired height
                                                  child: Image.asset(
                                                    'assets/images/logo_bethesda.png',
                                                    fit: BoxFit.contain, // Ensures the image scales down or up while maintaining its aspect ratio
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  'Fájdalomcentrum',
                                                  style: MyTextStyles.bethesdabekezdes(context),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                              Center(
                                                child: Text(
                                                  'Magyarországi Református Egyház \n Bethesda Gyermekkórháza',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Center(
                                                child: Text(
                                                  '1146 Budapest, Bethesda utca 3. (Zugló)',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.1, // Set desired width
                                                  height: MediaQuery.of(context).size.width*0.1, // Set desired height
                                                  child: Image.asset(
                                                    'assets/images/logo_elte.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  'ELTE PPK',
                                                  style: MyTextStyles.bethesdabekezdes(context),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                              Center(
                                                child: Text(
                                                  'Eötvös Loránd Tudományegyetem \n Pedagógiai és Pszichológiai Kar',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Center(
                                                child: Text(
                                                  '1075 Budapest, Kazinczy utca 23-27.',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.1, // Set desired width
                                                  height: MediaQuery.of(context).size.width*0.1, // Set desired height
                                                  child: Image.asset(
                                                    'assets/images/logo_sztaki.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  'HUN-REN SZTAKI',
                                                  style: MyTextStyles.bethesdabekezdes(context),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                              Center(
                                                child: Text(
                                                  'HUN-REN Számítástechnikai és \n Automatizálási Kutatóintézet',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Center(
                                                child: Text(
                                                  '1111 Budapest, Kende utca 13-17.',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[



                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.04),
                                      Center(
                                        child: ContactForm(),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: MediaQuery.of(context).size.width * 0.03),

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),

                                        ],
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

