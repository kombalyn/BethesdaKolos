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
  int _daysDifference = -1;
  String Azonosito = '';
  ModuleOpening_M3(String s, int daysDifference, {super.key}) {
    Azonosito = s;
    print("daysDifference");
    print(daysDifference);
    _daysDifference = daysDifference;
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

            '/module_opening': (context) => ModuleOpening_M3_Widget(Azonosito,_daysDifference),
            // Adding the existing module screen as a route
          },
          home: ModuleOpening_M3_Widget(Azonosito,_daysDifference), // Default home screen
        ),
      );
  }
}

class ModuleOpening_M3_Widget extends StatefulWidget {
  final String Azonosito;
  int daysDifference;

  ModuleOpening_M3_Widget(this.Azonosito, this.daysDifference, {Key? key}) : super(key: key);

  @override
  _ModuleOpening_M3_WidgetState createState() =>
      _ModuleOpening_M3_WidgetState(Azonosito,daysDifference);
}

class _ModuleOpening_M3_WidgetState extends State<ModuleOpening_M3_Widget> {
  late HomePageModel _model;
  late bool toggle = true;
  final ScrollController _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String Azonosito = '';
  int DaysDifference = -1;
  Map<String, dynamic> decodedMap = {};

  // Bool változók a hetek kattinthatóságához
  bool isQuiz1Completed = true; // Kérdések (kezdeti kvíz)
  bool isWeek1_2Unlocked = true; // 1-2. hét
  bool isWeek3Unlocked = true; // 3. hét
  bool isWeek4Unlocked = true; // 4. hét
  bool isWeek5Unlocked = true; // 5. hét
  bool isWeek6Unlocked = true; // 6. hét
  bool isWeek7_8Unlocked = true; // 7-8. hét
  bool isWeek9_11Unlocked = true; // 9-11. hét
  bool isWeek12Unlocked = true;

  _ModuleOpening_M3_WidgetState(String azonosito, int daysDifference){
    Azonosito =  azonosito;
    DaysDifference = daysDifference;
  } // 12. hét

  Future getUserResponses(List<Question> questionList) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString('user_response');

      if (jsonString != null) {
        decodedMap = json.decode(jsonString);
        setState(() {
          // Például: ha a decodedMap nem üres, az első kvíz kitöltöttnek tekinthető
          isQuiz1Completed = decodedMap.isNotEmpty;
          // További logika a hetek feloldásához, pl. ha egy adott kvíz kitöltve van
          isWeek1_2Unlocked = isQuiz1Completed; // 1-2. hét feloldása az első kvíz után
          isWeek3Unlocked = isWeek1_2Unlocked; // Példa: 3. hét az 1-2. után
          // További feltételeket itt adhatsz meg
        });
      }
    } catch (e) {
      print('Hiba a válaszok betöltésekor: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();

    isWeek1_2Unlocked = true;

    if (2<(DaysDifference/7)) {
      isWeek3Unlocked = true;
    }
    if (3<(DaysDifference/7)) {
      isWeek4Unlocked = true;
    }
    if (4<(DaysDifference/7)) {
      isWeek5Unlocked = true;
    }
    if (5<(DaysDifference/7)) {
      isWeek6Unlocked = true;
    }
    if (6<(DaysDifference/7)) {
      isWeek7_8Unlocked = true;
    }
    if (8<(DaysDifference/7)) {
      isWeek9_11Unlocked = true;
    }
    if (8<(DaysDifference/7)) {
      isWeek1_2Unlocked = true;
    }

  }

  @override
  void dispose() {
    _model.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Kutatási fázis'),
      body: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder(
            future: getUserResponses(quizProvider1.questions),
            builder: (context, snapshot) {
              return Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 1.5,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      color: AppColors.whitewhite,
                      child: Column(
                        children: [
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 33,
                                color: AppColors.yellow,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Fájdalomkezelési kisokos',
                                textAlign: TextAlign.left,
                                style: MyTextStyles.huszonkettobekezdes(context),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 33),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: isQuiz1Completed
                                      ? Colors.white
                                      : AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.03,
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
                                    color: isQuiz1Completed
                                        ? Colors.white
                                        : AppColors.lightshade,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset('assets/images/2icon_m.png'),
                                    title: Text(
                                      'Kérdések',
                                      style: MyTextStyles.vastagyellow(context),
                                    ),
                                    onTap: () {
                                      if (!isQuiz1Completed) {
                                        Navigator.pushNamed(context, '/quiz1');
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Ez a kvíz már kitöltve!'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  color: isQuiz1Completed
                                      ? Colors.white
                                      : AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
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
                                  style: MyTextStyles.huszonegybekezdes(context),
                                ),
                                Container(
                                  color: isWeek1_2Unlocked
                                      ? Colors.white
                                      : AppColors.lightshade,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
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
                                    color: isWeek1_2Unlocked
                                        ? Colors.white
                                        : AppColors.lightshade,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset('assets/images/5icon_m.png'),
                                    title: Text(
                                      '1-2. hét',
                                      style: MyTextStyles.vastagbekezdes(context),
                                    ),
                                    subtitle: Text(
                                      isWeek1_2Unlocked ? 'Elérhető' : 'Zárolva',
                                      style: MyTextStyles.kicsibekezdes(context),
                                    ),
                                    onTap: () {
                                      if (isWeek1_2Unlocked) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const ShowResponse(''),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Kérlek, töltsd ki először a kvízt!'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek3Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek3Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen2(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek4Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek4Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen3(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek5Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek5Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen4(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek6Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek6Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen5(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek7_8Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek7_8Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen6(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek9_11Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek9_11Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen7(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  color: AppColors.whitewhite,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width * 0.02,
                                    decoration: const BoxDecoration(
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
                                    isWeek12Unlocked ? 'Elérhető' : 'Zárolva',
                                    style: MyTextStyles.kicsibekezdes(context),
                                  ),
                                  onTap: () {
                                    if (isWeek12Unlocked) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const M3_12het(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ez a hét még zárolva van!'),
                                        ),
                                      );
                                    }
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
                            height: MediaQuery.sizeOf(context).height * 1.5,
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            decoration: const BoxDecoration(
                              color: AppColors.lightshade,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.03,
                                  right: MediaQuery.of(context).size.width * 0.3,
                                  top: MediaQuery.of(context).size.width * 0.07,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Ezen a honlapon találsz majd néhány kérdést és videót amivel személyre tudjuk szabni a kezelésedet. Kérünk, válaszolj majd ezekre figyelemmel. \nA kitöltés körülbelül 20-25 percet vesz igénybe. Lehetőleg ne zárd be az ablakot amíg nem végeztél a kitöltéssel.",
                                            style: MyTextStyles.bekezdes(context),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.07),
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
                                    SizedBox(height: MediaQuery.of(context).size.width * 0.002),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: 0.6,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 1.5,
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
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
