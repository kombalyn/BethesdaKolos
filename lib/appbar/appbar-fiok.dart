import 'package:flutter/material.dart';
import 'package:bethesda_2/home_page_model.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:url_launcher/url_launcher.dart';
import '../regisztracio/gdpr.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants/styles.dart'; // Make sure this path is correct based on where you placed the styles.dart file
import 'package:lottie/lottie.dart';
import '../main.dart';
export '../home_page_model.dart';
import 'dart:math';
import 'appbar.dart';
import 'appbar-kapcsolat.dart';
import 'package:intl/intl.dart'; // Add intl package for date formatting
import 'package:fl_chart/fl_chart.dart'; // Add fl_chart package to your pubspec.yaml
class DateProgressIndicator extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> signInDates; // List of dates when the user signed in

  DateProgressIndicator({
    required this.startDate,
    required this.endDate,
    required this.signInDates,
  });

  @override
  Widget build(BuildContext context) {
    final totalDays = endDate.difference(startDate).inDays + 1;
    final progress = (_calculateSignedInDays() / totalDays).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.whitewhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.whitewhite,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kezdés: ${DateFormat('yyyy-MM-dd').format(startDate)}",
                    style: MyTextStyles.bekezdes(context),
                  ),
                  Text(
                    "Befejezés: ${DateFormat('yyyy-MM-dd').format(endDate)}",
                    style: MyTextStyles.bekezdes(context),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Stack(
                children: [
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightshade,
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.bethesdacolor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Center(child: ActivityChart(
          startDate: startDate,
          endDate: endDate,
          signInDates: signInDates,
        ),),

      ],
    );
  }

  int _calculateSignedInDays() {
    return signInDates.where((date) => date.isAfter(startDate.subtract(Duration(days: 1))) && date.isBefore(endDate.add(Duration(days: 1)))).length;
  }
}class ActivityChart extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> signInDates;

  ActivityChart({
    required this.startDate,
    required this.endDate,
    required this.signInDates,
  });

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysBetween();
    final activity = _generateActivityData(days);

    return SizedBox(
      height: 200.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: days.length * 40.0, // Each bar takes 40px (adjust as needed)
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBorder: BorderSide(color: AppColors.bethesdacolor, width: 1),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final date = days[group.x.toInt()];
                        final isSignedIn = rod.toY == 1.0;
                        return BarTooltipItem(
                          isSignedIn ? 'Belépve' : 'Nem lépett be',
                          const TextStyle(
                            color: AppColors.bethesdacolor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < days.length) {
                            return Text(
                              DateFormat('MM/dd').format(days[index]),
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value == 1) {
                            return Container(
                              alignment: Alignment.centerRight, // Aligns the text to the right
                              child: Text(
                                '\n\nAktivitás  ',
                                style: MyTextStyles.kicsibekezdes(context),
                              ),
                            );
                          }
                          return const Text('');
                        },
                        interval: 1,
                        reservedSize: 70,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: _generateBarGroups(activity, 30.0), // Pass dynamic bar width
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> _generateDaysBetween() {
    List<DateTime> days = [];
    DateTime current = startDate;
    while (current.isBefore(endDate.add(Duration(days: 1)))) {
      days.add(current);
      current = current.add(Duration(days: 1));
    }
    return days;
  }

  List<int> _generateActivityData(List<DateTime> days) {
    return days.map((day) => signInDates.contains(day) ? 1 : 0).toList();
  }

  List<BarChartGroupData> _generateBarGroups(List<int> activity, double barWidth) {
    return List<BarChartGroupData>.generate(
      activity.length,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: activity[index].toDouble(),
            color: activity[index] == 1 ? AppColors.bethesdacolor : AppColors.lightshade,
            width: barWidth, // Set a consistent width for bars
            borderRadius: BorderRadius.zero, // Ensures bars are not rounded

          ),
        ],
      ),
    );
  }
}


class appbar_fiok extends StatelessWidget {
  const appbar_fiok({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fájdalomkezelés kutatás',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: false,
        cardTheme: CardTheme(
          color: AppColors.whitewhite,
        ),
      ),
      home: const Appbar_fiok(),
    );
  }
}

class Appbar_fiok extends StatefulWidget {
  const Appbar_fiok({Key? key}) : super(key: key);

  @override
  State<Appbar_fiok> createState() => _Appbar_fiokState();
}

class _Appbar_fiokState extends State<Appbar_fiok>
    with SingleTickerProviderStateMixin {
  late HomePageModel _model;
  late AnimationController _controller;

  late double _currentPointOnFunction = 0;
  late double _sliderValue = 0.0;
  late bool toggle = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _model = HomePageModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Kutatási fázis',
          backgroundColor: AppColors.bethesdacolor, // Optional: Override the default background color
          iconColor: AppColors.bethesdacolor,
        ),
        key: scaffoldKey,
        backgroundColor: AppColors.lightshade,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.width * 0.02,
                              MediaQuery.of(context).size.width * 0.03,
                              MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Card(
                              elevation: 5,
                              color: AppColors.whitewhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "A fiókod",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyles.bethesdabekezdes(context),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whitewhite,
                                borderRadius: BorderRadius.circular(0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.01,
                                  right: MediaQuery.of(context).size.width * 0.01,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.width * 0.01,
                                    ),
                                    DateProgressIndicator(
                                      startDate: DateTime(2024, 10, 1),
                                      endDate: DateTime(2024, 10, 31),
                                      signInDates: [
                                        DateTime(2024, 10, 1),
                                        DateTime(2024, 10, 2),
                                        DateTime(2024, 10, 4),
                                        DateTime(2024, 10, 7),
                                        DateTime(2024, 10, 9),
                                      ],
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.width * 0.02,
                                    ),
                                    Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(13),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.whitewhite,
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width * 0.01,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Eddigi kitűzőid:",
                                                style: MyTextStyles.bethesdabekezdes(context),
                                                textAlign: TextAlign.justify,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.width * 0.01,
                                              ),
                                              Table(
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                          MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bethesdabekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                          MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bethesdabekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                          MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bethesdabekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                          MediaQuery.of(context).size.width * 0.01,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bethesdabekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                            Text(
                                                              "",
                                                              style: MyTextStyles.bekezdes(context),
                                                              textAlign: TextAlign.justify,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.width * 0.03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
