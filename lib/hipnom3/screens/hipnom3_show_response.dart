// ignore_for_file: must_be_immutable
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary

import 'dart:convert';
import 'package:bethesda_2/constants/colors.dart';
import 'package:bethesda_2/constants/styles.dart';
import 'package:provider/provider.dart';

import '../hipnom3_34_ModuleOpening_M3.dart';
import '../hipnom3_12_ModuleHipno.dart';
import '../hipnom3_56_ModuleHipno_page2.dart';
import '../hipnom3_78_ModuleM3_4het.dart';
import '../hipnom3_910_ModuleHipno_page3.dart';
import '../models/hipnom3_questions1.dart';
import '../providers/hipnom3_3_4_quiz_provider1.dart';
import '../providers/hipnom3_7_quiz_provider2.dart';
import '../providers/hipnom3_8_quiz_provider3.dart';
import '../providers/hipnom3_11_quiz_provider4.dart';
import '../providers/hipnom3_12_quiz_provider5.dart';
import '../screens/hipnom3_1_2_quiz_screen1.dart';
import '../screens/hipnom3_7_quiz_screen2.dart';
import '../screens/hipnom3_8_quiz_screen3.dart';
import '../screens/hipnom3_11_quiz_screen4.dart';
import '../screens/hipnom3_12_quiz_screen5.dart';
import '../screens/hipnom3_result_screen1.dart';
import '../screens/hipnom3_show_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowResponse extends StatefulWidget {
  final String? keyValue;
  const ShowResponse(this.keyValue, {super.key});

  @override
  State<ShowResponse> createState() => _ShowResponseState();
}

class _ShowResponseState extends State<ShowResponse> {
  List<Question> userResponse = [];
  // Map<String, List<String>> answeerMap = {};
  Map<String, List<String>> answeerMap = {};
   Map<String, List<String>> singleAnsweerMap = {};
  final List<String> _rankableOptions_ = ["1", "2", "3", "4"];
  var felirat_most = {
    1: "Kora reggel",
    2: "Délelőtt",
    3: "Kora Délután",
    4: "Délután-este"
  };
  final List<int> _Types = [1, 2, 3, 4];
  Future getUserResponses(List<Question> questionList) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString('user_response');

