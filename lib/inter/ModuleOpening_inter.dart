import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

export '../home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import '../appbar/appbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool _isPressed = false;

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
            padding: EdgeInsetsDirectional.fromSTEB(0, MediaQuery.of(context).size.width*0.01, 0, 0), // Reduced top padding
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
                  vertical: isMessage ? MediaQuery.of(context).size.width*0.01 : MediaQuery.of(context).size.width*0.008, horizontal: MediaQuery.of(context).size.width*0.01,), // Reduced padding inside the fields
              labelText: 'Kattints ide...',
              labelStyle: MyTextStyles.kicsislightbekezdes(context),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightaccentcolor, width: 1),
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
            keyboardType: isMessage ? TextInputType.multiline : TextInputType.text,
            maxLines: isMessage ? null : 1,
            minLines: isMessage ? 4 : 1, // Adjusted minimum lines for message field
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
      elevation: 3, // Reduced elevation for a smaller shadow
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01, vertical: MediaQuery.of(context).size.width*0.01,), // Reduced margin for a more compact layout
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01), // Reduced padding inside the Card
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Adjusted width to make the form narrower
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Itt küldj nekünk üzenetet!',
                style: MyTextStyles.lightbekezdes(context),
              ),
              formField('Név:', nameController),
              formField('Email cím, amire küldhetjük a választ:', emailController),
              formField('Üzenet:', messageController, isMessage: true),
              SizedBox(height: MediaQuery.of(context).size.width*0.02),
              ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    sendEmail(nameController.text, emailController.text, messageController.text);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return AppColors.lightaccentcolor;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.01,), // Adjusted the border radius for a more compact look
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.01,
                        horizontal: MediaQuery.of(context).size.width*0.02
                    ), // Reduced padding for a smaller button
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

class ModuleOpening_inter extends StatelessWidget {
  String Azonosito = '';
  ModuleOpening_inter(String s, {super.key}){Azonosito=s;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bethesdacolor),
        useMaterial3: false,
      ),
      home: ModuleOpeningWidget_inter(Azonosito),
    );
  }
}

class ModuleOpeningWidget_inter extends StatefulWidget {
  String Azonosito = '';
  ModuleOpeningWidget_inter(String azonosito, {super.key}){Azonosito=azonosito;}

  @override
  State<ModuleOpeningWidget_inter> createState() => _ModuleOpeningWidgetState_inter(Azonosito);
}

