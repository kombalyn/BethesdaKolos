import 'package:flutter/material.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'appbar-fiok.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Import all screens you want to navigate to
import '../m3/ModuleOpening_M3.dart';
import 'package:bethesda_2/m3/screens/quiz_screen1.dart';
import '../regisztracio/email_azonosito.dart';
import '../regisztracio/email_azonosito_2.dart';
import '../regisztracio/email_azonosito_3.dart';
import '../regisztracio/gdpr.dart';
import '../hipno/ModuleOpening.dart';

import '../hipno/ModuleHipno.dart';
import '../hipno/ModuleHipno_page2.dart';
import '../hipno/ModuleHipno_page3.dart';
import '../hipno/ModuleHipno_page4.dart';
import '../hipno/ModuleHipno_page5.dart';
import '../hipno/ModuleOpening_2.dart';
import '../m3/ModuleOpening_M3.dart';
import 'appbar-kutatas.dart';
import 'appbar-kapcsolat.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color iconColor;

  CustomAppBar({
    required this.title,
    this.backgroundColor = AppColors.yellow,
    this.iconColor = AppColors.yellow,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuVisible = false;
  late HomePageModel _model;

  late WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('wss://34.72.67.6:8089'),
    Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
  );

  int calculateDateDifference(String message) {
    try {
      // Először megkeressük a zárójelben lévő részt
      int startIndex = message.indexOf('(');
      int endIndex = message.indexOf(')');

      if (startIndex == -1 || endIndex == -1) {
        throw FormatException('Nem található zárójelben lévő rész');
      }

      // Kivesszük a zárójelben lévő részt és feldaraboljuk vesszők mentén
      String bracketsContent = message.substring(startIndex + 1, endIndex);
      List<String> parts = bracketsContent.split(',').map((e) => e.trim()).toList();

      // A 8,9,10-es indexű részek tartalmazzák a regisztrációs dátumot
      // Eltávolítjuk az idézőjeleket
      String year = parts[7].replaceAll("'", "").trim();   // 2024
      String month = parts[8].replaceAll("'", "").trim();  // 12
      String day = parts[9].replaceAll("'", "").trim();    // 01

      // Összeállítjuk a regisztrációs dátumot
      DateTime registrationDate = DateTime(
          int.parse(year),
          int.parse(month),
          int.parse(day)
      );

      // A jelenlegi dátum a zárójel után van
      String currentDateStr = message.substring(endIndex + 2); // +2 a vessző és szóköz miatt
      DateTime currentDate = DateTime.parse(currentDateStr);

      // Különbség számítása napokban
      return currentDate.difference(registrationDate).inDays;

    } catch (e) {
      print('Hiba történt a dátumok feldolgozása során: $e');
      return -1;
    }
  }


  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _model.textController1 = TextEditingController();
    _model.textController2 = TextEditingController();
    /*
    _controller = _controller = VideoPlayerController.asset('assets/videos/animation.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();

     */
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _toggleMenu(BuildContext context) {
    if (_isMenuVisible) {
      _hideMenu();
    } else {
      _showMenu(context);
    }
  }

  void _showMenu(BuildContext context) {
    setState(() {
      _isMenuVisible = true;
    });

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideMenu,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width >= 1024
                  ? MediaQuery.of(context).size.width *
                      0.15 // For laptops and larger screens
                  : MediaQuery.of(context).size.width >= 600
                      ? MediaQuery.of(context).size.width * 0.2 // For tablets
                      : MediaQuery.of(context).size.width * 0.3, // For phones
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(
                    -MediaQuery.of(context).size.width * 0.1, 49), //IDEEE
                child: Material(
                  elevation: 4,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMenuItem(context, 'Fiók',
                            appbar_fiok()), // Update to navigate to the desired screen
                        _buildMenuItem(context, 'A kutatás',
                            appbar_kutatas()), // Update to navigate to the desired screen
                        _buildMenuItem(context, 'Kapcsolat',
                            appbar_kapcsolat()), // Update to navigate to the desired screen
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _hideMenu() {
    setState(() {
      _isMenuVisible = false;
    });
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildMenuItem(BuildContext context, String text, Widget screen) {
    // Create a map for text and corresponding icons
    final iconMap = {
      'Fiók': Icons.account_circle,
      'A kutatás': Icons.menu_book,
      'Kapcsolat': Icons.info,
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.005,
        horizontal: MediaQuery.of(context).size.width * 0.005,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Cursor change on hover
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
            _hideMenu();
          },
          child: Row(
            children: [
              Icon(iconMap[text], color: widget.iconColor),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Text(
                text,
                style: MyTextStyles.nagybekezdesappbar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      scrolledUnderElevation: 3.0,
      elevation: 3,
      shadowColor: Colors.grey.shade300,
      leading: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    _channel = WebSocketChannel.connect(
                      //Uri.parse('wss://34.72.67.6:8089'),
                      Uri.parse('wss://szerver.hasifajdalomkezeles.hu:8089'),
                    );

                    //kerdes = "$_selectedLocaleId | $kerdes";
                    String? szov = _model.textController1?.text;
                    String? szov2 = _model.textController2?.text;
                    print("bejelentkezes|$szov-$szov2");
                    _channel.sink.add("bejelentkezes|$szov-$szov2");
                    //_channel.sink.add("bejelentkezes|adam@ali.com-azonosito");
                    _channel.stream.listen((message) {
                      print('Received message: $message');
                      print('idopont: $message');

                      int daysDifference = calculateDateDifference(message);
                      if (daysDifference >= 0) {
                        print('A két dátum között eltelt napok száma: $daysDifference');
                      } else {
                        print('Hiba történt a számítás során');
                      }

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                //TO DO AZONOSITO ES IDO ALAPJAN MELYIK NYILJON MEG
                                ModuleOpening(szov2!,0), //hipno
                            //ModuleOpening_M3('Azonosito'),
                            //hipnom3_ModuleHipno('Azonosito'),
                            // ModuleOpening_inter('Azonosito'),
                            //ModuleOpening_standardcare('Azonosito'),
                          ),
                        );

                    });

                    print("TODO: Küldes a szerverre");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Image.asset(
                        "assets/images/bethesda_gyermekkorhaz_logo.png",
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.title,
                style: MyTextStyles.fehercim(context),
              ),
            ),
            CompositedTransformTarget(
              link: _layerLink,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05),
                child: IconButton(
                  icon: Icon(Icons.more_horiz_sharp, color: Colors.white),
                  onPressed: () {
                    _toggleMenu(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      leadingWidth: MediaQuery.of(context).size.width,
    );
  }
}
