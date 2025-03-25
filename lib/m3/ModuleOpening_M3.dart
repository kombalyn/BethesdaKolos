// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:bethesda_2/constants/sidebar_layout.dart'; // Make sure this path is correct

import 'package:bethesda_2/m3/models/questions1.dart';
import 'package:bethesda_2/m3/screens/show_response.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'screens/quiz_screen1.dart';
import 'screens/quiz_screen2.dart';
import 'screens/quiz_screen3.dart';
import 'screens/quiz_screen4.dart';
import 'screens/quiz_screen5.dart';
import 'screens/quiz_screen6.dart';
import 'screens/quiz_screen7.dart';


import 'providers/quiz_provider2.dart';
import 'providers/quiz_provider3.dart';
import 'providers/quiz_provider4.dart';
import 'providers/quiz_provider5.dart';
import 'providers/quiz_provider6.dart';
import 'providers/quiz_provider7.dart';
import 'ModuleM3_12het.dart';

import 'providers/quiz_provider1.dart';
import 'package:provider/provider.dart';
export '../home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'package:flutter_svg/flutter_svg.dart';
import '../appbar/appbar.dart';

// ignore: must_be_immutable
class ModuleOpening_M3 extends StatelessWidget {
  String Azonosito = '';
  ModuleOpening_M3(String s, int daysDifference, {super.key}) {
    Azonosito = s;
    print("daysDifference");
    print(daysDifference);
  }

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => QuizProvider1()),
          ChangeNotifierProvider(create: (context) => QuizProvider2()),
          ChangeNotifierProvider(create: (context) => QuizProvider3()),
          ChangeNotifierProvider(create: (context) => QuizProvider4()),
          ChangeNotifierProvider(create: (context) => QuizProvider5()),
        ],
        child: MaterialApp(
          title: 'Fájdalomkezelés - M3',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
            useMaterial3: false,
          ),
          initialRoute: '/module_opening',
          // Set the initial route to module opening screen
          routes: {
            '/quiz1': (context) => QuizScreen1(),
            '/quiz2': (context) => QuizScreen2(),
            '/quiz3': (context) => QuizScreen3(),
            '/quiz4': (context) => QuizScreen4(),
            '/quiz5': (context) => QuizScreen5(),
            '/quiz6': (context) => QuizScreen6(),
            '/quiz7': (context) => QuizScreen7(),

            '/module_opening': (context) => ModuleOpening_M3_Widget(Azonosito),
            // Adding the existing module screen as a route
          },
          home: ModuleOpening_M3_Widget(Azonosito), // Default home screen
        ),
      );
  }
}

class ModuleOpening_M3_Widget extends StatefulWidget {
  final String Azonosito;

  ModuleOpening_M3_Widget(this.Azonosito, {Key? key}) : super(key: key);

  @override
  _ModuleOpening_M3_WidgetState createState() =>
      _ModuleOpening_M3_WidgetState();
}

class _ModuleOpening_M3_WidgetState extends State<ModuleOpening_M3_Widget> {
  late HomePageModel _model;
  // late VideoPlayerController _controller;
  // bool _isPlaying = false;
  // late AnimationController _animationController;
  // late double _currentPointOnFunction = 0; // Az aktuális függvényérték
  // late double _sliderValue = 0.0; // A csúszka értéke
  late bool toggle = true;
  final ScrollController _scrollController = ScrollController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  Map<String, dynamic> decodedMap = {};
  // List<Question> userResponse = [];
  Future getUserResponses(List<Question> questionList) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString('user_response');

