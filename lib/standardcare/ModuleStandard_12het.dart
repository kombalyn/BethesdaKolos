import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'ModuleOpening_standardcare.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
export '../home_page_model.dart';
import '../appbar/appbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

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
              labelStyle: MyTextStyles.kicsisbluebekezdes(context),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: AppColors.blue, width: 1),
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
                style: MyTextStyles.bluebekezdes(context),
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
                      return AppColors.blue;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleStandard_12het extends StatelessWidget {
  String Azonosito = '';
  ModuleStandard_12het(String s, {super.key}){Azonosito=s;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: false,
      ),
      home:  ModuleStandard_12het_widget(Azonosito),
    );
  }
}

class ModuleStandard_12het_widget extends StatefulWidget {
  String Azonosito = '';
  ModuleStandard_12het_widget(String azonosito, {super.key}){Azonosito=azonosito;}

  @override
  State<ModuleStandard_12het_widget> createState() => _ModuleStandard_12het_widget(Azonosito);
}

class _ModuleStandard_12het_widget extends State<ModuleStandard_12het_widget> {
  late HomePageModel _model;
  late AnimationController _animationController;
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleStandard_12het_widget(String azonosito){Azonosito=azonosito;}

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
      appBar:  CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.blue, // Optional: Override the default background color
        iconColor: AppColors.blue,),
      drawer: Drawer(
        child:
        SidebarLayout(
          iconSuffix: '_b',  // Here you pass the suffix you want
          weekScreens: {
            '2-11.hét': {
              'screenBuilder': (context) => ModuleStandard_12het('Azonosito'),
              'isClickable': false,
            },

            '12.hét': {
              'screenBuilder': (context) => ModuleStandard_12het('Azonosito'),
              'isClickable': true,
            },
          },
          selectedWeek: '12.hét', // Specify which week is selected
          weekTextStyles: {
            '12.hét': MyTextStyles.vastagblue(context),  // Style for '1.hét'
            //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
            // Add other weeks as needed with their respective styles
          },
          rectangleColor: AppColors.blue, // You can change this color to any other color
        ),
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

  Widget mobileLayout()  {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView( child:
      Column(
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
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    // Indentation for the rows
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05),

                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style:
                                  MyTextStyles.bethesdagomb_kek(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Örülünk, hogy újra itt vagy velünk a kutatásban! Nagyszerű látni, hogy folytatod a részvételt. Az elkövetkező 3 hónapban is fontos, hogy kövesd az orvosod utasításait, hiszen ezek kulcsfontosságúak lehetnek a további javulásod érdekében.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Kérjük, válaszolj az alábbi kérdésekre:",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Az orvosodtól kapott javaslatok közül melyikeket alkalmaztad az elmúlt 1 hétben?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

// Add the TextField for user input
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Milyen más módon kezdted el Te magad a problémád kezelését? Próbáltál esetleg olyasmit is, amit nem a gasztroenterológus javasolt?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

                        //IDE BEÍRÓS
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha a program ellenére még mindig tapasztalsz fájdalmat vagy kellemetlenséget, kérünk, jelezd ezt felénk. Ahogy a kutatás elején is írtuk, lehetőséged van egy személyes konzultációra a Bethesda Gyermekkórház Fájdalomkezelő Centrumában.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha szeretnél élni ezzel a lehetőséggel, kérünk az időpontfoglaláshoz írj nekünk egy levelet az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
//levelező ide
                        Center(child: ContactForm()),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Köszönjük, hogy részt vettél a kutatásban!\n Üdvözlettel:\n A kutatócsoport",
                                style: MyTextStyles.bethesdagomb_kek(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // Adjust the radius as needed
                                  child: Image.asset(
                                      "assets/images/nyitokep_2.jpeg"),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // You can add more rows as needed
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 0, // Position it at the top
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.02, // Align it to the left corner
                child: SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.menu, color: AppColors.blueish),
                    onPressed: () {
                      scaffoldKey.currentState
                          ?.openDrawer(); // Open the drawer (sidebar)
                    },
                  ),
                ),
              ),
            ],
          ),
          // ide kell záró
        ],
      ),
      );
  }


  Widget tabletLayout()  {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView( child:
      Column(
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
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    // Indentation for the rows
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05),

                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style:
                                  MyTextStyles.bethesdagomb_kek(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Örülünk, hogy újra itt vagy velünk a kutatásban! Nagyszerű látni, hogy folytatod a részvételt. Az elkövetkező 3 hónapban is fontos, hogy kövesd az orvosod utasításait, hiszen ezek kulcsfontosságúak lehetnek a további javulásod érdekében.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Kérjük, válaszolj az alábbi kérdésekre:",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Az orvosodtól kapott javaslatok közül melyikeket alkalmaztad az elmúlt 1 hétben?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

// Add the TextField for user input
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Milyen más módon kezdted el Te magad a problémád kezelését? Próbáltál esetleg olyasmit is, amit nem a gasztroenterológus javasolt?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

                        //IDE BEÍRÓS
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha a program ellenére még mindig tapasztalsz fájdalmat vagy kellemetlenséget, kérünk, jelezd ezt felénk. Ahogy a kutatás elején is írtuk, lehetőséged van egy személyes konzultációra a Bethesda Gyermekkórház Fájdalomkezelő Centrumában.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha szeretnél élni ezzel a lehetőséggel, kérünk az időpontfoglaláshoz írj nekünk egy levelet az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
//levelező ide
                        Center(child: ContactForm()),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Köszönjük, hogy részt vettél a kutatásban!\n Üdvözlettel:\n A kutatócsoport",
                                style: MyTextStyles.bethesdagomb_kek(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // Adjust the radius as needed
                                  child: Image.asset(
                                      "assets/images/nyitokep_2.jpeg"),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // You can add more rows as needed
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 0, // Position it at the top
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.02, // Align it to the left corner
                child: SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.menu, color: AppColors.blueish),
                    onPressed: () {
                      scaffoldKey.currentState
                          ?.openDrawer(); // Open the drawer (sidebar)
                    },
                  ),
                ),
              ),
            ],
          ),
          // ide kell záró
        ],
      ),
      );
  }


  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return

      SingleChildScrollView( child:
      Column(
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
                            height: MediaQuery.of(context).size.width * 0.05),

                        Row(
                          children: [
                            Expanded(
                              // This will allow text to wrap within the row.
                              child: Text("Szia!",
                                  style:
                                  MyTextStyles.bethesdagomb_kek(context)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Örülünk, hogy újra itt vagy velünk a kutatásban! Nagyszerű látni, hogy folytatod a részvételt. Az elkövetkező 3 hónapban is fontos, hogy kövesd az orvosod utasításait, hiszen ezek kulcsfontosságúak lehetnek a további javulásod érdekében.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Kérjük, válaszolj az alábbi kérdésekre:",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Az orvosodtól kapott javaslatok közül melyikeket alkalmaztad az elmúlt 1 hétben?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

// Add the TextField for user input
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Milyen más módon kezdted el Te magad a problémád kezelését? Próbáltál esetleg olyasmit is, amit nem a gasztroenterológus javasolt?",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),

                        //IDE BEÍRÓS
                        TextField(
                          controller: TextEditingController(), // You can use a separate controller for accessing the input value
                          decoration: InputDecoration(
                            hintText: 'Írd ide a válaszod...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          maxLines: 2, // Allows multiline input if needed
                          style: MyTextStyles.bekezdes(context), // Adjust text style as needed
                        ),

                        SizedBox(height: 16.0), // Space between TextField and the button

// Add the submission button
                        ElevatedButton(
                          onPressed: () {
                            // Add your submission logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue, // Change to your desired color
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Küldés',
                            style: MyTextStyles.gomb(context),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha a program ellenére még mindig tapasztalsz fájdalmat vagy kellemetlenséget, kérünk, jelezd ezt felénk. Ahogy a kutatás elején is írtuk, lehetőséged van egy személyes konzultációra a Bethesda Gyermekkórház Fájdalomkezelő Centrumában.",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Ha szeretnél élni ezzel a lehetőséggel, kérünk az időpontfoglaláshoz írj nekünk egy levelet az alábbi szövegdobozba! Küldd el nekünk a nevedet, valamint az egyik vagy mindkét szülőd nevét és e-mail címét. Mi pedig hamarosan felvesszük veletek a kapcsolatot!",
                                style: MyTextStyles.bekezdes(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
//levelező ide
                        Center(child: ContactForm()),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          children: [
                            Expanded(
                              // This ensures the text fits within the available space and wraps.
                              child: Text(
                                "Köszönjük, hogy részt vettél a kutatásban!\n Üdvözlettel:\n A kutatócsoport",
                                style: MyTextStyles.bethesdagomb_kek(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // Adjust the radius as needed
                                  child: Image.asset(
                                      "assets/images/nyitokep_2.jpeg"),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // You can add more rows as needed
                      ],
                    ),
                  ),
                ],
              ),


              SidebarLayout(
                iconSuffix: '_b',  // Here you pass the suffix you want
                weekScreens: {
                  '2-11.hét': {
                    'screenBuilder': (context) => ModuleStandard_12het('Azonosito'),
                    'isClickable': false,
                  },

                  '12.hét': {
                    'screenBuilder': (context) => ModuleStandard_12het('Azonosito'),
                    'isClickable': true,
                  },
                },
                selectedWeek: '12.hét', // Specify which week is selected
                weekTextStyles: {
                  '12.hét': MyTextStyles.vastagblue(context),  // Style for '1.hét'
                  //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
                  // Add other weeks as needed with their respective styles
                },
                rectangleColor: AppColors.blue, // You can change this color to any other color
              ),
            ],
          ),
          // ide kell záró
        ],
      ),
    );
  }
}
