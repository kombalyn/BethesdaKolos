import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'ModuleOpening_standardcare.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

export '../home_page_model.dart';
import '../appbar/appbar.dart';

class ModuleStandard_5het extends StatelessWidget {
  String Azonosito = '';
  ModuleStandard_5het(String s, {super.key}){Azonosito=s;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: false,
      ),
      home:  ModuleStandard_5het_widget(Azonosito),
    );
  }
}

class ModuleStandard_5het_widget extends StatefulWidget {
  String Azonosito = '';
  ModuleStandard_5het_widget(String azonosito, {super.key}){Azonosito=azonosito;}

  @override
  State<ModuleStandard_5het_widget> createState() => _ModuleStandard_5het_widget(Azonosito);
}

class _ModuleStandard_5het_widget extends State<ModuleStandard_5het_widget> {
  late HomePageModel _model;
  late AnimationController _animationController;
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleStandard_5het_widget(String azonosito){Azonosito=azonosito;}

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
        child:  SidebarLayout(
          iconSuffix: '_b',  // Here you pass the suffix you want

          weekScreens: {
            '2-4.hét': {
              'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
              'isClickable': false,
            },
            '5.hét': {
              'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
              'isClickable': true,
            },
            '6-11.hét': {
              'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
              'isClickable': false,
            },
            '12.hét': {
              'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
              'isClickable': false,
            },
          },                selectedWeek: '5.hét', // Specify which week is selected
          weekTextStyles: {
            '5.hét': MyTextStyles.vastagblue(context),  // Style for '1.hét'
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

  Widget mobileLayout(){
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
                                "Köszönjük, hogy időt szántál a kérdőív kitöltésére, és hogy megosztottad velünk tapasztalataidat! Várunk vissza egy hét múlva!",
                                style: MyTextStyles.bekezdes(context),
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


  Widget tabletLayout() {
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
                                "Köszönjük, hogy időt szántál a kérdőív kitöltésére, és hogy megosztottad velünk tapasztalataidat! Várunk vissza egy hét múlva!",
                                style: MyTextStyles.bekezdes(context),
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
                                "Köszönjük, hogy időt szántál a kérdőív kitöltésére, és hogy megosztottad velünk tapasztalataidat! Várunk vissza egy hét múlva!",
                                style: MyTextStyles.bekezdes(context),
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
                  '2-4.hét': {
                    'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
                    'isClickable': false,
                  },
                  '5.hét': {
                    'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
                    'isClickable': true,
                  },
                  '6-11.hét': {
                    'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
                    'isClickable': false,
                  },
                  '12.hét': {
                    'screenBuilder': (context) => ModuleStandard_5het('Azonosito'),
                    'isClickable': false,
                  },
                },                selectedWeek: '5.hét', // Specify which week is selected
                weekTextStyles: {
                  '5.hét': MyTextStyles.vastagblue(context),  // Style for '1.hét'
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