      if (jsonString != null) {
        decodedMap = json.decode(jsonString);
        // setState(() {
        //   answeerMap = decodedMap.map(
        //     (key, value) => MapEntry(
        //       key,
        //       List<String>.from(value.map((item) => item as String)),
        //     ),
        //   );
        // });
        // filterAnsweerMap = filterMapByPrefixes(answeerMap, [
        //   widget.keyValue.toString().split('-').first,
        //   widget.keyValue.toString().split('-').last
        // ]);

        //  final quizProvider1 = Provider.of<QuizProvider1>(context);

        // userResponse = questionList
        //     .where((question) => answeerMap.keys
        //         .contains(question.text.toString().split(':').first))
        //     .toList();
        setState(() {});
      }
      // print(' -=-=-=-=-=-$userResponse');
    } catch (e) {
      print('sdasdadas $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    /*_controller =
        _controller = VideoPlayerController.asset('assets/videos/szia.mp4')
          ..initialize().then((_) {
            setState(() {});
          });
    _isPlaying = true;

    _controller.addListener(() {
      setState(() {});
    });

    _controller.value.isPlaying ? _controller.pause() : _controller.play();

     */
  }

  @override
  void dispose() {
    _model.dispose();
    // _controller.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // void _playPauseVideo() {
  //   setState(() {
  //     if (_controller.value.isPlaying) {
  //       // _controller.pause();
  //       _isPlaying = false;
  //     } else {
  //       // _controller.play();
  //       _isPlaying = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Kutatási fázis'),
      body: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder(
              future: getUserResponses(quizProvider1.questions),
              builder: (context, sano) {
                return Container(
                  // height: MediaQuery.sizeOf(context).height,
                  // width: MediaQuery.sizeOf(context).width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height*1.5,
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        color: AppColors.whitewhite,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 33,
                                  color: AppColors.yellow,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Fájdalomkezelési kisokos',
                                  textAlign: TextAlign.left,
                                  style:
                                  MyTextStyles.huszonkettobekezdes(context),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 33),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: decodedMap.isNotEmpty
                                        ? Colors.white
                                        : AppColors.lightshade,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.03,
                                      decoration: const BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: decodedMap.isNotEmpty
                                          ? Colors.white
                                          : AppColors.lightshade,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0),
                                        // topRight:  Radius.circular(20.0),
                                        // bottomRight:  Radius.circular(20.0)
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: Image.asset(
                                          'assets/images/2icon_m.png'),
                                      title: Text(
                                        'Kérdések',
                                        style:
                                        MyTextStyles.vastagyellow(context),
                                      ),
                                      onTap: () async {
                                        if (decodedMap.isEmpty) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ModuleOpening_M3('Azonosito',0),
                                            ),
                                          );
                                        }

                                        print("gomb");
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: decodedMap.isNotEmpty
                                        ? Colors.white
                                        : AppColors.lightshade,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.02,
                                      decoration: const BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    'Anyagok',
                                    textAlign: TextAlign.left,
                                    style:
                                    MyTextStyles.huszonegybekezdes(context),
                                  ),

                                  Container(
                                    color: decodedMap.isEmpty
                                        ? Colors.white
                                        : AppColors.lightshade,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width *
                                          0.02,
                                      decoration: const BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: decodedMap.isEmpty
                                          ? Colors.white
                                          : AppColors.lightshade,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: Image.asset(
                                          'assets/images/5icon_m.png'),
                                      title: Text(
                                        '1-2. hét',
                                        style: MyTextStyles.vastagbekezdes(
                                            context),
                                      ),
                                      subtitle: Text(
                                        'Jelenlegi',
                                        style:
                                        MyTextStyles.kicsibekezdes(context),
                                      ),
                                      onTap: () {
                                        if (decodedMap.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text('Kérlek, töltsd ki először a kvízt!'),
                                          ));
                                        }

                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (BuildContext context) =>
                                        //         const ShowResponse(''),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ),
                                  // Container(
                                  //   color: decodedMap.isEmpty
                                  //       ? Colors.white
                                  //       : AppColors.lightshade,
                                  //   child: Container(
                                  //     height:
                                  //         MediaQuery.of(context).size.width *
                                  //             0.02,
                                  //     decoration: const BoxDecoration(
                                  //       color: AppColors.whitewhite,
                                  //       borderRadius: BorderRadius.only(
                                  //         topRight: Radius.circular(20.0),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/4icon_m.png'),
                                    title: Text(
                                      '3. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen2(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/6icon_m.png'),
                                    title: Text(
                                      '4. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen3(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/3icon_m.png'),
                                    title: Text(
                                      '5. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen4(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/7icon_m.png'),
                                    title: Text(
                                      '6. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen5(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/7icon_m.png'),
                                    title: Text(
                                      '7-8. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen6(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/7icon_m.png'),
                                    title: Text(
                                      '9-11. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  QuizScreen7(),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    color: AppColors.whitewhite,
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.width * 0.02,
                                      decoration:const  BoxDecoration(
                                        color: AppColors.whitewhite,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset('assets/images/7icon_m.png'),
                                    title: Text(
                                      '12. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const  M3_12het(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        child: decodedMap.isNotEmpty
                            ? const ShowResponse('')
                            : Stack(
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height*1.5,
                              width:
                              MediaQuery.sizeOf(context).width * 0.75,
                              decoration: const BoxDecoration(
                                color: AppColors.lightshade,
                              ),
                              child: Align(
                                alignment: Alignment.topCenter, // Align the Column to the top center
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.03,
                                    right: MediaQuery.of(context).size.width * 0.3,
                                    top: MediaQuery.of(context).size.width * 0.07,

                                  ), // Indentation for the rows
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min, // Minimize Column height to its content
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Szia!",
                                              style: MyTextStyles.huszonkettovastagyellow(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Ezen a honlapon találsz majd néhány kérdést és videót amivel személyre tudjuk szabni a kezelésedet. Kérünk, válaszolj majd ezekre figyelemmel. \nA kitöltés körülbelül x percet vesz igénybe. Lehetőleg ne zárd be az ablakot amíg nem végeztél a kitöltéssel.",
                                              style: MyTextStyles.bekezdes(context),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "\nReméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                                              style: MyTextStyles.bekezdes(context),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.07,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('Button pressed ...');
                                          Navigator.pushNamed(context, '/quiz1');
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            AppColors.whitewhite,
                                          ),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                          ),
                                        ),
                                        child: Text(
                                          "Kezdjük!",
                                          style: MyTextStyles.huszonkettovastagyellow(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.width * 0.002,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Opacity(
                                opacity:
                                0.6, // Adjust the opacity as needed
                                child: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.4, // Set your desired width
                                  height:
                                  MediaQuery.of(context).size.height *
                                      1.5,
                                  child: SvgPicture.asset(
                                    "assets/images/m3hatter.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Stack(
                      //   children: [
                      //     // Background Layer
                      //     Container(
                      //       color: AppColors.lightshade, // Your desired background color
                      //       width: double.infinity,
                      //       height: MediaQuery.of(context).size.height*1.2,
                      //     ),
                      //     // Image Layer
                      //     Align(
                      //       alignment: Alignment.centerRight,
                      //       child: Opacity(
                      //         opacity: 0.6, // Adjust the opacity as needed
                      //         child: SizedBox(
                      //           width: MediaQuery.of(context).size.width * 0.4, // Set your desired width
                      //           height: MediaQuery.of(context).size.height*1.2,
                      //           child: SvgPicture.asset(
                      //             "assets/images/m3hatter.svg",
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //     ),

                      //     // Overlay content
                      //     Column(
                      //       children: [
                      //         Container(
                      //           padding: EdgeInsets.only(
                      //             left: MediaQuery.of(context).size.width * 0.27,
                      //             right: MediaQuery.of(context).size.width * 0.3,
                      //           ), // Indentation for the rows
                      //           child: Column(
                      //             children: [
                      //               SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Text(
                      //                       "Szia!",
                      //                       style: MyTextStyles.bethesdagomb(context),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Text(
                      //                       "Ezen a honlapon találsz majd néhány kérdést és videót amivel személyre tudjuk szabni a kezelésedet. Kérünk, válaszolj majd ezekre figyelemmel. \nA kitöltés körülbelül x percet vesz igénybe. Lehetőleg ne zárd be az ablakot amíg nem végeztél a kitöltéssel.",
                      //                       style: MyTextStyles.bekezdes(context),
                      //                       textAlign: TextAlign.justify,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Text(
                      //                       "\nReméljük élvezni fogod ezeket a gyakorlatokat és jól szórakozol majd!",
                      //                       style: MyTextStyles.bekezdes(context),
                      //                       textAlign: TextAlign.justify,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //                 SizedBox(height: MediaQuery.of(context).size.width * 0.07),

                      //               ElevatedButton(
                      //                 onPressed: () {
                      //                   print('Button pressed ...');
                      //                   Navigator.pushNamed(context, '/quiz1');
                      //                 },
                      //                 style: ButtonStyle(
                      //                   backgroundColor:
                      //                   MaterialStateProperty.all<Color>(
                      //                     AppColors.whitewhite,
                      //                   ),
                      //                   shape: MaterialStateProperty.all<
                      //                       RoundedRectangleBorder>(
                      //                     RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(10),
                      //                     ),
                      //                   ),
                      //                   padding: MaterialStateProperty.all<
                      //                       EdgeInsetsGeometry>(
                      //                     EdgeInsets.symmetric(
                      //                         vertical: 12, horizontal: 24),
                      //                   ),
                      //                 ),
                      //                 child: Text(
                      //                   "Kezdjük!",
                      //                   style: MyTextStyles.bethesdagomb(context),
                      //                 ),
                      //               ),
                      //               SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      //               // Container(
                      //               //   width: MediaQuery.of(context).size.width * 0.45,
                      //               //   height: MediaQuery.of(context).size.width * 0.2,
                      //               //   decoration: BoxDecoration(
                      //               //     border: Border.all(color: Colors.black, width: 1),
                      //               //   ),
                      //               //   child: Stack(
                      //               //     children: [
                      //               //       SvgPicture.asset(
                      //               //         "assets/images/m3hatter.svg",
                      //               //         fit: BoxFit.cover,
                      //               //       ),
                      //               //       Positioned(
                      //               //         bottom: 16, // Adjust the position as needed
                      //               //         left: 16, // Adjust the position as needed
                      //               //         child: ElevatedButton(
                      //               //           onPressed: () {
                      //               //             // Handle button press
                      //               //           },
                      //               //           child: Text('Click Me'),
                      //               //         ),
                      //               //       ),
                      //               //     ],
                      //               //   ),
                      //               // ),
                      //               // Add more rows as needed
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),

                      //   Positioned(
                      //       top: 0,
                      //       left: 0,
                      //       bottom: 0,
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width * 0.25,
                      //         color: Colors.white.withOpacity(1),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: MediaQuery.of(context).size.width * 0.03,
                      //             left: MediaQuery.of(context).size.width * 0.04,
                      //           ),
                      //           child: Container(
                      //             width: MediaQuery.of(context).size.width * 0.3,
                      //             color: Colors.white.withOpacity(0.3),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'Fájdalomkezelési kisokos',
                      //                   textAlign: TextAlign.left,
                      //                   style: MyTextStyles.huszonkettobekezdes(context),
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.lightshade,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.03,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         bottomRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   decoration: const BoxDecoration(
                      //                     color: AppColors.lightshade,
                      //                     borderRadius: BorderRadius.only(
                      //                       topLeft: Radius.circular(20.0),
                      //                       bottomLeft: Radius.circular(20.0),
                      //                     ),
                      //                   ),
                      //                   child: ListTile(
                      //                     leading:
                      //                         Image.asset('assets/images/2icon_m.png'),
                      //                     title: Text(
                      //                       'Kérdések',
                      //                       style: MyTextStyles.vastagyellow(context),
                      //                     ),
                      //                     onTap: () async {
                      //                       Navigator.pushReplacement(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (BuildContext context) =>
                      //                               ModuleOpening_M3('Azonosito'),
                      //                         ),
                      //                       );
                      //                       print("gomb");
                      //                     },
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.lightshade,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         topRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   'Anyagok',
                      //                   textAlign: TextAlign.left,
                      //                   style: MyTextStyles.huszonegybekezdes(context),
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration: BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         topRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   decoration: const BoxDecoration(
                      //                     color: AppColors.whitewhite,
                      //                     borderRadius: BorderRadius.only(
                      //                       topLeft: Radius.circular(20.0),
                      //                       bottomLeft: Radius.circular(20.0),
                      //                     ),
                      //                   ),
                      //                   child: ListTile(
                      //                     leading:
                      //                         Image.asset('assets/images/5icon_m.png'),
                      //                     title: Text(
                      //                       '1-2. hét',
                      //                       style: MyTextStyles.vastagbekezdes(context),
                      //                     ),
                      //                     subtitle: Text(
                      //                       'Zárolva',
                      //                       style: MyTextStyles.kicsibekezdes(context),
                      //                     ),
                      //                     onTap: () {
                      //                       Navigator.pushReplacement(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (BuildContext context) =>
                      //                              const  ShowResponse('1-2'),
                      //                         ),
                      //                       );
                      //                     },
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration:const BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         topRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 ListTile(
                      //                   leading: Image.asset('assets/images/4icon_m.png'),
                      //                   title: Text(
                      //                     '3-4. hét',
                      //                     style: MyTextStyles.vastagbekezdes(context),
                      //                   ),
                      //                   subtitle: Text(
                      //                     'Zárolva',
                      //                     style: MyTextStyles.kicsibekezdes(context),
                      //                   ),
                      //                   onTap: () {
                      //                     Navigator.pushReplacement(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                         builder: (BuildContext context) =>
                      //                             const  ShowResponse('3-4'),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration:const  BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         topRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 ListTile(
                      //                   leading: Image.asset('assets/images/6icon_m.png'),
                      //                   title: Text(
                      //                     '5-6. hét',
                      //                     style: MyTextStyles.vastagbekezdes(context),
                      //                   ),
                      //                   subtitle: Text(
                      //                     'Zárolva',
                      //                     style: MyTextStyles.kicsibekezdes(context),
                      //                   ),
                      //                   onTap: () {
                      //                     Navigator.pushReplacement(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                         builder: (BuildContext context) =>
                      //                            const  ShowResponse('5-6'),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration:const  BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         bottomRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 ListTile(
                      //                   leading: Image.asset('assets/images/3icon_m.png'),
                      //                   title: Text(
                      //                     '7-8. hét',
                      //                     style: MyTextStyles.vastagbekezdes(context),
                      //                   ),
                      //                   subtitle: Text(
                      //                     'Zárolva',
                      //                     style: MyTextStyles.kicsibekezdes(context),
                      //                   ),
                      //                   onTap: () {
                      //                     Navigator.pushReplacement(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                         builder: (BuildContext context) =>
                      //                            const  ShowResponse('7-8'),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration:const  BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         bottomRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 // ListTile(
                      //                 //   leading: Image.asset('assets/images/7icon_m.png'),
                      //                 //   title: Text(
                      //                 //     '9-12. hét',
                      //                 //     style: MyTextStyles.vastagbekezdes(context),
                      //                 //   ),
                      //                 //   subtitle: Text(
                      //                 //     'Zárolva',
                      //                 //     style: MyTextStyles.kicsibekezdes(context),
                      //                 //   ),
                      //                 //   onTap: () {
                      //                 //     Navigator.pushReplacement(
                      //                 //       context,
                      //                 //       MaterialPageRoute(
                      //                 //         builder: (BuildContext context) =>
                      //                 //             ModuleOpening_M3('Azonosito'),
                      //                 //       ),
                      //                 //     );
                      //                 //   },
                      //                 // ),

                      //                 Container(
                      //                   color: AppColors.whitewhite,
                      //                   child: Container(
                      //                     height:
                      //                         MediaQuery.of(context).size.width * 0.02,
                      //                     decoration:const  BoxDecoration(
                      //                       color: AppColors.whitewhite,
                      //                       borderRadius: BorderRadius.only(
                      //                         bottomRight: Radius.circular(20.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       top: MediaQuery.of(context).size.width * 0.029,
                      //       left: 0,
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width * 0.03,
                      //         height: MediaQuery.of(context).size.height * 0.05,
                      //         color: AppColors.yellow,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
