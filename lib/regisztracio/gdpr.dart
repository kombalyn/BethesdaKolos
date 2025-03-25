import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Make sure this path is correct
import 'regisztracio.dart'; // Ensure this module is correctly implemented
import 'email_azonosito.dart';
import '../constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file


class Gdpr extends StatelessWidget {
  const Gdpr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés regisztráció',
      theme: ThemeData(
        useMaterial3: false,
        cardTheme: CardTheme(
          color:
              Colors.white, // This sets the background color of cards to white
        ),
      ),
      home: const HomePageWidgetGdpr(),
    );
  }
}

class HomePageWidgetGdpr extends StatefulWidget {
  const HomePageWidgetGdpr({Key? key}) : super(key: key);

  @override
  _HomePageWidgetGdprState createState() => _HomePageWidgetGdprState();
}

class _HomePageWidgetGdprState extends State<HomePageWidgetGdpr> {
  late HomePageModel _model;

  bool is1TextVisible = false; // To control the visibility of the text section
  bool is1Checked = false; // Controls the state of the checkbox
  bool is2TextVisible = false; // To control the visibility of the text section
  bool is2Checked = false; // Controls the state of the checkbox
  bool is3TextVisible = false; // To control the visibility of the text section
  bool is3Checked = false; // Controls the state of the checkbox
  bool is4TextVisible = false; // To control the visibility of the text section
  bool is4Checked = false; // Controls the state of the checkbox
  bool is5TextVisible = false; // To control the visibility of the text section
  bool is5Checked = false; // Controls the state of the checkbox
  bool is6TextVisible = false; // To control the visibility of the text section
  bool is6Checked = false; // Controls the state of the checkbox

