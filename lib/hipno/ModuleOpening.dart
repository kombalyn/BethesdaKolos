import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'ModuleHipno_page2.dart';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

import 'ModuleHipno_page3.dart';
import 'ModuleHipnomp3_1.dart';
import 'ModuleHipno_page5.dart';
import 'ModuleHipno_page4.dart';
import 'ModuleHipno.dart';
export '../home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import '../appbar/appbar.dart';

class ModuleOpening extends StatelessWidget {
  String Azonosito = '';
  ModuleOpening(String s, int daysDifference, {super.key}){Azonosito=s;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés - hipnózis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueish),
        useMaterial3: false,
      ),
      home:  ModuleOpeningWidget(Azonosito),
    );
  }
}

class ModuleOpeningWidget extends StatefulWidget {
  String Azonosito = '';
  ModuleOpeningWidget(String azonosito, {super.key}){Azonosito=azonosito;}

  @override
  State<ModuleOpeningWidget> createState() => _ModuleOpeningWidgetState(Azonosito);
}

class _ModuleOpeningWidgetState extends State<ModuleOpeningWidget> {
  late HomePageModel _model;
  bool _isPlaying = false;
  late AnimationController _animationController;
  late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  _ModuleOpeningWidgetState(String azonosito){Azonosito=azonosito;}

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    print("MASH " + Azonosito);

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
      appBar:  CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.blueish, // Optional: Override the default background color
        iconColor: AppColors.blueish,
      ),
      drawer: Drawer(
        child: SidebarLayout(
          iconSuffix: '_l',  // Here you pass the suffix you want
          weekScreens: {
            '1-2.hét': {
              'screenBuilder': (context) => ModuleHipno("$Azonosito"),
              'isClickable': true,
            },
            '3-4.hét': {
              'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
              'isClickable': true,
            },
            '5-6.hét': {
              'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
              'isClickable': true,
            },
            '7-8.hét': {
              'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
              'isClickable': true,
            },
            '9-12.hét': {
              'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
              'isClickable': true,
            },
          },
          selectedWeek: '1.hét', // Specify which week is selected
          weekTextStyles: {
            '1.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
          },
          rectangleColor: AppColors.blueish, // Change this color to any desired color
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


  Widget mobileLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return
      Stack(children: [
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
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73, // 73% of the screen width
                              height: MediaQuery.of(context).size.width * 0.4,  // Increase height proportionately
                              //ádám: MJ_köszöntö.mp4
                              child: HtmlWidget(
                                '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_k%C3%B6sz%C3%B6nt%C3%B6.mp4" ></video>',
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                          Row(
                            children: [
                              Expanded(
                                // This will allow text to wrap within the row.
                                child: Text("Szia!",
                                    style:
                                    MyTextStyles.bethesdagomb_lila(context)),
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
                                  "Ezen a honlapon tudod meghallgatni a hipnózis gyakorlatokat és segít abban is, hogy hol és mikor végezd őket. A legtöbb gyerek nagyon szereti hallgatni ezeket a gyakorlatokat és azt tapasztalja, hogy jót tesznek a pocakjának is.",
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
                                  "Öt olyan hipnózis gyakorlatot találsz itt a hetek során, melyek hasfájással küzdő általános iskolás és gimnazista tizenévesek számára készültek. Ez a honlap segít abban, hogy milyen sorrendben, mikor és hogyan használd őket.",
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
                                  "Reméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.04),
                          Container(
                            /*decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.blueish,
                          border:
                              Border.all(color: AppColors.whitewhite, width: 4),
                        ),*/
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the radius as needed
                                    child: Image.asset(
                                        "assets/images/nyitokep_2.jpeg"),
                                  ),
                                ),

                                Positioned(
                                  top: 0,//MediaQuery.of(context).size.width * 0.001,
                                  right: MediaQuery.of(context).size.width * 0.04,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ModuleHipno('XY978'),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        AppColors.whitewhite,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                      ),
                                    ),
                                    child: Text(
                                      "Kezdjük!",
                                      style: MyTextStyles.bethesdagomb_lila(context),
                                    ),
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


                /*
                // Front Layer with Clickable parts
                SidebarLayout(
                  weekScreens: {
                    '1-2.hét': {
                      'screenBuilder': (context) => ModuleHipno("$Azonosito"),
                      'isClickable': true,
                    },
                    '3-4.hét': {
                      'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
                      'isClickable': true,
                    },
                    '5-6.hét': {
                      'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
                      'isClickable': true,
                    },
                    '7-8.hét': {
                      'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
                      'isClickable': true,
                    },
                    '9-12.hét': {
                      'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
                      'isClickable': true,
                    },

                  },
                  selectedWeek: '1.hét', // Specify which week is selected
                  weekTextStyles: {
                    '1.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
                    //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
                    // Add other weeks as needed with their respective styles
                  },
                  rectangleColor: AppColors.blueish, // You can change this color to any other color

                ),
                */



                Positioned(
                  top: 0, // Position it at the top
                  left: MediaQuery.of(context).size.width*0.02, // Align it to the left corner
                  child: SafeArea(
                    child: IconButton(
                      icon: Icon(Icons.menu, color: AppColors.blueish),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer(); // Open the drawer (sidebar)
                      },
                    ),
                  ),
                ),

              ],
            ),
            // ide kell záró
          ],
        ),
        ),

      ],

        //ideee
      );
  }


  Widget tabletLayout(){
    // This is your original layout that will be used for desktop/laptop views
    return
      Stack(children: [
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
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73, // 73% of the screen width
                              height: MediaQuery.of(context).size.width * 0.4,  // Increase height proportionately
                              //ádám: MJ_köszöntö.mp4
                              child: HtmlWidget(
                                '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_k%C3%B6sz%C3%B6nt%C3%B6.mp4" ></video>',
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                          Row(
                            children: [
                              Expanded(
                                // This will allow text to wrap within the row.
                                child: Text("Szia!",
                                    style:
                                    MyTextStyles.bethesdagomb_lila(context)),
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
                                  "Ezen a honlapon tudod meghallgatni a hipnózis gyakorlatokat és segít abban is, hogy hol és mikor végezd őket. A legtöbb gyerek nagyon szereti hallgatni ezeket a gyakorlatokat és azt tapasztalja, hogy jót tesznek a pocakjának is.",
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
                                  "Öt olyan hipnózis gyakorlatot találsz itt a hetek során, melyek hasfájással küzdő általános iskolás és gimnazista tizenévesek számára készültek. Ez a honlap segít abban, hogy milyen sorrendben, mikor és hogyan használd őket.",
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
                                  "Reméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.04),
                          Container(
                            /*decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.blueish,
                          border:
                              Border.all(color: AppColors.whitewhite, width: 4),
                        ),*/
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Adjust the radius as needed
                                    child: Image.asset(
                                        "assets/images/nyitokep_2.jpeg"),
                                  ),
                                ),

                                Positioned(
                                  top: 0,//MediaQuery.of(context).size.width * 0.001,
                                  right: MediaQuery.of(context).size.width * 0.04,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ModuleHipno("$Azonosito"),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        AppColors.whitewhite,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                      ),
                                    ),
                                    child: Text(
                                      "Kezdjük!",
                                      style: MyTextStyles.bethesdagomb_lila(context),
                                    ),
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


                /*
                // Front Layer with Clickable parts
                SidebarLayout(
                  weekScreens: {
                    '1-2.hét': {
                      'screenBuilder': (context) => ModuleHipno("$Azonosito"),
                      'isClickable': true,
                    },
                    '3-4.hét': {
                      'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
                      'isClickable': true,
                    },
                    '5-6.hét': {
                      'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
                      'isClickable': true,
                    },
                    '7-8.hét': {
                      'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
                      'isClickable': true,
                    },
                    '9-12.hét': {
                      'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
                      'isClickable': true,
                    },

                  },
                  selectedWeek: '1.hét', // Specify which week is selected
                  weekTextStyles: {
                    '1.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
                    //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
                    // Add other weeks as needed with their respective styles
                  },
                  rectangleColor: AppColors.blueish, // You can change this color to any other color

                ),
                */



                Positioned(
                  top: 0, // Position it at the top
                  left: MediaQuery.of(context).size.width*0.05, // Align it to the left corner
                  child: SafeArea(
                    child: IconButton(
                      icon: Icon(Icons.menu, color: AppColors.blueish),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer(); // Open the drawer (sidebar)
                      },
                    ),
                  ),
                ),

              ],
            ),
            // ide kell záró
          ],
        ),
        ),

      ],

        //ideee
      );
  }


  // Preserve the original desktop layout (or large screen)
  Widget desktopLayout() {
    // This is your original layout that will be used for desktop/laptop views
    return
      Stack(children: [
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
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73, // 73% of the screen width
                              height: MediaQuery.of(context).size.width * 0.4,  // Increase height proportionately
                              //ádám: MJ_köszöntö.mp4
                              child: HtmlWidget(
                                '<video controls controlsList="nodownload" style="border:none; margin:0; padding:0; width:100%; height:100%;" src="https://storage.googleapis.com/lomeeibucket/MJ_k%C3%B6sz%C3%B6nt%C3%B6.mp4" ></video>',
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(
                                // This will allow text to wrap within the row.
                                child: Text("Szia!",
                                    style:
                                    MyTextStyles.bethesdagomb_lila(context)),
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
                                  "Ezen a honlapon tudod meghallgatni a hipnózis gyakorlatokat és segít abban is, hogy hol és mikor végezd őket. A legtöbb gyerek nagyon szereti hallgatni ezeket a gyakorlatokat és azt tapasztalja, hogy jót tesznek a pocakjának is.",
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
                                  "Öt olyan hipnózis gyakorlatot találsz itt a hetek során, melyek hasfájással küzdő általános iskolás és gimnazista tizenévesek számára készültek. Ez a honlap segít abban, hogy milyen sorrendben, mikor és hogyan használd őket.",
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
                                  "Reméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                                  style: MyTextStyles.bekezdes(context),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),

                          Container(
                            /*decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.blueish,
                          border:
                              Border.all(color: AppColors.whitewhite, width: 4),
                        ),*/
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

                                Positioned(
                                  top: MediaQuery.of(context).size.width * 0.001,
                                  right: MediaQuery.of(context).size.width * 0.04,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('Button pressed ...');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ModuleHipno("$Azonosito"),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        AppColors.whitewhite,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                      ),
                                    ),
                                    child: Text(
                                      "Kezdjük!",
                                      style: MyTextStyles.bethesdagomb_lila(context),
                                    ),
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


          // Front Layer with Clickable parts
          SidebarLayout(
            iconSuffix: '_l',  // Here you pass the suffix you want
            weekScreens: {
              '1-2.hét': {
                'screenBuilder': (context) => ModuleHipno("$Azonosito"),
                'isClickable': true,
              },
              '3-4.hét': {
                'screenBuilder': (context) => ModuleHipno2("$Azonosito"),
                'isClickable': true,
              },
              '5-6.hét': {
                'screenBuilder': (context) => ModuleHipno3("$Azonosito"),
                'isClickable': true,
              },
              '7-8.hét': {
                'screenBuilder': (context) => ModuleHipno4("$Azonosito"),
                'isClickable': true,
              },
              '9-12.hét': {
                'screenBuilder': (context) => ModuleHipno5("$Azonosito"),
                'isClickable': true,
              },

            },
            selectedWeek: '1.hét', // Specify which week is selected
            weekTextStyles: {
              '1.hét': MyTextStyles.vastagblueish(context),  // Style for '1.hét'
              //'2.hét': MyTextStyles.vastagbekezdes(context), // Style for '2.hét'
              // Add other weeks as needed with their respective styles
            },
            rectangleColor: AppColors.blueish, // You can change this color to any other color

          ),


        /*
                Positioned(
                  top: 0, // Position it at the top
                  left: 0, // Align it to the left corner
                  child: SafeArea(
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer(); // Open the drawer (sidebar)
                      },
                    ),
                  ),
                ),
                */
              ],
            ),
            // ide kell záró
          ],
        ),
        ),

      ],

    //ideee
    );
  }
}