class _ModuleOpeningWidgetState_inter extends State<ModuleOpeningWidget_inter> {
  late HomePageModel _model;
  bool _isPlaying = false;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleOpeningWidgetState_inter(String azonosito){Azonosito=azonosito;}

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Kutatási fázis',
        backgroundColor: AppColors.lightaccentcolor, // Optional: Override the default background color
        iconColor: AppColors.lightaccentcolor,
      ),
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
    return  SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: MediaQuery.of(context).size.width*0.04), // Adjust the padding values as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align all text to the left
              children: [
                Text(
                  'Üdvözlünk a Kutatásban!',
                  textAlign: TextAlign.justify,
                  style: MyTextStyles.szinesgomb(context),
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                Text(
                  'Örömmel köszöntünk a programban, ahol különleges interdiszciplináris multimodális terápiában vehetsz részt. Ezen a találkozón személyesen találkozhatsz több szakemberrel (többek között orvossal, klinikai szakpszichológussal, gyógytornásszal), hogy közösen dolgozzunk a legjobb megoldásokon a számodra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                Text(
                  'Kérjük, hogy az alkalomra ne csak te, hanem az egész családod is kísérjen el, hiszen a teljes körű támogatás kiemelten fontos számunkra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                Text(
                  'A részvételhez és időpontfoglaláshoz kérjük, töltsd ki az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                // Place the ContactForm next to the closing message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start (left)
                  children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Várjuk a jelentkezésedet!',
                            style: MyTextStyles.lightbekezdes(context),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width*0.02),
                          Text(
                            'Üdvözlettel,\nA kutatócsapat',
                            style: MyTextStyles.lightbekezdes(context),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),

                    SizedBox(height: MediaQuery.of(context).size.width*0.02),

                    // Add the ContactForm below the text
                    Center( child:                    ContactForm(),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.width*0.02),

                // Place the image in a new row below the form and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/dokik.png', // Replace with your actual image path
                        fit: BoxFit.contain, // Adjust how the image fits within its container
                      ),
                    ),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }


  Widget tabletLayout(){
    // This is your original layout that will be used for desktop/laptop views
    return  SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: MediaQuery.of(context).size.width*0.04), // Adjust the padding values as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align all text to the left
              children: [
                Text(
                  'Üdvözlünk a Kutatásban!',
                  textAlign: TextAlign.justify,
                  style: MyTextStyles.szinesgomb(context),
                ),
                SizedBox(height: 16.0), // Space between paragraphs

                Text(
                  'Örömmel köszöntünk a programban, ahol különleges interdiszciplináris multimodális terápiában vehetsz részt. Ezen a találkozón személyesen találkozhatsz több szakemberrel (többek között orvossal, klinikai szakpszichológussal, gyógytornásszal), hogy közösen dolgozzunk a legjobb megoldásokon a számodra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                Text(
                  'Kérjük, hogy az alkalomra ne csak te, hanem az egész családod is kísérjen el, hiszen a teljes körű támogatás kiemelten fontos számunkra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                Text(
                  'A részvételhez és időpontfoglaláshoz kérjük, töltsd ki az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                // Place the ContactForm next to the closing message
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2, // Adjust the flex value for the text block
                      child: Padding(
                        padding: EdgeInsets.only(top: 18.0), // Adjust this value to control how far down the text starts
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Várjuk a jelentkezésedet!',
                              style: MyTextStyles.lightbekezdes(context),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 16.0), // Adjust spacing between text blocks
                            Text(
                              'Üdvözlettel,\nA kutatócsapat',
                              style: MyTextStyles.lightbekezdes(context),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Space between the ContactForm and the text

                    Expanded(
                      flex: 4, // Adjust the flex value to control the proportion of space
                      child: ContactForm(),
                    ),
                  ],
                ),

                SizedBox(height: 16.0), // Space between the form row and the image

                // Place the image in a new row below the form and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/dokik.png', // Replace with your actual image path
                        fit: BoxFit.contain, // Adjust how the image fits within its container
                      ),
                    ),
                  ],
                ),
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
    return  SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1, vertical: MediaQuery.of(context).size.width*0.04), // Adjust the padding values as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align all text to the left
              children: [
                Text(
                  'Üdvözlünk a Kutatásban!',
                  textAlign: TextAlign.justify,
                  style: MyTextStyles.szinesgomb(context),
                ),
                SizedBox(height: 16.0), // Space between paragraphs

                Text(
                  'Örömmel köszöntünk a programban, ahol különleges interdiszciplináris multimodális terápiában vehetsz részt. Ezen a találkozón személyesen találkozhatsz több szakemberrel (többek között orvossal, klinikai szakpszichológussal, gyógytornásszal), hogy közösen dolgozzunk a legjobb megoldásokon a számodra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                Text(
                  'Kérjük, hogy az alkalomra ne csak te, hanem az egész családod is kísérjen el, hiszen a teljes körű támogatás kiemelten fontos számunkra.',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                Text(
                  'A részvételhez és időpontfoglaláshoz kérjük, töltsd ki az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!',
                  style: MyTextStyles.nemferde_bekezdes(context),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16.0),

                // Place the ContactForm next to the closing message
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2, // Adjust the flex value for the text block
                      child: Padding(
                        padding: EdgeInsets.only(top: 18.0), // Adjust this value to control how far down the text starts
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Várjuk a jelentkezésedet!',
                              style: MyTextStyles.lightbekezdes(context),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 16.0), // Adjust spacing between text blocks
                            Text(
                              'Üdvözlettel,\nA kutatócsapat',
                              style: MyTextStyles.lightbekezdes(context),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Space between the ContactForm and the text

                    Expanded(
                      flex: 4, // Adjust the flex value to control the proportion of space
                      child: ContactForm(),
                    ),
                  ],
                ),

                SizedBox(height: 16.0), // Space between the form row and the image

                // Place the image in a new row below the form and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/dokik.png', // Replace with your actual image path
                        fit: BoxFit.contain, // Adjust how the image fits within its container
                      ),
                    ),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}