      if (jsonString != null) {
        Map<String, dynamic> decodedMap = json.decode(jsonString);
        setState(() {
          answeerMap = decodedMap.map(
            (key, value) => MapEntry(
              key,
              List<String>.from(value.map((item) => item as String)),
            ),
          );
        });
        singleAnsweerMap = filterMapByPrefixes(answeerMap, [
          '7'
        ]);
// print('DATAA  AAAAA ${singleAnsweerMap[singleAnsweerMap.keys.last]}');
        //  final quizProvider1 = Provider.of<QuizProvider1>(context);
        // singleAnsweerMap=;

        userResponse = questionList
            .where((question) => answeerMap.keys
                .contains(question.text.toString().split(':').first))
            .toList();
        setState(() {});
      }
      // print(' -=-=-=-=-=-$userResponse $answeerMap');
    } catch (e) {
      print('sdasdadas $e');
    }
  }

  Map<String, List<String>> filterMapByPrefixes(
      Map<String, List<String>> map, List<String> prefixes) {
    return map.entries
        .where(
            (entry) => prefixes.any((prefix) => entry.key.startsWith(prefix)))
        .fold({}, (previousMap, entry) {
      previousMap[entry.key] = List<String>.from(entry.value);
      return previousMap;
    });
  }

  bool showAllQuestion = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider1 = Provider.of<QuizProvider1>(context);
    return Scaffold(
      backgroundColor: AppColors.lightshade,
      body: Container(
        child: FutureBuilder(
            future: getUserResponses(quizProvider1.questions),
            builder: (context, snap) {
              return userResponse.isEmpty
                  ? const Center(
                      child: Text('Nem találunk válaszokat'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top:25, left: 50, right: 50),
                      child: ListView(
                        children: [
                          Builder(builder: (context) {
                            Question oneResponse;
                            oneResponse = quizProvider1.questions[30];
                            return Container(
                              width: MediaQuery.sizeOf(context).width,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(15),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'A terved az elkövetkező hétre:',
                                    style: MyTextStyles.huszonkettovastagyellow(context)
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      // height: MediaQuery.of(context).size.width *
                                      //     0.45,
                                      //width: MediaQuery.of(context).size.width * 0.2,
                                      // Make the cells narrower
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // Background color for the container
                                        border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 1.0),
                                        // Border color and width
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Border radius
                                      ),
                                      child:
                                          //ReorderableListView(
                                      ListView(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          // Header row
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min, // Minimize the size of the row to fit its children
                                                children: [
                                                  // Fixed width for "idősáv" cell
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        "idősáv",
                                                        style: TextStyle(color: Colors.grey.shade800),
                                                      ),
                                                      tileColor: Colors.grey.shade100,
                                                    ),
                                                  ),
                                                  // Days of the week cells
                                                  for (int i = 1; i <= 7; i++)  // Updated loop to include '7.nap'
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.05,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                      child: ListTile(
                                                        title: Center( // Center text within the cell
                                                          child: Text(
                                                            "$i.nap",
                                                            style: TextStyle(color: Colors.grey.shade800),
                                                          ),
                                                        ),
                                                        tileColor: Colors.grey.shade100,
                                                      ),
                                                    ),
                                                  // "Magabiztossági szint" cell
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        "Magabiztossági szint",
                                                        style: TextStyle(color: Colors.grey.shade800),
                                                      ),
                                                      tileColor: Colors.grey.shade100,
                                                    ),
                                                  ),
                                                  // "Segítők – hogyan?" cell
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        "Segítők – hogyan?",
                                                        style: TextStyle(color: Colors.grey.shade800),
                                                      ),
                                                      tileColor: Colors.grey.shade100,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Original rows
                                          for (int index1 = 0; index1 < _rankableOptions_.length; index1++)
                                            Padding(
                                              key: ValueKey(_rankableOptions_[index1]),
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.7,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: Builder(builder: (context) {
                                                  int myIndex = 9;

                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Consistent spacing
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.1,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: ListTile(
                                                          title: Text(
                                                            felirat_most[_Types[index1]]!,
                                                            style: TextStyle(color: Colors.grey.shade800),
                                                          ),
                                                          tileColor: Colors.grey.shade100,
                                                        ),
                                                      ),
                                                      for (int i = 0; i < myIndex; i++)
                                                        Builder(builder: (context) {
                                                          List<List<String>> dividedLists =
                                                          divideList(singleAnsweerMap[singleAnsweerMap.keys.last]!, myIndex);

                                                          return Container(
                                                            width: (i < 7)
                                                                ? MediaQuery.of(context).size.width * 0.05
                                                                : MediaQuery.of(context).size.width * 0.1,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                              borderRadius: BorderRadius.circular(8.0),
                                                            ),
                                                            child: ListTile(
                                                              title: Center(
                                                                child: Text(dividedLists[index1][i]),
                                                              ),
                                                              tileColor: Colors.grey.shade100,
                                                            ),
                                                          );
                                                        }),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                        ],
                                      ),),

                                    const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: MediaQuery.paddingOf(context).top,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllQuestion = !showAllQuestion;
                              });
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, left: 15),
                                child: Row(
                                  children: [
                                     Text(
                                      'Itt láthatod az eddigi válaszaid:',
                                      style: MyTextStyles.huszonkettovastagyellow(context)
                                    ),
                                    showAllQuestion == false
                                        ?  Icon(
                                            Icons.arrow_drop_down_sharp, color: AppColors.yellow)
                                        :  Icon(Icons.arrow_drop_up_sharp,  color: AppColors.yellow)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          showAllQuestion == false
                              ? const SizedBox.shrink()
                              :
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userResponse.length,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userResponse[index]
                                                      .requiresTextInput ==
                                                  true
                                              ? Container(
                                                  width: MediaQuery.sizeOf(
                                                          context)
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10),
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey,),

                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Kérdés: ${userResponse[index].text}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          'Válasz: ${answeerMap[userResponse[index].text.toString().split(':').first]!.join(' , ')}'),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : (userResponse[index]
                                                          .answers
                                                          .isNotEmpty &&
                                                      userResponse[index]
                                                              .answers
                                                              .first
                                                              .isScale ==
                                                          true)
                                                  ? Container(
                                                      width:
                                                          MediaQuery.sizeOf(
                                                                  context)
                                                              .width,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      padding:
                                                          const EdgeInsets
                                                              .all(15),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all(color: Colors.grey,),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Kérdés: ${userResponse[index].text}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          SliderTheme(
                                                            data: SliderTheme
                                                                    .of(context)
                                                                .copyWith(
                                                              trackHeight:
                                                                  12.0,
                                                              activeTrackColor:
                                                                  Colors
                                                                      .yellow,
                                                              inactiveTrackColor:
                                                                  AppColors
                                                                      .whitewhite,
                                                              thumbColor: Colors
                                                                  .grey
                                                                  .shade600,
                                                              overlayColor: Colors
                                                                  .grey
                                                                  .shade600
                                                                  .withOpacity(
                                                                      0.2),
                                                              valueIndicatorColor:
                                                                  Colors.grey
                                                                      .shade600,
                                                              thumbShape:
                                                                  const RoundSliderThumbShape(
                                                                      enabledThumbRadius:
                                                                          12.0),
                                                              overlayShape:
                                                                  const RoundSliderOverlayShape(
                                                                      overlayRadius:
                                                                          15.0),
                                                            ),
                                                            child: Slider(
                                                              value: double.parse(answeerMap[userResponse[
                                                                          index]
                                                                      .text
                                                                      .toString()
                                                                      .split(
                                                                          ':')
                                                                      .first]!
                                                                  .join(
                                                                      ' , ')),
                                                              min: 0.0,
                                                              max: 10.0,
                                                              divisions: 10,
                                                              label: double.parse(answeerMap[userResponse[index]
                                                                          .text
                                                                          .toString()
                                                                          .split(
                                                                              ':')
                                                                          .first]!
                                                                      .join(
                                                                          ' , '))
                                                                  .round()
                                                                  .toString(),
                                                              onChanged:
                                                                  (double
                                                                      value) {
                                                                // setState(() {
                                                                //   // _sliderValue = value;
                                                                // });
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : userResponse[index]
                                                              .requiresRadioOptions ==
                                                          true
                                                      ? Container(
                                                          width: MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration: BoxDecoration(
                                                              border: Border
                                                                  .all(color: Colors.grey,),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                'Kérdés: ${userResponse[index].text}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  'Válasz: ${answeerMap[userResponse[index].text.toString().split(':').first]!.join(' , ')}'),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              (userResponse[index]
                                                                          .allowsComment ==
                                                                      true)
                                                                  ? Text(
                                                                      'Komment ${answeerMap[userResponse[index].text.toString().split(':').first]!.toString().split('comment:').last.split(']').first}')
                                                                  : const SizedBox
                                                                      .shrink(),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : userResponse[index]
                                                                  .requiresRanking ==
                                                              true
                                                          ? Container(
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15),
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(color: Colors.grey,),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  Text(
                                                                    'Kérdés: ${userResponse[index].text}',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  userResponse[index].twoColumn ==
                                                                          true
                                                                      ? SizedBox(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              ...answeerMap[userResponse[index].text.toString().split(':').first]!.map((e) {
                                                                                return Row(
                                                                                  children: [
                                                                                    Text("${e.toString().split('%%').first} = ${e.toString().split('%%').last}"),
                                                                                  ],
                                                                                );
                                                                              })
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            ...answeerMap[userResponse[index].text.toString().split(':').first]!.map((e) {
                                                                              return Text(e.toString());
                                                                            })
                                                                          ],
                                                                        ),
                                                                  const SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : userResponse[index]
                                                                      .twoColumn ==
                                                                  true
                                                              ? Container(
                                                                  width: MediaQuery.sizeOf(
                                                                          context)
                                                                      .width,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                  decoration: BoxDecoration(
                                                                      border: Border
                                                                          .all(color: Colors.grey,),
                                                                      borderRadius:
                                                                          BorderRadius.circular(5)),
                                                                  child:
                                                                      Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Kérdés: ${userResponse[index].text}',
                                                                        style:
                                                                            const TextStyle(fontWeight: FontWeight.bold),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(userResponse[index].prosText),
                                                                          const SizedBox(
                                                                            width: 30,
                                                                          ),
                                                                          Text(userResponse[index].consText)
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      ...answeerMap[userResponse[index].text.toString().split(':').first]!
                                                                          .map((e) {
                                                                        return Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                                                                  width: 100,
                                                                                  child: Text(e.toString().split(':').first),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 30,
                                                                                ),
                                                                                Text(e.toString().split(':').last),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : userResponse[index]
                                                                          .requiresTable ==
                                                                      true
                                                                  ? Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                          .width,
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              10),
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                      decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey,),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Text(
                                                                            'Kérdés: ${userResponse[index].text}',
                                                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Container(
                                                                              width: MediaQuery.of(context).size.width * 0.85,
                                                                              height: MediaQuery.of(context).size.width * 0.30,
                                                                              //width: MediaQuery.of(context).size.width * 0.2,
                                                                              // Make the cells narrower
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                // Background color for the container
                                                                                border: Border.all(color: Colors.grey, width: 1.0),
                                                                                // Border color and width
                                                                                borderRadius: BorderRadius.circular(8.0), // Border radius
                                                                              ),
                                                                              child:
                                                                                  //ReorderableListView(
                                                                                  ListView(
                                                                                shrinkWrap: true,
                                                                                physics: const NeverScrollableScrollPhysics(),
                                                                                children: [
                                                                                  // Header row
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.7,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        border: Border.all(color: Colors.grey, width: 1.0),
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              border: Border.all(color: Colors.grey, width: 1.0),
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                            child: ListTile(
                                                                                              title: Text(
                                                                                                "idősáv",
                                                                                                style: TextStyle(color: Colors.grey.shade800),
                                                                                              ),
                                                                                              tileColor: Colors.grey.shade100,
                                                                                            ),
                                                                                          ),
                                                                                          for (int i = 1; i <= 7; i++)
                                                                                            Container(
                                                                                              width: MediaQuery.of(context).size.width * 0.05,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                              child: ListTile(
                                                                                                title: Text(
                                                                                                  "$i.nap",
                                                                                                  style: TextStyle(color: Colors.grey.shade800),
                                                                                                ),
                                                                                                tileColor: Colors.grey.shade100,
                                                                                              ),
                                                                                            ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                  // Original rows
                                                                                  for (int index1 = 0; index1 < _rankableOptions_.length; index1++)
                                                                                    Padding(
                                                                                      key: ValueKey(_rankableOptions_[index1]),
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                                                      child: Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.7,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          border: Border.all(color: Colors.grey.shade600, width: 1.0),
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: MediaQuery.of(context).size.width * 0.1,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                              child: ListTile(
                                                                                                title: Text(
                                                                                                  felirat_most[_Types[index1]]!,
                                                                                                  style: TextStyle(color: Colors.grey.shade800),
                                                                                                ),
                                                                                                tileColor: Colors.grey.shade100,
                                                                                              ),
                                                                                            ),
                                                                                            for (int i = 0; i < 7; i++)
                                                                                              Builder(builder: (context) {
                                                                                                List<List<String>> dividedLists = divideList(answeerMap[userResponse[index].text.toString().split(':').first]!, 7);

                                                                                                return Container(
                                                                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                    border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: ListTile(
                                                                                                    title: SizedBox(
                                                                                                      child: Center(
                                                                                                        child: Text(dividedLists[index1][i]),
                                                                                                      ),
                                                                                                    ),
                                                                                                    //     TextField(
                                                                                                    //   controller:
                                                                                                    //       TextEditingController(text: userResponse[index].userResponse![i]),
                                                                                                    //   // controller:
                                                                                                    //   //     myController,
                                                                                                    //   style:
                                                                                                    //       TextStyle(color: Colors.grey.shade800),
                                                                                                    // ),
                                                                                                    tileColor: Colors.grey.shade100,
                                                                                                  ),
                                                                                                );
                                                                                              }),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : userResponse[index].requiresTableBigger ==
                                                                          true
                                                                      ? Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width,
                                                                          margin:
                                                                              const EdgeInsets.symmetric(vertical: 10),
                                                                          padding:
                                                                              const EdgeInsets.all(15),
                                                                          decoration:
                                                                              BoxDecoration(border: Border.all(color: Colors.grey,), borderRadius: BorderRadius.circular(5)),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text(
                                                                                'Kérdés: ${userResponse[index].text}',
                                                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.85,
                                                                                  // height: MediaQuery.of(context).size.width * 0.45,
                                                                                  //width: MediaQuery.of(context).size.width * 0.2,
                                                                                  // Make the cells narrower
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    // Background color for the container
                                                                                    border: Border.all(color: Colors.grey, width: 1.0),
                                                                                    // Border color and width
                                                                                    borderRadius: BorderRadius.circular(8.0), // Border radius
                                                                                  ),
                                                                                  child:
                                                                                      //ReorderableListView(
                                                                                      ListView(
                                                                                    shrinkWrap: true,
                                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                                    children: [
                                                                                      // Header row
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.7,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.white,
                                                                                            border: Border.all(color: Colors.grey, width: 1.0),
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                          ),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: MediaQuery.of(context).size.width * 0.1,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                ),
                                                                                                child: ListTile(
                                                                                                  title: Text(
                                                                                                    "idősáv",
                                                                                                    style: TextStyle(color: Colors.grey.shade800),
                                                                                                  ),
                                                                                                  tileColor: Colors.grey.shade100,
                                                                                                ),
                                                                                              ),
                                                                                              for (int i = 1; i <= 7; i++)
                                                                                                Container(
                                                                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                    border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: ListTile(
                                                                                                    title: Text(
                                                                                                      "$i.nap",
                                                                                                      style: TextStyle(color: Colors.grey.shade800),
                                                                                                    ),
                                                                                                    tileColor: Colors.grey.shade100,
                                                                                                  ),
                                                                                                ),
                                                                                              Container(
                                                                                                width: MediaQuery.of(context).size.width * 0.1,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                ),
                                                                                                child: ListTile(
                                                                                                  title: Text(
                                                                                                    "Magabiztossági szint",
                                                                                                    style: TextStyle(color: Colors.grey.shade800),
                                                                                                  ),
                                                                                                  tileColor: Colors.grey.shade100,
                                                                                                ),
                                                                                              ),
                                                                                              userResponse[index].check == true
                                                                                                  ? Container(
                                                                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                      ),
                                                                                                      child: ListTile(
                                                                                                        title: Text(
                                                                                                          "Segítők – hogyan?",
                                                                                                          style: TextStyle(color: Colors.grey.shade800),
                                                                                                        ),
                                                                                                        tileColor: Colors.grey.shade100,
                                                                                                      ),
                                                                                                    )
                                                                                                  : const SizedBox.shrink()
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      // Original rows
                                                                                      for (int indexs = 0; indexs < _rankableOptions_.length; indexs++)
                                                                                        Padding(
                                                                                          key: ValueKey(_rankableOptions_[indexs]),
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                                                          child: Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.7,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              border: Border.all(color: Colors.grey, width: 1.0),
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                            child: Builder(builder: (context) {
                                                                                              int myIndex = userResponse[index].check == true ? 9 : 8;

                                                                                              return Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: ListTile(
                                                                                                      title: Text(
                                                                                                        felirat_most[_Types[indexs]]!,
                                                                                                        style: TextStyle(color: Colors.grey),
                                                                                                      ),
                                                                                                      tileColor: Colors.grey.shade100,
                                                                                                    ),
                                                                                                  ),
                                                                                                  for (int i = 0; i < myIndex; i++)
                                                                                                    Builder(builder: (context) {
                                                                                                      List<List<String>> dividedLists = divideList(answeerMap[userResponse[index].text.toString().split(':').first]!, myIndex);

                                                                                                      return Container(
                                                                                                        width: (i < 7) ? MediaQuery.of(context).size.width * 0.05 : MediaQuery.of(context).size.width * 0.1,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Colors.white,
                                                                                                          border: Border.all(color: Colors.grey, width: 1.0),
                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                        ),
                                                                                                        child: ListTile(
                                                                                                          title: SizedBox(
                                                                                                            child: Center(
                                                                                                              child: Text(dividedLists[indexs][i]),
                                                                                                            ),
                                                                                                          ),
                                                                                                          tileColor: Colors.grey.shade100,
                                                                                                        ),
                                                                                                      );
                                                                                                    }),
                                                                                                ],
                                                                                              );
                                                                                            }),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  )),
                                                                              const SizedBox(
                                                                                height: 10,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : const SizedBox
                                                                          .shrink()
                                        ],
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}

List<List<String>> divideList(List<String> list, int subListSize) {
  int length = list.length;
  return List.generate(
    (length / subListSize).ceil(),
    (index) => list.sublist(
      index * subListSize,
      (index + 1) * subListSize > length ? length : (index + 1) * subListSize,
    ),
  );
}
