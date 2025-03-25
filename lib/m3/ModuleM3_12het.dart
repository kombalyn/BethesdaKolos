import 'package:bethesda_2/m3/ModuleOpening_M3.dart';
import 'package:bethesda_2/m3/models/questions1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider1.dart';
import 'providers/quiz_provider2.dart';
import 'providers/quiz_provider3.dart';
import 'screens/quiz_screen3.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';
import 'screens/show_response.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/meno_gomb.dart';
import '../appbar/appbar.dart';

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
              labelStyle: MyTextStyles.kicsibekezdes(context),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whitewhite, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: AppColors.yellow, width: 1),
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
                style: MyTextStyles.bekezdes(context),
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
                      return AppColors.yellow;
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
class M3_12het extends StatefulWidget {
  const M3_12het({super.key});

  @override
  _M3_12het createState() => _M3_12het();
}

class _M3_12het extends State<M3_12het> {
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
  }

  Map<String, List<String>> answerMap = {};

  void saveAnswer(Question obj) {
    answerMap.addAll({obj.text.toString().split(':').first: obj.userResponse!});
    print('Answer map: $answerMap');
    setState(() {});
  }

  void _sendAnswer(int questionIndex, String answer, String question) {
    String message = 'save|Azonosito;M3;1-2;$questionIndex,$answer';
    // _channel?.sink.add(message);
  }

  @override
  void dispose() {
    textControllers.forEach((controller) => controller.dispose()); // Dispose text controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        left: MediaQuery.of(context).size.width * 0.28,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0), child:
                          Text('Gratulálunk, megcsináltad!\n',  style: MyTextStyles.huszonkettovastagyellow(context),
                            textAlign: TextAlign.justify,),),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              "Elérkeztél az M3 Tréning program végéhez, és szeretnénk szívből gratulálni neked az eddigi kitartásodért, bátorságodért és elkötelezettségedért. Nagy utat jártál be az elmúlt 12 hétben, és bízunk benne, hogy ez az időszak pozitív hatással volt a mindennapjaidra, segített a mozgás örömének felfedezésében, és hozzájárult a közérzeted javulásához.\n\n"
                                  "Fontos, hogy tudd, nem vagy egyedül a folytatásban sem. Továbbra is bátorítunk, hogy a saját tempódban, a saját igényeid szerint mozogj, és folytasd a program során megszerzett szokásaidat. Legyél büszke arra, amit elértél! Használd bátran a tréning során megtanultakat, ha új mozgásba kezdenél bele, vagy ha épp valami miatt megakadtál és újrakezdenéd a mozgást.\n\n"
                                  "Ha a program ellenére még mindig tapasztalsz fájdalmat vagy kellemetlenséget, kérünk, jelezd ezt felénk. Ahogy a kutatás elején is írtuk, lehetőséged van egy személyes konzultációra a Bethesda Gyermekkórház Fájdalomkezelő Centrumában.\n\n"
                                  "Ha szeretnél élni ezzel a lehetőséggel, kérlek a lenti levelezőben írd meg nekünk a Te és szüleid e-mail címét, és a nevedet, hogy mihamarabb fel tudjuk venni Veled a kapcsolatot. A levélben írd meg, hogy szeretnél a személyes találkozóval élni, mivel még panaszaid vannak a 12 hetes online terápia után is.\n\n"
                                  "Köszönjük, hogy részt vettél a kutatásban, és reméljük, hogy ez az út csak a kezdete valami nagyszerűnek! Tartsd meg a mozgás szeretetét, és légy büszke arra, amit elértél!\n",
                              style: MyTextStyles.bekezdes(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end, // Aligns the children to the right in the column
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Align(
                  alignment: Alignment.centerRight, // Aligns the text to the right side of the screen
                  child: Text(
                    "Csak így tovább, és mozgásra fel!\n\n"
                        "Üdvözlettel:\n\n"
                        "A kutatócsoport",
                    style: MyTextStyles.huszonkettovastagyellow(context),
                    textAlign: TextAlign.right, // Aligns text content to the right within its widget
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
            ],
          ),

                          Center(
                            child: ContactForm(),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.1),
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: Colors.white.withOpacity(1),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.white.withOpacity(0.3),
                        child: _buildSideNavigation(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.029,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.05,
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
      width: MediaQuery.of(context).size.width * 0.3,
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
            color: AppColors.whitewhite,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.02,
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
            color: AppColors.lightshade,
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
      Container(
        decoration: BoxDecoration(
          color: AppColors.lightshade, // Set your desired background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Round top left corner
            bottomLeft: Radius.circular(20), // Round bottom left corner
          ),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/7icon_m.png'),
          title: Text(
            '12. hét',
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
                builder: (BuildContext context) => const M3_12het(),
              ),
            );
          },
        ),
      ),
      Container(
            color: AppColors.lightshade,
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
      ],
      ),
    );
  }
}
