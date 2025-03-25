import 'dart:math'; // Import this for generating random numbers
import 'package:flutter/material.dart';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';

class SidebarLayout extends StatefulWidget {
  final Map<String, Map<String, dynamic>> weekScreens;
  final String selectedWeek;
  final Map<String, TextStyle>? weekTextStyles;
  final Color rectangleColor;
  final String iconSuffix; // Pass the icon suffix like '_g', '_y', '_b', '_l'

  const SidebarLayout({
    Key? key,
    required this.weekScreens,
    required this.selectedWeek,
    this.weekTextStyles,
    this.rectangleColor = AppColors.blue,
    required this.iconSuffix, // Pass the icon suffix like "_g" or "_y"
  }) : super(key: key);

  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  List<String> remainingIcons = [];

  // Define a list of image paths from 1 to 7
  List<String> getIconPaths(String iconSuffix) {
    return [
      'assets/images/1icon$iconSuffix.png',
      'assets/images/2icon$iconSuffix.png',
      'assets/images/3icon$iconSuffix.png',
      'assets/images/4icon$iconSuffix.png',
      'assets/images/5icon$iconSuffix.png',
      'assets/images/6icon$iconSuffix.png',
      'assets/images/7icon$iconSuffix.png',
    ];
  }

  // Function to get a random icon path ensuring all are used once before repeating
  String getNextIcon(String iconSuffix) {
    // If the remaining icons list is empty, reset it with a fresh list
    if (remainingIcons.isEmpty) {
      remainingIcons = getIconPaths(iconSuffix);
    }

    Random random = Random();
    int randomIndex = random.nextInt(remainingIcons.length); // Get a random index
    String selectedIcon = remainingIcons[randomIndex]; // Get the icon at the random index

    // Remove the selected icon from the list so it's not reused until reset
    remainingIcons.removeAt(randomIndex);

    return selectedIcon; // Return the randomly selected icon path
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        color: Colors.white.withOpacity(1),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.03,
            left: MediaQuery.of(context).size.width * 0.03,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.white.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: widget.rectangleColor,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.003), // Adjust the value as needed
                        child: Text(
                          'Fájdalomkezelési kisokos',
                          textAlign: TextAlign.left,
                          style: MyTextStyles.huszonkettobekezdes(context),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                  child: _buildWeekListTileWithPadding(
                    context,
                    title: 'Üdvözlő - 1.hét',
                    weekIdentifier: '1.hét',
                    isFirst: true,
                    isLast: false,
                    screenBuilder: widget.weekScreens['1.hét']?['screenBuilder'],
                    isClickable: widget.weekScreens['1.hét']?['isClickable'] ?? false,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                  child: Text(
                    'Anyagok',
                    textAlign: TextAlign.left,
                    style: MyTextStyles.huszonegybekezdes(context),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
                  child: Column(
                    children: widget.weekScreens.keys.map((week) {
                      return Column(
                        children: [
                          _buildWeekListTileWithPadding(
                            context,
                            title: '$week',
                            weekIdentifier: week,
                            isFirst: false,
                            isLast: week == '12.hét',
                            screenBuilder: widget.weekScreens[week]?['screenBuilder'],
                            isClickable: widget.weekScreens[week]?['isClickable'] ?? false,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekListTileWithPadding(
      BuildContext context, {
        required String title,
        required String weekIdentifier,
        required bool isFirst,
        required bool isLast,
        required Widget Function(BuildContext)? screenBuilder,
        required bool isClickable,
      }) {
    bool isSelected = widget.selectedWeek == weekIdentifier;

    Widget topPadding = _buildPadding(context, isTop: true, isSelected: isSelected);
    Widget bottomPadding = _buildPadding(context, isTop: false, isSelected: isSelected);

    return Column(
      children: [
        topPadding,
        _buildWeekListTile(
          context,
          title,
          weekIdentifier,
          screenBuilder,
          isClickable,
        ),
        bottomPadding,
      ],
    );
  }

  Widget _buildWeekListTile(
      BuildContext context,
      String title,
      String weekIdentifier,
      Widget Function(BuildContext)? screenBuilder,
      bool isClickable,
      ) {
    bool isSelected = widget.selectedWeek == weekIdentifier;
    String statusText = isSelected ? 'Elérhető' : (isClickable ? 'Elérhető' : 'Zárolva');
    Color backgroundColor = isSelected ? AppColors.lightshade : AppColors.whitewhite;
    TextStyle textStyle = widget.weekTextStyles != null && widget.weekTextStyles!.containsKey(weekIdentifier)
        ? widget.weekTextStyles![weekIdentifier]!
        : MyTextStyles.vastagbekezdes(context);

    // Get the next available random icon path
    String assetPath = getNextIcon(widget.iconSuffix);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: ListTile(
        leading: Image.asset(assetPath, errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error); // Display an error icon if the image fails to load
        }), // Load the icon dynamically
        title: Text(
          title,
          style: textStyle,
        ),
        subtitle: Text(
          statusText,
          style: MyTextStyles.kicsibekezdes(context),
        ),
        onTap: isClickable && screenBuilder != null
            ? () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => screenBuilder(context),
            ),
          );
        }
            : null,
      ),
    );
  }

  Widget _buildPadding(BuildContext context, {required bool isTop, required bool isSelected}) {
    return Container(
      color: isSelected ? AppColors.lightshade : AppColors.whitewhite,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.01,
        decoration: BoxDecoration(
          color: AppColors.whitewhite,
          borderRadius: BorderRadius.only(
            bottomRight: isTop ? Radius.circular(isSelected ? 20.0 : 0.0) : Radius.zero,
            topRight: !isTop ? Radius.circular(isSelected ? 20.0 : 0.0) : Radius.zero,
          ),
        ),
      ),
    );
  }
}
