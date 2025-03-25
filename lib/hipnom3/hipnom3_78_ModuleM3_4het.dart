import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';

import '../appbar/appbar.dart';

import 'models/hipnom3_questions1.dart';
import 'providers/hipnom3_3_4_quiz_provider1.dart';
import 'providers/hipnom3_7_quiz_provider2.dart';
import 'providers/hipnom3_8_quiz_provider3.dart';
import 'providers/hipnom3_11_quiz_provider4.dart';
import 'providers/hipnom3_12_quiz_provider5.dart';
import 'screens/hipnom3_1_2_quiz_screen1.dart';
import 'screens/hipnom3_7_quiz_screen2.dart';
import 'screens/hipnom3_8_quiz_screen3.dart';
import 'screens/hipnom3_11_quiz_screen4.dart';
import 'screens/hipnom3_12_quiz_screen5.dart';
import 'screens/hipnom3_result_screen1.dart';
import 'screens/hipnom3_show_response.dart';


class hipnom3_M3_4het extends StatefulWidget {
  String Azonosito = '';
  hipnom3_M3_4het(String s, {super.key}){Azonosito=s;}

  @override
  _hipnom3_M3_4het createState() => _hipnom3_M3_4het(Azonosito);
}

class _hipnom3_M3_4het extends State<hipnom3_M3_4het> {
  String Azonosito = '';
  _hipnom3_M3_4het(this.Azonosito);

  // State variables for tracking visibility and text input
  List<bool> isTextVisible = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Track visibility state
  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Track if section has been opened
  List<TextEditingController> textControllers = List.generate(
      6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();

    // _channel = WebSocketChannel.connect(
    //   Uri.parse('wss://146.148.43.137:8089'),
    // );

    // _channel?.stream.listen((message) {
    //   print('Received message: $message');
    // });
  }

  Map<String, List<String>> answerMap = {};

  void saveAnswer(Question obj) {
    answerMap.addAll({obj.text
        .toString()
        .split(':')
        .first: obj.userResponse!});
    print('Answer map: $answerMap');
    setState(() {});
  }

  void _sendAnswer(int questionIndex, String answer, String question) {
    String message = 'save|Azonosito;M3;1-2;$questionIndex,$answer';
    // _channel?.sink.add(message);
  }