  bool _termsRead = false;
  bool _consentGiven = false;
  bool _guardianAgreed = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model =
        HomePageModel(); // Ensure that HomePageModel is correctly initialized
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        /*appBar:   CustomAppBar(title: 'Kutatási fázis',  backgroundColor: AppColors.bethesdacolor, // Optional: Override the default background color
          iconColor: AppColors.bethesdacolor,),*/
      backgroundColor: AppColors.lightshade,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.width * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                      Container(
                        decoration: BoxDecoration(
                        color: AppColors.whitewhite,
                          // Background color of the Container
                          borderRadius: BorderRadius.circular(0),
                          // Rounded corners for the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              // Shadow color with some transparency
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset:
                              Offset(0, 4), // Vertical offset for the shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                              left: MediaQuery.of(context).size.width * 0.015,
                              bottom: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.015,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Tájékoztatók és beleegyező nyilatkozatok",
                                textAlign: TextAlign.center,
                                style: MyTextStyles.bethesdabekezdes(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whitewhite,
                        // Background color of the Container
                        borderRadius: BorderRadius.circular(0),
                        // Rounded corners for the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // Shadow color with some transparency
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset:
                                Offset(0, 4), // Vertical offset for the shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.01,
                            left: MediaQuery.of(context).size.width * 0.015,
                            right: MediaQuery.of(context).size.width * 0.015),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is1TextVisible =
                                          !is1TextVisible; // Toggle visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "TÁJÉKOZTATÓ A VIZSGÁLATI SZEMÉLYEK "
                                            "SZÜLEI (JOGI KÉPVISELŐI) SZÁMÁRA",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is1TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Szülő!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // flex: 3,
                                              // Higher flex value for more space
                                              child: Text(
                                                "Köszönjük, hogy Ön és "
                                                  "gyermeke részt vesz "
                                                  "tudományos "
                                                  "vizsgálatunkban. "
                                                  "Ez a tájékoztató részletesen ismerteti a vizsgálatot, és benne az Ön és gyermeke szerepét. Ha bármilyen kérdése van, tegye fel azt a vizsgálatvezetőnek. Ha vállalkozik a részvételre, kérjük, fogadja el a beleegyező nyilatkozatot.",
                                                style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
                                        Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // Default text color
                                                      fontSize: 16,
                                                    ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "A vizsgálat neve: ",
                                                    style: MyTextStyles
                                                      .vastagbekezdes(
                                                      context),
                                                  ),
                                                  TextSpan(
                                                    text: "Funkcionális hasi "
                                                        "fájdalomzavarok online hipnózis és mozgás-motivációs "
                                                      "tréning kezelésének "
                                                        "hatásvizsgálata tizenévesek körében",
                                                    style: MyTextStyles
                                                      .bekezdes(
                                                      context),
                                                  ),
                                                ],
                                              ),
                                              ),),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // Default text color
                                                      fontSize: 16,
                                                    ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "A vizsgálat célkitűzései: ",
                                                    style: MyTextStyles
                                                        .vastagbekezdes(
                                                        context),
                                                  ),
                                                  TextSpan(
                                                    text: "A vizsgálatnak két"
                                                        " fő célja van. Az első, hogy az olyan fiatalok és "
                                                        "családjuk számára, aki "
                                                        "funkcionális hasi fájdalomzavarral (legalább 2 hónapja tartó visszatérő hasi "
                                                        "fájdalommal) élnek "
                                                        "online is elérhetővé tegyünk két terápiát, a mozgás-motivációs tréninget (M3 "
                                                        "Tréning) és a bél-fókuszú hipnózis "
                                                        "terápiát. Így sokkal egyszerűbben és gyorsabban tudnak "
                                                        "segítséget kapni a hasi panaszokkal élő fiatalok "
                                                        " a problémájukkal kapcsolatban. Ahhoz viszont, "
                                                        "hogy valóban hatékony terápiákat tudjunk "
                                                        "nyújtani, előbb meg kell vizsgálnunk ezen módszerek "
                                                        "hatékonyságát. Így a vizsgálat második "
                                                        "célkitűzése, hogy ezt a két online terápiát (M3 Tréning és "
                                                        "a bél-fókuszú hipnózis) egymással, a általános "
                                                        "gyermek-gasztroenterológiai kezelésekkel, "
                                                        "valamint az interdiszciplináris, multimodális fájdalomterápiás ellátással összehasonlítsuk.",
                                                    style: MyTextStyles
                                                        .bekezdes(
                                                        context),),
                                                ],
                                               ),
                                             ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  textAlign:
                                                  TextAlign.justify,
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // Default text color
                                                      fontSize: 16,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "A vizsgálat "
                                                            "menete: ",
                                                        style: MyTextStyles
                                                            .vastagbekezdes(
                                                            context),
                                                      ),
                                                      TextSpan(
                                                        text: "A "
                                                          "gyermek-gasztroenterológiai vizsgálatok végén, vagy ha a gyermekének a "
                                                          "panaszai az "
                                                          "alkalmazott terápia során nem változtak, és a panaszok alapján besorolható a "
                                                          "funkcionális hasi "
                                                          "fájdalomzavarok egyikébe (funkcionális diszpepszia, irritábilis bél szindróma, "
                                                          "hasi migrén, "
                                                          "máshova nem besorolt funkcionális hasi fájdalomzavar), akkor kutatásban való "
                                                          "részvétel "
                                                          "felajánlásra kerül. Ilyenkor a kezelő orvos a gasztroenterológiai vizsgálat végén Önnek "
                                                          "és gyermekének egy "
                                                          "QR-kódot ad, mely a vizsgálati honlapra fogja irányítani Önöket. A QR kód "
                                                          "beolvasására 3 nap áll rendelkezésre.",
                                                        style: MyTextStyles
                                                            .bekezdes(
                                                            context),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  textAlign:
                                                  TextAlign.justify,
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // Default text color
                                                      fontSize: 16,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "A honlapon "
                                                          "előszön is kérjük a vizsgálatba való ismételt beleegyezést. Ezután néhány információt "
                                                          "szükséges "
                                                          "megadniuk, melyek segítik a további kommunikációt Önök és kutatócsoport között. A "
                                                          "honlapon továbbá egy "
                                                          "kérdőívcsomagot "
                                                          "kell mind Önnek, mind pedig gyermekének kitöltenie. "
                                                          "Ezután történik "
                                                          "meg a különböző "
                                                          "vizsgálati ágakba történő, random besorolás és az egyéni kutatási "
                                                          "azonosítók kiosztása.",
                                                        style: MyTextStyles
                                                            .bekezdes(
                                                            context),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "Az öt vizsgálati ág:",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .all(20.0),
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "1.  A "
                                                      "gyermek-gasztroenterológus által javasolt terápia folytatása 12 hétig, majd ezt követően "
                                                  "online bél-fókuszú hipnózis terápia "
                                                  "további 12 hétig\n"
                                                  "2.  Online "
                                                  "mozgás-motivációs tréning (M3 Tréning) 12 hétig, majd ezt követően online bél-"
                                                  "fókuszú hipnózis terápia "
                                                  "további 12 hétig\n"
                                                  "3.  Online bél-fókuszú "
                                                      "hipnózis terápia további 12 hétig, majd ezt követően online mozgás-"
                                                  "motivációs tréning (M3 Tréning) "
                                                  "további 12 hétig\n"
                                                  "4.  A "
                                                  "gyermek-gasztroenterol"
                                                  "ógus által javasolt terápia folytatása 24 hétig\n"
                                                  "5.  Fél napos, "
                                                  "interdiszciplináris, multimodális fájdalomterápia, majd ezt követően 12 hét "
                                                  "múlva kontroll alkalom"
                                                  ,
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ), ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),
///////////////////////////////////////////////////////////////////////////
                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "Amennyiben a panaszok a "
                                                  "kutatás kezdetétől számított 6 hónapon belül is fennálnak, úgy minden "
                                                  "résztvevőnek lehetősége "
                                                  "van részt venni a fél napos, interdiszciplináris, multimodális "
                                                  "fájdalomterápián.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kutatás teljes "
                                                  "időtartama 9 hónap, mely során a kérdőíveket több alkalommal szükséges kitölteni "
                                                  "(3. hét, 6. hét, 9.hét, 12. hét, 15. hét, 18. hét, 21. hét és 24. hét). Erről automatikus emlékeztető e-"
                                                  "mailt küldünk ki az Ön és gyermeke részére.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kutatásban tervezetten 400 fő vesz részt.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kutatás várható időtartama: 2024.04.15.-2026.12.31.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kutatás helye: online, "
                                                  "otthon, az egyéni napirendnek megfelelően, valamint a Bethesda "
                                                  "Gyermekkórház Fájdalomkezelő Centrumában.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A vizsgálatban való "
                                                  "részvétel önkéntes. A vizsgálatba történő beleegyezés a beleegyező "
                                                  "nyilatkozat elfogadásával válik "
                                                  "érvényessé. Ellenkező esetben a kutatásban való részvétel nem "
                                                  "érvényes. A beleegyezés bármikor szóban vagy írásban, indokolás nélkül visszavonható.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kérdőívcsomag kitöltése "
                                                  "önkéntes, a kitöltők, valamint jogi képviselőjük beleegyező "
                                                  "nyilatkozatot írnak alá a "
                                                  "szakorvosi ellátást követően adataik tudományos célú felhasználására "
                                                  "vonatkozóan. A kiskorú tizenévesek"
                                                  " a kérdőívet csak a szülői beleegyezést követően kapják meg. "
                                                  "A kérdőívek kiértékelése anonim "
                                                  "módon, a személyiségi jogok tiszteletben tartásával történik. A "
                                                  "kérdőívek kitöltésére a RedCap "
                                                  "webapplikáción kerül sor, melyhez a kitöltők egy erre a célra "
                                                  "létrehozott kutatási honlapon "
                                                  "kapnak hozzáférést. A kitöltött kérdőívek eredményei önálló "
                                                  "adatbázisba kerülnek, melyeket "
                                                  "kizárólag kutatási célokra használunk fel és csak a kutatásban "
                                                  "résztvevő kutatók férnek hozzá.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "Az adatok statisztikai "
                                                  "feldolgozása névtelen módon, összesítve történik, így az Ön és gyermeke "
                                                  "személyazonossága az orvosi "
                                                  "titoktartásnak, az adatvédelmi és a személyiségi jogok védelméről "
                                                  "szóló törvénynek "
                                                  "megfelelően teljes mértékben "
                                                  "ismeretlen marad. Az adatok kutatási célokat "
                                                  "szolgálnak.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A vizsgálatban való részvételnek nincs ismert hátránya.",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A vizsgálatért felelős "
                                                  "személy: Dr. Major János, főorvos, Bethesda Gyermekkórház "
                                                  "Fájdalomkezelő Centrum (1146 Budapest, Bethesda u. 3.).",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "A kutatáshoz az "
                                                  "Egészségügyi Tudományos Tanács Tudományos és Kutatásetikai Bizottsága "
                                                  "járult hozzá (engedélyszám).",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "Intézményi kutatás-etikai "
                                                  "bizottság elnöke: Dr. Hantos "
                                                  "Mónika (+36 1 364 "
                                                  "9020)\n"
                                                  "Független orvos (23/2002. (V. 9.) EüM rendelet alapján): dr. Gyömörei Beáta (+36 1 422 2825)",
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              ),

                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.01),

                            // MÁSODIK //
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is2TextVisible =
                                          !is2TextVisible; // Toggle
                                          // visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "BELEEGYEZŐ NYILATKOZAT SZÜLŐ (JOGI "
                                            "KÉPVISELŐ) RÉSZÉRE",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is2TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Hölgyem/Uram!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ahhoz, hogy az online "
                                                "bél-fókuszú hipnoterápia, az online mozgás-motivációs tréning (M3 "
                                                "Tréning), valamint az "
                                                "interdiszciplináris, multimodális fájdalomterápia programok hatékonyságát, "
                                                "valamint a kérdőívek adatait a program "
                                                "hatásvizsgálata szempontjából tudományosan "
                                                "elemezhessük, a személyiségjogok "
                                                "értelmében az Ön beleegyezése szükséges. Ezért kérjük, "
                                                "olvassa el és töltse ki az alábbi nyilatkozatot.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "NYILATKOZAT",
                                                style:
                                                MyTextStyles.vastagbekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                              textAlign:
                                              TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "Hozzájárulok, "
                                                          "hogy a Bethesda "
                                                          "Gyermekkórház a ",
                                                      style: MyTextStyles.bekezdes(
                                                      context),
                                                    ),
                                                    TextSpan(
                                                      text: '„Funkcionális hasi fájdalomzavarok online'
                                                        'hipnózis és '
                                                        'mozgás-motivációs '
                                                        'tréning kezelésének hatásvizsgálata tizenévesek körében” ',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "c. "
                                                        "tudományos "
                                                        "vizsgálatában, az általam kitöltött kérdőív adatai és az online bél-fókuszú "
                                                        "hipnoterápiával, az "
                                                        "online mozgás-motivációs tréninggel (M3 Tréning), valamint az "
                                                        "interdiszciplináris, "
                                                        "multimodális fájdalomterápiával kapcsolatos adatok, tudományos "
                                                        "felhasználásra kerüljenek. Kérjük, jelölje meg a megfelelő választ!",
                                                      style: MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Elfogadom ${' ' * 10}1. Igen"
                                                "${' ' * 10}2. Nem",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat menetéről és körülményeiről megfelelő és elfogadható felvilágosítást kaptam.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat a Helsinki Deklaráció szellemében történik.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                              ///////////////////////////////////////////////////////////
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.01),

                            ///// KEZDŐDIK /////

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is3TextVisible =
                                          !is3TextVisible; // Toggle
                                          // visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "TÁJÉKOZTATÓ KAMASZ VIZSGÁLATI "
                                        "SZEMÉLYEK SZÁMÁRA 12-14 ÉV KÖZÖTT",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is3TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Szülő!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // flex: 3,
                                              // Higher flex value for more space
                                              child: Text(
                                                "Köszönjük, hogy Ön és "
                                                    "gyermeke részt vesz "
                                                    "tudományos "
                                                    "vizsgálatunkban. "
                                                    "Ez a tájékoztató részletesen ismerteti a vizsgálatot, és benne az Ön és gyermeke szerepét. Ha bármilyen kérdése van, tegye fel azt a vizsgálatvezetőnek. Ha vállalkozik a részvételre, kérjük, fogadja el a beleegyező nyilatkozatot.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat neve: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "Funkcionális hasi "
                                                          "fájdalomzavarok online hipnózis és mozgás-motivációs "
                                                          "tréning kezelésének "
                                                          "hatásvizsgálata tizenévesek körében",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),
                                                    ),
                                                  ],
                                                ),
                                              ),),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat célkitűzései: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "A vizsgálatnak két"
                                                          " fő célja van. Az első, hogy az olyan fiatalok és "
                                                          "családjuk számára, aki "
                                                          "funkcionális hasi fájdalomzavarral (legalább 2 hónapja tartó visszatérő hasi "
                                                          "fájdalommal) élnek "
                                                          "online is elérhetővé tegyünk két terápiát, a mozgás-motivációs tréninget (M3 "
                                                          "Tréning) és a bél-fókuszú hipnózis "
                                                          "terápiát. Így sokkal egyszerűbben és gyorsabban tudnak "
                                                          "segítséget kapni a hasi panaszokkal élő fiatalok "
                                                          " a problémájukkal kapcsolatban. Ahhoz viszont, "
                                                          "hogy valóban hatékony terápiákat tudjunk "
                                                          "nyújtani, előbb meg kell vizsgálnunk ezen módszerek "
                                                          "hatékonyságát. Így a vizsgálat második "
                                                          "célkitűzése, hogy ezt a két online terápiát (M3 Tréning és "
                                                          "a bél-fókuszú hipnózis) egymással, a általános "
                                                          "gyermek-gasztroenterológiai kezelésekkel, "
                                                          "valamint az interdiszciplináris, multimodális fájdalomterápiás ellátással összehasonlítsuk.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat "
                                                          "menete: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "A "
                                                          "gyermek-gasztroenterológiai vizsgálatok végén, vagy ha a gyermekének a "
                                                          "panaszai az "
                                                          "alkalmazott terápia során nem változtak, és a panaszok alapján besorolható a "
                                                          "funkcionális hasi "
                                                          "fájdalomzavarok egyikébe (funkcionális diszpepszia, irritábilis bél szindróma, "
                                                          "hasi migrén, "
                                                          "máshova nem besorolt funkcionális hasi fájdalomzavar), akkor kutatásban való "
                                                          "részvétel "
                                                          "felajánlásra kerül. Ilyenkor a kezelő orvos a gasztroenterológiai vizsgálat végén Önnek "
                                                          "és gyermekének egy "
                                                          "QR-kódot ad, mely a vizsgálati honlapra fogja irányítani Önöket. A QR kód "
                                                          "beolvasására 3 nap áll rendelkezésre.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A honlapon "
                                                          "előszön is kérjük a vizsgálatba való ismételt beleegyezést. Ezután néhány információt "
                                                          "szükséges "
                                                          "megadniuk, melyek segítik a további kommunikációt Önök és kutatócsoport között. A "
                                                          "honlapon továbbá egy "
                                                          "kérdőívcsomagot "
                                                          "kell mind Önnek, mind pedig gyermekének kitöltenie. "
                                                          "Ezután történik "
                                                          "meg a különböző "
                                                          "vizsgálati ágakba történő, random besorolás és az egyéni kutatási "
                                                          "azonosítók kiosztása.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az öt vizsgálati ág:",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .all(20.0),
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "1.  A "
                                                      "gyermek-gasztroenterológus által javasolt terápia folytatása 12 hétig, majd ezt követően "
                                                      "online bél-fókuszú hipnózis terápia "
                                                      "további 12 hétig\n"
                                                      "2.  Online "
                                                      "mozgás-motivációs tréning (M3 Tréning) 12 hétig, majd ezt követően online bél-"
                                                      "fókuszú hipnózis terápia "
                                                      "további 12 hétig\n"
                                                      "3.  Online bél-fókuszú "
                                                      "hipnózis terápia további 12 hétig, majd ezt követően online mozgás-"
                                                      "motivációs tréning (M3 Tréning) "
                                                      "további 12 hétig\n"
                                                      "4.  A "
                                                      "gyermek-gasztroenterol"
                                                      "ógus által javasolt terápia folytatása 24 hétig\n"
                                                      "5.  Fél napos, "
                                                      "interdiszciplináris, multimodális fájdalomterápia, majd ezt követően 12 hét "
                                                      "múlva kontroll alkalom"
                                                  ,
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ), ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
///////////////////////////////////////////////////////////////////////////
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Amennyiben a panaszok a "
                                                    "kutatás kezdetétől számított 6 hónapon belül is fennálnak, úgy minden "
                                                    "résztvevőnek lehetősége "
                                                    "van részt venni a fél napos, interdiszciplináris, multimodális "
                                                    "fájdalomterápián.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás teljes "
                                                    "időtartama 9 hónap, mely során a kérdőíveket több alkalommal szükséges kitölteni "
                                                    "(3. hét, 6. hét, 9.hét, 12. hét, 15. hét, 18. hét, 21. hét és 24. hét). Erről automatikus emlékeztető e-"
                                                    "mailt küldünk ki az Ön és gyermeke részére.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatásban tervezetten 400 fő vesz részt.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás várható időtartama: 2024.04.15.-2026.12.31.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás helye: online, "
                                                    "otthon, az egyéni napirendnek megfelelően, valamint a Bethesda "
                                                    "Gyermekkórház Fájdalomkezelő Centrumában.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatban való "
                                                    "részvétel önkéntes. A vizsgálatba történő beleegyezés a beleegyező "
                                                    "nyilatkozat elfogadásával válik "
                                                    "érvényessé. Ellenkező esetben a kutatásban való részvétel nem "
                                                    "érvényes. A beleegyezés bármikor szóban vagy írásban, indokolás nélkül visszavonható.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kérdőívcsomag kitöltése "
                                                    "önkéntes, a kitöltők, valamint jogi képviselőjük beleegyező "
                                                    "nyilatkozatot írnak alá a "
                                                    "szakorvosi ellátást követően adataik tudományos célú felhasználására "
                                                    "vonatkozóan. A kiskorú tizenévesek"
                                                    " a kérdőívet csak a szülői beleegyezést követően kapják meg. "
                                                    "A kérdőívek kiértékelése anonim "
                                                    "módon, a személyiségi jogok tiszteletben tartásával történik. A "
                                                    "kérdőívek kitöltésére a RedCap "
                                                    "webapplikáción kerül sor, melyhez a kitöltők egy erre a célra "
                                                    "létrehozott kutatási honlapon "
                                                    "kapnak hozzáférést. A kitöltött kérdőívek eredményei önálló "
                                                    "adatbázisba kerülnek, melyeket "
                                                    "kizárólag kutatási célokra használunk fel és csak a kutatásban "
                                                    "résztvevő kutatók férnek hozzá.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az adatok statisztikai "
                                                    "feldolgozása névtelen módon, összesítve történik, így az Ön és gyermeke "
                                                    "személyazonossága az orvosi "
                                                    "titoktartásnak, az adatvédelmi és a személyiségi jogok védelméről "
                                                    "szóló törvénynek "
                                                    "megfelelően teljes mértékben "
                                                    "ismeretlen marad. Az adatok kutatási célokat "
                                                    "szolgálnak.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatban való részvételnek nincs ismert hátránya.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatért felelős "
                                                    "személy: Dr. Major János, főorvos, Bethesda Gyermekkórház "
                                                    "Fájdalomkezelő Centrum (1146 Budapest, Bethesda u. 3.).",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatáshoz az "
                                                    "Egészségügyi Tudományos Tanács Tudományos és Kutatásetikai Bizottsága "
                                                    "járult hozzá (engedélyszám).",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Intézményi kutatás-etikai "
                                                    "bizottság elnöke: Dr. Hantos "
                                                    "Mónika (+36 1 364 "
                                                    "9020)\n"
                                                    "Független orvos (23/2002. (V. 9.) EüM rendelet alapján): dr. Gyömörei Beáta (+36 1 422 2825)",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////////////////////////////
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.01),

                            // NEGYEDIK //

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is4TextVisible =
                                          !is4TextVisible; // Toggle
                                          // visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "BELEEGYEZŐ NYILATKOZAT KAMASZ "
                                        "RÉSZÉRE "
                                        "12-14 ÉV KÖZÖTT",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is4TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Hölgyem/Uram!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ahhoz, hogy az online "
                                                    "bél-fókuszú hipnoterápia, az online mozgás-motivációs tréning (M3 "
                                                    "Tréning), valamint az "
                                                    "interdiszciplináris, multimodális fájdalomterápia programok hatékonyságát, "
                                                    "valamint a kérdőívek adatait a program "
                                                    "hatásvizsgálata szempontjából tudományosan "
                                                    "elemezhessük, a személyiségjogok "
                                                    "értelmében az Ön beleegyezése szükséges. Ezért kérjük, "
                                                    "olvassa el és töltse ki az alábbi nyilatkozatot.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "NYILATKOZAT",
                                                style:
                                                MyTextStyles.vastagbekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "Hozzájárulok, "
                                                          "hogy a Bethesda "
                                                          "Gyermekkórház a ",
                                                      style: MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: '„Funkcionális hasi fájdalomzavarok online'
                                                          'hipnózis és '
                                                          'mozgás-motivációs '
                                                          'tréning kezelésének hatásvizsgálata tizenévesek körében” ',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "c. "
                                                          "tudományos "
                                                          "vizsgálatában, az általam kitöltött kérdőív adatai és az online bél-fókuszú "
                                                          "hipnoterápiával, az "
                                                          "online mozgás-motivációs tréninggel (M3 Tréning), valamint az "
                                                          "interdiszciplináris, "
                                                          "multimodális fájdalomterápiával kapcsolatos adatok, tudományos "
                                                          "felhasználásra kerüljenek. Kérjük, jelölje meg a megfelelő választ!",
                                                      style: MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Elfogadom ${' ' * 10}1. Igen"
                                                    "${' ' * 10}2. Nem",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat menetéről és körülményeiről megfelelő és elfogadható felvilágosítást kaptam.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat a Helsinki Deklaráció szellemében történik.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////////////////////////////
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.01),

                            //// ÖTÖDIK KEZDŐDIK ////

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is5TextVisible =
                                          !is5TextVisible; // Toggle
                                          // visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "TÁJÉKOZTATÓ KAMASZ VIZSGÁLATI "
                                        "SZEMÉLYEK SZÁMÁRA 15-18 ÉV KÖZÖTT",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is5TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Szülő!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // flex: 3,
                                              // Higher flex value for more space
                                              child: Text(
                                                "Köszönjük, hogy Ön és "
                                                    "gyermeke részt vesz "
                                                    "tudományos "
                                                    "vizsgálatunkban. "
                                                    "Ez a tájékoztató részletesen ismerteti a vizsgálatot, és benne az Ön és gyermeke szerepét. Ha bármilyen kérdése van, tegye fel azt a vizsgálatvezetőnek. Ha vállalkozik a részvételre, kérjük, fogadja el a beleegyező nyilatkozatot.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat neve: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "Funkcionális hasi "
                                                          "fájdalomzavarok online hipnózis és mozgás-motivációs "
                                                          "tréning kezelésének "
                                                          "hatásvizsgálata tizenévesek körében",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),
                                                    ),
                                                  ],
                                                ),
                                              ),),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat célkitűzései: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "A vizsgálatnak két"
                                                          " fő célja van. Az első, hogy az olyan fiatalok és "
                                                          "családjuk számára, aki "
                                                          "funkcionális hasi fájdalomzavarral (legalább 2 hónapja tartó visszatérő hasi "
                                                          "fájdalommal) élnek "
                                                          "online is elérhetővé tegyünk két terápiát, a mozgás-motivációs tréninget (M3 "
                                                          "Tréning) és a bél-fókuszú hipnózis "
                                                          "terápiát. Így sokkal egyszerűbben és gyorsabban tudnak "
                                                          "segítséget kapni a hasi panaszokkal élő fiatalok "
                                                          " a problémájukkal kapcsolatban. Ahhoz viszont, "
                                                          "hogy valóban hatékony terápiákat tudjunk "
                                                          "nyújtani, előbb meg kell vizsgálnunk ezen módszerek "
                                                          "hatékonyságát. Így a vizsgálat második "
                                                          "célkitűzése, hogy ezt a két online terápiát (M3 Tréning és "
                                                          "a bél-fókuszú hipnózis) egymással, a általános "
                                                          "gyermek-gasztroenterológiai kezelésekkel, "
                                                          "valamint az interdiszciplináris, multimodális fájdalomterápiás ellátással összehasonlítsuk.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A vizsgálat "
                                                          "menete: ",
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "A "
                                                          "gyermek-gasztroenterológiai vizsgálatok végén, vagy ha a gyermekének a "
                                                          "panaszai az "
                                                          "alkalmazott terápia során nem változtak, és a panaszok alapján besorolható a "
                                                          "funkcionális hasi "
                                                          "fájdalomzavarok egyikébe (funkcionális diszpepszia, irritábilis bél szindróma, "
                                                          "hasi migrén, "
                                                          "máshova nem besorolt funkcionális hasi fájdalomzavar), akkor kutatásban való "
                                                          "részvétel "
                                                          "felajánlásra kerül. Ilyenkor a kezelő orvos a gasztroenterológiai vizsgálat végén Önnek "
                                                          "és gyermekének egy "
                                                          "QR-kódot ad, mely a vizsgálati honlapra fogja irányítani Önöket. A QR kód "
                                                          "beolvasására 3 nap áll rendelkezésre.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "A honlapon "
                                                          "előszön is kérjük a vizsgálatba való ismételt beleegyezést. Ezután néhány információt "
                                                          "szükséges "
                                                          "megadniuk, melyek segítik a további kommunikációt Önök és kutatócsoport között. A "
                                                          "honlapon továbbá egy "
                                                          "kérdőívcsomagot "
                                                          "kell mind Önnek, mind pedig gyermekének kitöltenie. "
                                                          "Ezután történik "
                                                          "meg a különböző "
                                                          "vizsgálati ágakba történő, random besorolás és az egyéni kutatási "
                                                          "azonosítók kiosztása.",
                                                      style: MyTextStyles
                                                          .bekezdes(
                                                          context),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az öt vizsgálati ág:",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .all(20.0),
                                                // This ensures the text fits within the available space and wraps.
                                                child: Text(
                                                  "1.  A "
                                                      "gyermek-gasztroenterológus által javasolt terápia folytatása 12 hétig, majd ezt követően "
                                                      "online bél-fókuszú hipnózis terápia "
                                                      "további 12 hétig\n"
                                                      "2.  Online "
                                                      "mozgás-motivációs tréning (M3 Tréning) 12 hétig, majd ezt követően online bél-"
                                                      "fókuszú hipnózis terápia "
                                                      "további 12 hétig\n"
                                                      "3.  Online bél-fókuszú "
                                                      "hipnózis terápia további 12 hétig, majd ezt követően online mozgás-"
                                                      "motivációs tréning (M3 Tréning) "
                                                      "további 12 hétig\n"
                                                      "4.  A "
                                                      "gyermek-gasztroenterol"
                                                      "ógus által javasolt terápia folytatása 24 hétig\n"
                                                      "5.  Fél napos, "
                                                      "interdiszciplináris, multimodális fájdalomterápia, majd ezt követően 12 hét "
                                                      "múlva kontroll alkalom"
                                                  ,
                                                  style:
                                                  MyTextStyles.bekezdes(
                                                      context),
                                                  textAlign:
                                                  TextAlign.justify,
                                                ), ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),