  @override
  void dispose() {
    textControllers.forEach((controller) =>
        controller.dispose()); // Dispose text controllers
    // _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider3>(context, listen: true);
    final currentQuestion = quizProvider.currentQuestion;
    double progressValue = (quizProvider.currentQuestion.index + 1) / 5;

    return Scaffold(
      appBar: CustomAppBar(title: 'Kutatási fázis'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Background Layer
                Column(
                  children: [
                    Container(
                      color: AppColors.lightshade,
                      padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.33,
                        right: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.03),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Szia!",
                                  style: MyTextStyles.huszonkettovastagyellow(
                                      context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.02),
                          Text(
                            "Ezen a héten, arról fogunk beszélgetni, hogy hogyan tudod hosszú távon fenntartani a motivációdat és hogyan tudod lelkesíteni magad, amikor úgy érzed nincs kedved, vagy energiád a mozgáshoz.",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.03),
                          Text(
                            "Melyik témával kezdenél?",
                            style: MyTextStyles.bekezdes(context),
                            textAlign: TextAlign.justify,
                          ),

                          // Expandable Text Sections
                          _buildExpandableText(
                            index: 0,
                            title: "Találd meg a miérted!",
                            content:
                            "Miért szeretnél változtatni? Gondolj azokra a dolgokra, amiket igazán szeretsz csinálni. Lehet, hogy többet szeretnél a barátaiddal lenni, újra felfedezni egy régi hobbidat, vagy egyszerűen csak jobban szeretnéd érezni magad.\n\nMegj.: itt visszajön a “Miért éri megéri mozogni” tábla adata úgy, hogy van plusz adat hozzáadási lehetőség, de a már leírtakon nem módosíthat.",
                            question: "Az előző héten már leírtad, hogy miért éri meg Neked elkezdeni, vagy folytatni a mozgást. Nézzük meg újra ezeket. Ha eszedbe jutna valami új ok, add hozzá a listához és tartsd őket szem előtt, amikor nehéz időszakon mész keresztül.",
                          ),
                          _buildExpandableText(
                            index: 1,
                            title: "Vezess naplót!",
                            content:
                            "Írd le a napjaidat, különösen azokat a pillanatokat, amikor sikerült aktívnak maradnod, vagy amikor nekiálltál mozogni, annak ellenére, hogy nehezen indultál neki. Ezek az apró győzelmek segíthetnek emlékeztetni arra, milyen messzire jutottál, és erőt adnak a folytatáshoz.",
                            question: "Neked mi volt a legnagyobb sikered az elmúlt egy hétben a mozgással kapcsolatban?",
                          ),
                          _buildExpandableText(
                            index: 2,
                            title: "Találj támogató közösséget!",
                            content:
                            "Ne feledd, hogy nem vagy egyedül. Beszélj a barátaiddal, családoddal, vagy keress egy támogató csoportot, ahol mások is hasonló kihívásokkal küzdenek. Együtt könnyebb átvészelni a nehéz időszakokat, és inspirációt meríthetsz mások történeteiből. Nem utolsó sorban együtt mozoghattok és fedezhettek fel új sportokat vagy hobbikat!",
                            question: "Téged kik támogatnak? Kikkel tudsz vagy tudnál együtt mozogni?",
                          ),
                          _buildExpandableText(
                            index: 3,
                            title: "Jutalmazd meg magad!",
                            content:
                            "Jutalmazd meg magad, amikor sikerül elérni egy célt. Ha elérted a heti kitűzött mozgással kapcsolatos célodat gondolj arra: “Megcsináltam! Büszke vagyok magamra!” Már önmagában ez a dícséret hatalmas jutalomnak számít! De persze gondolhatsz itt más jutalmakra is. Ez lehet egy új könyv, vagy egy kirándulás a kedvenc helyedre. A jutalmak segítenek fenntartani a motivációt és emlékeztetnek arra, hogy minden erőfeszítés megéri.",
                            question: "Te milyen jutalmat fogsz adni magadnak, amikor elérted a mozgásos célodat a hét végén?",
                          ),
                          _buildExpandableText(
                            index: 4,
                            title: "Képzeld el a pozitív jövőt!",
                            content:
                            "Képzeld el, milyen lesz az életed, amikor végig csináltad ezt a 12 hetes programot. És milyen lesz fél-egy év múlva? Gondolj arra, hogyan fogsz érezni, mit fogsz csinálni, és hogyan változik meg az életed. Ez a mentális kép segíthet átvészelni a nehéz pillanatokat és fenntartani a lelkesedést.",
                            question: "Te hogyan látod magad? Milyen leszel, ha elérted a mozgással kapcsolatos célkitűzéseidet?",
                          ),

                          // Additional Text
                          Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: Text(
                              "Utógondolat:\n"
                                  "Legyél türelmes és kedves magadhoz!\n"
                                  "Nem baj, ha néha visszaesel vagy lassabban haladsz, mint tervezted. Mindenki más tempóban halad, és ez teljesen rendben van. Ne felejtsd el, hogy minden apró lépés közelebb visz a céljaidhoz. A fenti tippek segíthetnek abban, hogy aktív maradj akkor is, amikor az akaraterőd kimerülőben van. Emlékezz arra, hogy minden erőfeszítés számít, és te képes vagy rá, hogy átlépd a korlátaidat és élvezd az életet.\n"
                              , style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.01),
                          Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: Text(
                              "Jövő héten találkozunk, addig is, mozgásra fel!",
                              style: MyTextStyles.huszonkettovastagyellow(
                                  context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.5),

                        ],
                      ),
                    ),
                  ],
                ),

                // Side Navigation
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.25,
                    color: Colors.white.withOpacity(1),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .width * 0.03,
                        left: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04,
                      ),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        color: Colors.white.withOpacity(0.3),
                        child: _buildSideNavigation(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.029,
                  left: 0,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.05,
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableText({
    required int index,
    required String title,
    required String content,
    required String question,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      // Margin around each section
      padding: EdgeInsets.all(10.0),
      // Padding inside each section
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the section
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        border: Border.all(
          color: AppColors.yellow, // Yellow border color
          width: 2.0, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius of the shadow
            blurRadius: 5, // Blur radius of the shadow
            offset: Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isTextVisible[index] =
                      !isTextVisible[index]; // Toggle visibility
                    });
                  },
                  child: Text(
                    title,
                    style: MyTextStyles.bekezdes(context),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isChecked[index] ? Icons.check_circle : Icons.circle_outlined,
                  color: isChecked[index] ? AppColors.yellow : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isChecked[index] =
                    !isChecked[index]; // Toggle checked state
                  });
                },
              ),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            child: Visibility(
              visible: isTextVisible[index],
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content,
                      style: MyTextStyles.bekezdes(context),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      question,
                      style: MyTextStyles.bekezdes(context).copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: textControllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Válaszod...',
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNavigation() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.3,
      color: Colors.white.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fájdalomkezelési kisokos',
            textAlign: TextAlign.left,
            style: MyTextStyles.huszonkettobekezdes(context),
          ),
          Container(
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.03,
              decoration: const BoxDecoration(
                color: AppColors.whitewhite,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.whitewhite,
              borderRadius: BorderRadius.only(
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
              onTap: () async {},
            ),
          ),
          Container(
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
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
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
              decoration: BoxDecoration(
                color: AppColors.whitewhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.whitewhite,
              borderRadius: BorderRadius.only(
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
                'Zárolva',
                style: MyTextStyles.kicsibekezdes(context),
              ),
              onTap: () {},
            ),
          ),
          Container(
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
              decoration: BoxDecoration(
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
            onTap: () {},
          ),
          Container(
            color: AppColors.lightshade,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
              decoration: BoxDecoration(
                color: AppColors.whitewhite,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.lightshade, // Replace with your desired background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Round top left corner
            bottomLeft: Radius.circular(20), // Round bottom left corner
            // Right corners will remain sharp (not rounded)
          ),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/6icon_m.png'),
          title: Text(
            '4. hét',
            style: MyTextStyles.vastagbekezdes(context),
          ),
          subtitle: Text(
            'Jelenlegi',
            style: MyTextStyles.kicsibekezdes(context),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>  hipnom3_M3_4het('Azonosito'),
              ),
            );
          },
        ),
      ),


      Container(
            color: AppColors.lightshade,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
              decoration: BoxDecoration(
                color: AppColors.whitewhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/3icon_m.png'),
            title: Text(
              '5-6. hét',
              style: MyTextStyles.vastagbekezdes(context),
            ),
            subtitle: Text(
              'Zárolva',
              style: MyTextStyles.kicsibekezdes(context),
            ),
            onTap: () {},
          ),
          Container(
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
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
              '7-12. hét',
              style: MyTextStyles.vastagbekezdes(context),
            ),
            subtitle: Text(
              'Zárolva',
              style: MyTextStyles.kicsibekezdes(context),
            ),
            onTap: () {},
          ),
          Container(
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.02,
              decoration: const BoxDecoration(
                color: AppColors.whitewhite,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}