///////////////////////////////////////////////////////////////////////////
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Amennyiben a panaszok a "
                                                    "kutatás kezdetétől számított 6 hónapon belül is fennálnak, úgy minden "
                                                    "résztvevőnek lehetősége "
                                                    "van részt venni a fél napos, interdiszciplináris, multimodális "
                                                    "fájdalomterápián.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás teljes "
                                                    "időtartama 9 hónap, mely során a kérdőíveket több alkalommal szükséges kitölteni "
                                                    "(3. hét, 6. hét, 9.hét, 12. hét, 15. hét, 18. hét, 21. hét és 24. hét). Erről automatikus emlékeztető e-"
                                                    "mailt küldünk ki az Ön és gyermeke részére.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatásban tervezetten 400 fő vesz részt.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás várható időtartama: 2024.04.15.-2026.12.31.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatás helye: online, "
                                                    "otthon, az egyéni napirendnek megfelelően, valamint a Bethesda "
                                                    "Gyermekkórház Fájdalomkezelő Centrumában.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatban való "
                                                    "részvétel önkéntes. A vizsgálatba történő beleegyezés a beleegyező "
                                                    "nyilatkozat elfogadásával válik "
                                                    "érvényessé. Ellenkező esetben a kutatásban való részvétel nem "
                                                    "érvényes. A beleegyezés bármikor szóban vagy írásban, indokolás nélkül visszavonható.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kérdőívcsomag kitöltése "
                                                    "önkéntes, a kitöltők, valamint jogi képviselőjük beleegyező "
                                                    "nyilatkozatot írnak alá a "
                                                    "szakorvosi ellátást követően adataik tudományos célú felhasználására "
                                                    "vonatkozóan. A kiskorú tizenévesek"
                                                    " a kérdőívet csak a szülői beleegyezést követően kapják meg. "
                                                    "A kérdőívek kiértékelése anonim "
                                                    "módon, a személyiségi jogok tiszteletben tartásával történik. A "
                                                    "kérdőívek kitöltésére a RedCap "
                                                    "webapplikáción kerül sor, melyhez a kitöltők egy erre a célra "
                                                    "létrehozott kutatási honlapon "
                                                    "kapnak hozzáférést. A kitöltött kérdőívek eredményei önálló "
                                                    "adatbázisba kerülnek, melyeket "
                                                    "kizárólag kutatási célokra használunk fel és csak a kutatásban "
                                                    "résztvevő kutatók férnek hozzá.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Az adatok statisztikai "
                                                    "feldolgozása névtelen módon, összesítve történik, így az Ön és gyermeke "
                                                    "személyazonossága az orvosi "
                                                    "titoktartásnak, az adatvédelmi és a személyiségi jogok védelméről "
                                                    "szóló törvénynek "
                                                    "megfelelően teljes mértékben "
                                                    "ismeretlen marad. Az adatok kutatási célokat "
                                                    "szolgálnak.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatban való részvételnek nincs ismert hátránya.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálatért felelős "
                                                    "személy: Dr. Major János, főorvos, Bethesda Gyermekkórház "
                                                    "Fájdalomkezelő Centrum (1146 Budapest, Bethesda u. 3.).",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A kutatáshoz az "
                                                    "Egészségügyi Tudományos Tanács Tudományos és Kutatásetikai Bizottsága "
                                                    "járult hozzá (engedélyszám).",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Intézményi kutatás-etikai "
                                                    "bizottság elnöke: Dr. Hantos "
                                                    "Mónika (+36 1 364 "
                                                    "9020)\n"
                                                    "Független orvos (23/2002. (V. 9.) EüM rendelet alapján): dr. Gyömörei Beáta (+36 1 422 2825)",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////////////////////////////
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                MediaQuery.of(context).size.width * 0.01),

                            // HATODIK //

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.bethesdacolor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          is6TextVisible =
                                          !is6TextVisible; // Toggle
                                          // visibility of the text
                                        });
                                      },
                                      child: Text(
                                        "BELEEGYEZŐ NYILATKOZAT KAMASZ "
                                        "RÉSZÉRE 15-18 ÉV KÖZÖTT",
                                        style:
                                        MyTextStyles.bekezdes(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: Visibility(
                                visible: is6TextVisible,
                                maintainState: true,
                                maintainAnimation: true,
                                maintainSize: false,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whitewhite,
                                    borderRadius: BorderRadius.circular(13),
                                    // Rounded corners
                                    boxShadow: [
                                      // Optional: add shadow for elevation effect
                                      BoxShadow(
                                        color: AppColors.bethesdacolor
                                            .withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0,
                                            5), // Shifts shadow downwards
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Tisztelt Hölgyem/Uram!",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Ahhoz, hogy az online "
                                                    "bél-fókuszú hipnoterápia, az online mozgás-motivációs tréning (M3 "
                                                    "Tréning), valamint az "
                                                    "interdiszciplináris, multimodális fájdalomterápia programok hatékonyságát, "
                                                    "valamint a kérdőívek adatait a program "
                                                    "hatásvizsgálata szempontjából tudományosan "
                                                    "elemezhessük, a személyiségjogok "
                                                    "értelmében az Ön beleegyezése szükséges. Ezért kérjük, "
                                                    "olvassa el és töltse ki az alábbi nyilatkozatot.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "NYILATKOZAT",
                                                style:
                                                MyTextStyles.vastagbekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                textAlign:
                                                TextAlign.justify,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Default text color
                                                    fontSize: 16,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "Hozzájárulok, "
                                                          "hogy a Bethesda "
                                                          "Gyermekkórház a ",
                                                      style: MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: '„Funkcionális hasi fájdalomzavarok online'
                                                          'hipnózis és '
                                                          'mozgás-motivációs '
                                                          'tréning kezelésének hatásvizsgálata tizenévesek körében” ',
                                                      style: MyTextStyles
                                                          .vastagbekezdes(
                                                          context),
                                                    ),
                                                    TextSpan(
                                                      text: "c. "
                                                          "tudományos "
                                                          "vizsgálatában, az általam kitöltött kérdőív adatai és az online bél-fókuszú "
                                                          "hipnoterápiával, az "
                                                          "online mozgás-motivációs tréninggel (M3 Tréning), valamint az "
                                                          "interdiszciplináris, "
                                                          "multimodális fájdalomterápiával kapcsolatos adatok, tudományos "
                                                          "felhasználásra kerüljenek. Kérjük, jelölje meg a megfelelő választ!",
                                                      style: MyTextStyles.bekezdes(
                                                          context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "Elfogadom ${' ' * 10}1. Igen"
                                                    "${' ' * 10}2. Nem",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat menetéről és körülményeiről megfelelő és elfogadható felvilágosítást kaptam.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03),
                                        Row(
                                          children: [
                                            Expanded(
                                              // This ensures the text fits within the available space and wraps.
                                              child: Text(
                                                "A vizsgálat a Helsinki Deklaráció szellemében történik.",
                                                style:
                                                MyTextStyles.bekezdes(
                                                    context),
                                                textAlign:
                                                TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////////////////////////////
                                ),
                              ),
                            ),



                            //// CHECKBOXOK KEZDŐDNEK ////

                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  checkColor:
                                      MaterialStateProperty.all(Colors.white),
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return AppColors
                                          .bethesdacolor; // Color of the tick background when selected
                                    }
                                    return Colors
                                        .grey; // Default color when not selected
                                  }),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                  CheckboxListTile(
                                    title: Text(
                                        "Elolvastam és megértettem a kutatás feltételeit, s benne az én szerepemet.",
                                        style: MyTextStyles.bekezdes(context)),
                                    value: _termsRead,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _termsRead = value!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                        "Hozzájárulok, hogy a Bethesda Gyermekkórház az adataimat kutatási és oktatási célra tárolja és felhasználja.",
                                        style: MyTextStyles.bekezdes(context)),
                                    value: _consentGiven,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _consentGiven = value!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      "Szülőm vagy gondviselőm is beleegyezik a kutatásba",
                                      style: MyTextStyles.bekezdes(context),
                                    ),
                                    value: _guardianAgreed,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _guardianAgreed = value!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05),
                            ElevatedButton(
                              onPressed: (_consentGiven && _guardianAgreed && _termsRead) ? () {
                                // Perform your action when all checkboxes are checked
                                // For example, navigate to the next screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Email()),
                                );
                              } : null,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bethesdacolor,
                                // Button color
                                foregroundColor: Colors.white,
                                // Text and icon color
                                padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal:
                                        24), // Padding inside the button
                              ),
                              child: Text(
                                "Tovább",
                                style: MyTextStyles.gomb(context),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColors.bethesdacolor,
                // Use your desired background color
                padding: const EdgeInsets.symmetric(vertical: 15),
                // Adjust padding as needed
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width *
                                  0.05), // Adjust the padding as necessary
                          child: Image.asset(
                            "assets/images/bethesda_white_logo_name.png",
                            // Replace with your logo asset path
                            width: MediaQuery.of(context).size.width *
                                0.05, // Adjust the size as necessary
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Magyarországi Református Egyház Bethesda Gyermekkórháza – 1146 Budapest, Bethesda utca 3. (Zugló)',
                            textAlign: TextAlign.center,
                            style: MyTextStyles.feherbekezdes(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width *
                                  0.05), // Adjust the padding as necessary
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '+36 1 920 6000',
                                style: MyTextStyles.feherbekezdes(context),

                              ),
                              Text(
                                'bethesda@bethesda.hu',
                                style: MyTextStyles.feherbekezdes(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


          ],  // children
          ),
        ),
      ),
    );
  }
}
