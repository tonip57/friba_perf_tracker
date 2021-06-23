import 'dart:convert';
import 'dart:ui';
import 'dart:async';

import 'package:friba_performance_tracker/fileManagement.dart' as fileManager;
import 'package:friba_performance_tracker/aboutWidget.dart';
import 'package:friba_performance_tracker/preThrow.dart';
import 'package:friba_performance_tracker/putting.dart';
import 'package:friba_performance_tracker/singleRound.dart';
import 'package:friba_performance_tracker/throwEvaluation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:friba_performance_tracker/feedback.dart' as roundFeedback;

class ToniMain extends StatefulWidget {
  final int numberOfHoles;
  final List<int> parList;
  final String courseName;
  final String layout;

  ToniMain(
      {@required this.courseName,
      @required this.numberOfHoles,
      @required this.parList,
      @required this.layout});

  @override
  _ToniMainState createState() => _ToniMainState();
}

class _ToniMainState extends State<ToniMain> {
  List holeList = [];

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final String formattedDate = formatter.format(now);

  int numberOfHoles;
  List<int> parList;
  String courseName;
  String layout;
  int startTime;
  int endTime;

  List scoreList = [];
  String scoreString = '+0';
  String jsonString;
  var jsonMap = {
    '"course"': "0",
    '"layout"': "0",
    '"par"': 0,
    '"date"': "0",
    '"startTime"': "0",
    '"endTime"': "0",
    '"throwsTotal"': 0,
    '"kindsOfThrows"': [],
    '"putts"': [],
    '"holes"': []
  };

  List jsonHoleList = [];

  List puttList = [
    {'"ring"': '"<4m"', '"made"': 0, '"missed"': 0},
    {'"ring"': '"4–6m"', '"made"': 0, '"missed"': 0},
    {'"ring"': '"6–8m"', '"made"': 0, '"missed"': 0},
    {'"ring"': '"8–10m"', '"made"': 0, '"missed"': 0},
    {'"ring"': '">10m"', '"made"': 0, '"missed"': 0}
  ];

  Map<String, List> holesAndThrows = Map();
  List throwEvaluationList = [];

  String holeChoose;
  String throwChoose;
  List throwList = ["Throw 1"];
  List throwListOfLists = [];

  List<bool> isTypeSelected = [true, false, false];
  List<bool> isStyleSelected = [true, false, false];
  String typeChosen;
  String styleChosen;
  String throwEvaluation;

  String screenTitle = "PRE-THROW";

  PreThrow preThrow;
  ThrowEvaluation throwEvaluationPage;
  Putting puttingPage;
  Widget currentPage;

  @override
  void initState() {
    numberOfHoles = widget.numberOfHoles;
    parList = widget.parList;
    courseName = '"' + widget.courseName + '"';
    layout = '"' + widget.layout + '"';

    print('$numberOfHoles $parList $courseName');

    super.initState();
    print(formattedDate);
    startTime = DateTime.now().millisecondsSinceEpoch;
    preThrow = PreThrow(this.toThrowEvaluation, this.toPutting,
        this.addTypeChosen, this.addStyleChosen);
    currentPage = preThrow;
    holeChoose = "Hole 1";
    throwChoose = "Throw 1";
    makeHoleList();
    makeThrowListOfLists();
    addTypeChosen(0);
    addStyleChosen(0);
    throwEvaluation = "Center";
    makeThrowEvaluationList();
    makeScoreList();
  }

/*   Future<void> _read() async {
    String text;
    try {l
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/playedRounds.json');
      text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
      print(e);
    }
  } */

  //counts throwdata to jsonMap as "BackhandDriveCenter": 1,
  List countThrowData() {
    List countThrowList = [];
    List countList = [];

    for (var i = 1; i <= numberOfHoles; i++) {
      for (var x = 1; x <= holesAndThrows["Hole " + i.toString()].length; x++) {
        if (holesAndThrows["Hole " + i.toString()][x - 1][1] != "Penalty") {
          if (holesAndThrows["Hole " + i.toString()][x - 1][2] != "Putt") {
            String throwString = holesAndThrows["Hole " + i.toString()][x - 1]
                    [1] +
                holesAndThrows["Hole " + i.toString()][x - 1][2] +
                holesAndThrows["Hole " + i.toString()][x - 1][3];
            print(throwString);
            countList.add(throwString);
          }
        } else {
          countList.add("Penalty");
        }
      }
    }

    while (countList.isNotEmpty) {
      String element = countList[0];
      var foundElements = countList.where((e) => e == element);
      int count = foundElements.length;
      countList.removeWhere((item) => item == element);
      var countMap = {
        '"' + element + '"': count,
      };
      countThrowList.add(countMap);
    }

    return countThrowList;
  }

  //Saves all needed data to jsonMap after round has ended
  Future<bool> saveJsonString() async {
    jsonMap['"course"'] = courseName;
    jsonMap['"layout"'] = layout;
    jsonMap['"par"'] = calculateCoursePar();
    jsonMap['"date"'] = '"' + formattedDate + '"';
    jsonMap['"startTime"'] = startTime;
    jsonMap['"endTime"'] = endTime;
    jsonMap['"throwsTotal"'] = calculateTotalThrows();
    jsonMap['"kindsOfThrows"'] = countThrowData();
    jsonMap['"putts"'] = countPuttsToJsonMap();
    jsonMap['"holes"'] = countThrowsToJsonMap();

    String jsonMapAsString = jsonMap.toString();
    await fileManager.write(jsonMapAsString);

    return true;
  }

  //Adds throws to jsonMap as "holeNumber: 1 {throws: [Throw 1, Drive, Backhand, Center, Missed]}"
  List countThrowsToJsonMap() {
    for (var i = 1; i <= numberOfHoles; i++) {
      var holeJsonMap = {
        '"holeNumber"': i,
        '"holePar"': parList[i - 1],
        '"throws"': [],
      };
      List jsonThrowList = [];
      for (var x = 1; x <= holesAndThrows["Hole " + i.toString()].length; x++) {
        if (holesAndThrows["Hole " + i.toString()][x - 1][1] == "Penalty") {
          var throwJsonMap = {'"throwNumber"': x, '"penalty"': true.toString()};
          jsonThrowList.add(throwJsonMap);
        } else if (holesAndThrows["Hole " + i.toString()][x - 1][2] == "Putt") {
          bool wentIn;
          if (holesAndThrows["Hole " + i.toString()][x - 1][3] == "Made") {
            wentIn = true;
          } else {
            wentIn = false;
          }
          var throwJsonMap = {
            '"throwNumber"': x,
            '"type"': '"Putt"',
            '"puttLength"':
                '"' + holesAndThrows["Hole " + i.toString()][x - 1][1] + '"',
            '"penalty"': false,
            '"wentIn"': wentIn
          };
          jsonThrowList.add(throwJsonMap);
        } else {
          bool wentIn;
          if (holesAndThrows["Hole " + i.toString()][x - 1][4] == "Made") {
            wentIn = true;
          } else {
            wentIn = false;
          }
          var throwJsonMap = {
            '"throwNumber"': x,
            '"type"':
                '"' + holesAndThrows["Hole " + i.toString()][x - 1][1] + '"',
            '"style"':
                '"' + holesAndThrows["Hole " + i.toString()][x - 1][2] + '"',
            '"evaluation"':
                '"' + holesAndThrows["Hole " + i.toString()][x - 1][3] + '"',
            '"penalty"': false,
            '"wentIn"': wentIn,
          };
          jsonThrowList.add(throwJsonMap);
        }
      }
      holeJsonMap['"throws"'] = jsonThrowList;
      jsonHoleList.add(holeJsonMap);
    }
    return jsonHoleList;
  }

  //Adds putts to jsonMap as "{Ring: <4, Made: 0, Missed: 0}"
  List countPuttsToJsonMap() {
    for (var i = 1; i <= numberOfHoles; i++) {
      for (var x = 1; x <= holesAndThrows["Hole " + i.toString()].length; x++) {
        if (holesAndThrows["Hole " + i.toString()][x - 1][1] != "Penalty") {
          if (holesAndThrows["Hole " + i.toString()][x - 1][2] == "Putt") {
            for (var y = 1; y <= puttList.length; y++) {
              if (puttList[y - 1]['"ring"'].toString() ==
                  '"' +
                      holesAndThrows["Hole " + i.toString()][x - 1][1] +
                      '"') {
                if (holesAndThrows["Hole " + i.toString()][x - 1][3] ==
                    "Made") {
                  puttList[y - 1]['"made"'] = puttList[y - 1]['"made"'] + 1;
                } else if (holesAndThrows["Hole " + i.toString()][x - 1][3] ==
                    "Missed") {
                  puttList[y - 1]['"missed"'] = puttList[y - 1]['"missed"'] + 1;
                }
              }
            }
          }
        }
      }
    }

    return puttList;
  }

  //Calculates course par from the parList
  int calculateCoursePar() {
    int total = 0;
    for (var elem in parList) {
      total = total + elem;
    }
    return total;
  }

  //Calculates total throws from scoreList
  int calculateTotalThrows() {
    int total = 0;
    for (var elem in scoreList) {
      total = total + elem;
    }
    return total;
  }

  //Creates scoreList based on numberOfHoles
  void makeScoreList() {
    for (var i = 1; i <= numberOfHoles; i++) {
      scoreList.add(0);
    }
    print(scoreList);
  }

  //Resets throw selections when coming back to pre-throw -screen
  void resetSelections() {
    typeChosen = "Drive";
    styleChosen = "Backhand";
    throwEvaluation = "Center";
  }

  //Creates throwEvaluationList based on numberOfHoles
  void makeThrowEvaluationList() {
    for (var i = 1; i <= numberOfHoles; i++) {
      throwEvaluationList.add([]);
    }
  }

  //Checks if a shot was made and removes all Throws after that one
  void checkIfShotMade(String missedOrMade) {
    String aStr = holeChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int holeInt = int.parse(aStr);

    String bStr = throwChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int throwInt = int.parse(bStr);

    int l = throwEvaluationList[holeInt - 1].length - 1;

    if (missedOrMade == "Made") {
      for (var i = throwInt; i <= l; i++) {
        throwEvaluationList[holeInt - 1].removeAt(throwInt);
      }
      holesAndThrows.addAll({holeChoose: throwEvaluationList[holeInt - 1]});
    }
  }

  //Adds putt to holesAndThrowsMap
  void addPuttToHolesAndThrowsMap(String length, String missedOrMade) {
    String aStr = holeChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int holeInt = int.parse(aStr);

    String bStr = throwChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int throwInt = int.parse(bStr);

    throwEvaluationList[holeInt - 1]
        .insert(throwInt - 1, [throwChoose, length, "Putt", missedOrMade]);

    if (throwInt < throwList.length) {
      throwEvaluationList[holeInt - 1].removeAt(throwInt);
    }

    holesAndThrows.addAll({holeChoose: throwEvaluationList[holeInt - 1]});

    checkIfShotMade(missedOrMade);
    resetSelections();
  }

  //Adds Throw to holesAndThrowsMap
  void addToHolesAndThrowsMAP(String missedOrMade) {
    String aStr = holeChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int holeInt = int.parse(aStr);

    String bStr = throwChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int throwInt = int.parse(bStr);

    throwEvaluationList[holeInt - 1].insert(throwInt - 1,
        [throwChoose, typeChosen, styleChosen, throwEvaluation, missedOrMade]);

    if (throwInt < throwList.length) {
      throwEvaluationList[holeInt - 1].removeAt(throwInt);
    }

    holesAndThrows.addAll({holeChoose: throwEvaluationList[holeInt - 1]});

    checkIfShotMade(missedOrMade);
    resetSelections();
  }

  //Changes shot type on button press
  void addTypeChosen(int index) {
    if (index == 0) {
      typeChosen = "Drive";
    }
    if (index == 1) {
      typeChosen = "Mid-Range";
    }
    if (index == 2) {
      typeChosen = "Approach";
    }

    print(typeChosen);
  }

  //Changes shot style on button press
  void addStyleChosen(int index) {
    if (index == 0) {
      styleChosen = "Backhand";
    }
    if (index == 1) {
      styleChosen = "Forehand";
    }
    if (index == 2) {
      styleChosen = "Other";
    }

    print(styleChosen);
  }

  //Changes throwEvaluation on button press
  void addThrowEvaluation(int index) {
    if (index == 0) {
      throwEvaluation = "LongLeft";
    }
    if (index == 1) {
      throwEvaluation = "LongCenter";
    }
    if (index == 2) {
      throwEvaluation = "LongRight";
    }
    if (index == 3) {
      throwEvaluation = "CenterLeft";
    }
    if (index == 4) {
      throwEvaluation = "Perfect";
    }
    if (index == 5) {
      throwEvaluation = "CenterRight";
    }
    if (index == 6) {
      throwEvaluation = "ShortLeft";
    }
    if (index == 7) {
      throwEvaluation = "ShortCenter";
    }
    if (index == 8) {
      throwEvaluation = "ShortRight";
    }

    print(throwEvaluation);
  }

  //Creates holeList based on numberOfHoles. Used for dropdownbutton
  void makeHoleList() {
    for (var i = 1; i <= numberOfHoles; i++) {
      holeList.add("Hole " + i.toString());
    }
  }

  //Creates throwList based on numberOfHoles. Used for dropdownbutton
  void makeThrowListOfLists() {
    for (var i = 1; i <= numberOfHoles; i++) {
      throwListOfLists.add(["Throw 1"]);
    }
  }

  //Changes correct throwList for picked hole
  void changeHoleAndThrowList() {
    for (var i = 1; i <= numberOfHoles; i++) {
      if (holeChoose == "Hole " + i.toString()) {
        throwList = throwListOfLists[i - 1];
        print("Throw list changed to list " + (i).toString());
        throwChoose = "Throw " + throwListOfLists[i - 1].length.toString();
      }
    }
  }

  //Opens throw evaluation screen
  void toThrowEvaluation() {
    setState(() {
      screenTitle = "THROW-EVALUATION";
      throwEvaluationPage = ThrowEvaluation(
          this.backToPreThrowWENTIN,
          this.backToPreThrowNEXTSHOT,
          this.addThrowEvaluation,
          this.addToHolesAndThrowsMAP);

      currentPage = throwEvaluationPage;
    });
  }

  //Opens putting screen
  void toPutting() {
    setState(() {
      screenTitle = "PUTTING";
      puttingPage = Putting(this.backToPreThrowWENTIN,
          this.backToPreThrowNEXTSHOT, this.addPuttToHolesAndThrowsMap);
      currentPage = puttingPage;
    });
  }

  //Navigates back to pre-throw if not already. Else asks for quitting the game
  void toPreThrowBACKBUTTON() {
    setState(() {
      screenTitle = "PRE-THROW";
      preThrow = PreThrow(this.toThrowEvaluation, this.toPutting,
          this.addTypeChosen, this.addStyleChosen);
      currentPage = preThrow;
      print("BACK BUTTON");
    });
  }

  //Going back to pre-throw after "went in" is pressed
  void backToPreThrowWENTIN() async {
    screenTitle = "PRE-THROW";
    this.currentPage = preThrow;
    print("WENT IN");
    int indexOfItem = throwList.indexOf(throwChoose);
    int listLength = throwList.length;

    if (listLength > indexOfItem) {
      for (var i = 1; i <= listLength - indexOfItem; i++) {
        throwList.remove("Throw " + (indexOfItem + i + 1).toString());
      }
    }

    if (holeChoose != "Hole " + holeList.length.toString()) {
      holeChoose = "Hole " + (holeList.indexOf(holeChoose) + 2).toString();
    }

    calculateScore();
    int end = checkIfRoundEnded();
    print("Holes played: " + end.toString());
    if (end == numberOfHoles) {
      print("KIERROS LOPPU");
      endTime = DateTime.now().millisecondsSinceEpoch;
      bool success = await saveJsonString();

      if (success) {
        // Pops "out of" this object (throw-evaluation) and opens feedback.
        Navigator.pop(context, true);
      }

      var roundData = new SingleRound.fromJson(jsonDecode(jsonMap.toString()));

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        final snackBar = SnackBar(
          content: Text(
            "Round finished!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[500],
        );

        return roundFeedback.Feedback(
          roundData: roundData,
          snackBar: snackBar,
          index: 0,
        );
      }));
    } else {
      changeHoleAndThrowList();
    }
    setState(() {});
  }

  //Calculates score and calls checkIfRoundEnded. If end == numberOfHoles, then feedback page is opened
  void calculateScore() {
    for (var i = 1; i <= numberOfHoles; i++) {
      if (throwEvaluationList[i - 1].isNotEmpty) {
        int throwCount = 0;
        for (var x = 1; x <= throwEvaluationList[i - 1].length; x++) {
          throwCount++;
          scoreList[i - 1] = throwCount;
        }
      }
    }
    print(scoreList);
    print(parList);

    scoreString = scoreString.substring(1);
    int score = int.parse(scoreString);
    int allScores = 0;

    for (var i = 1; i <= numberOfHoles; i++) {
      if (scoreList[i - 1] != 0) {
        score = scoreList[i - 1] - parList[i - 1];
        allScores = allScores + score;
      }
    }

    if (allScores >= 0) {
      scoreString = "+" + allScores.toString();
    } else {
      scoreString = allScores.toString();
    }
  }

  int checkIfRoundEnded() {
    int end = 0;

    for (var i = 1; i <= numberOfHoles; i++) {
      if (throwEvaluationList[i - 1].isNotEmpty) {
        if (throwEvaluationList[i - 1].last.last == "Made") {
          end++;
        }
      }
    }
    return end;
  }

  //Adds penaltythrow to throwList
  void addPenalty() {
    throwList.add("Throw " + (throwList.length + 1).toString());
    print(throwChoose);
    String aStr = holeChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int holeInt = int.parse(aStr);
    int l = throwEvaluationList[holeInt - 1].length - 1;

    String bStr = throwChoose.replaceAll(new RegExp(r'[^0-9]'), '');
    int throwInt = int.parse(bStr);

    throwEvaluationList[holeInt - 1]
        .insert(throwInt, ["Throw " + (throwInt + 1).toString(), "Penalty"]);
    throwList.add("Throw " + (throwList.length + 1).toString());

    if (throwInt < throwList.length - 3) {
      if (throwEvaluationList[holeInt - 1][throwInt + 1].last == "Penalty") {
        throwEvaluationList[holeInt - 1].removeAt(throwInt + 1);
      } else {
        int length = throwEvaluationList[holeInt - 1].length - 1;
        var n = throwInt + 1;
        do {
          throwEvaluationList[holeInt - 1][n][0] =
              "Throw " + (n + 1).toString();
          n++;
        } while (n <= length);
      }
      int x = throwEvaluationList[holeInt - 1].length - 1;
      int tllen =
          throwList.length - (throwEvaluationList[holeInt - 1].length - 1);
      do {
        print(x);
        throwList.removeLast();
        x++;
      } while (x <= tllen);
    } else if (throwInt < throwList.length - 2) {
      int x = throwEvaluationList[holeInt - 1].length;
      int tllen =
          throwList.length - (throwEvaluationList[holeInt - 1].length - 1);
      do {
        print(x);
        throwList.removeLast();
        x++;
      } while (x <= tllen);
    }
  }

  //Going back to pre-throw screen when "next shot" is pressed
  void backToPreThrowNEXTSHOT(bool penalty) {
    setState(() {
      screenTitle = "PRE-THROW";
      String aStr = holeChoose.replaceAll(new RegExp(r'[^0-9]'), '');
      int holeInt = int.parse(aStr);
      this.currentPage = preThrow;
      print("NEXT SHOT");

      if (throwList.length < throwEvaluationList[holeInt - 1].length) {
        throwEvaluationList[holeInt - 1].removeLast();
      }

      if (penalty == true) {
        addPenalty();
      }

      if (throwChoose == "Throw " + (throwList.length).toString()) {
        throwList.add("Throw " + (throwList.length + 1).toString());
      }

      for (var i = 1; i <= numberOfHoles; i++) {
        if (holeChoose == "Hole " + i.toString()) {
          throwListOfLists[i - 1] = throwList;
        }
      }

      throwChoose = ("Throw " + (throwList.length).toString());
    });

    print("lopulliset");
    print(throwListOfLists);
    print(throwList);
    print(holesAndThrows);
  }

  //Asks if user really wants to quit
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit round?'),
            content: Text('Your round will not be saved!'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
          home: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0), // here the desired height
                child: AppBar(
                  title: new Center(
                      child:
                          new Text(screenTitle, textAlign: TextAlign.center)),
                  leading: IconButton(
                      // Opens exit dialog if on throw-evaluation page
                      onPressed: () {
                        if (screenTitle != "PRE-THROW") {
                          toPreThrowBACKBUTTON();
                        } else {
                          _onWillPop();
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  elevation: 0.0,
                  actions: [
                    IconButton(
                        onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (context) => AboutWidget(screenTitle),
                              ),
                            },
                        icon: Icon(Icons.contact_support_outlined))
                  ],
                ),
              ),
              body: SafeArea(
                  child: Column(children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height / 9.4,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Text(
                            scoreString,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.white),
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                )),
                            child: new DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                iconEnabledColor: Colors.white,
                                isExpanded: true,
                                value: holeChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    holeChoose = newValue;
                                    changeHoleAndThrowList();
                                  });
                                },
                                selectedItemBuilder: (_) {
                                  return holeList
                                      .map((e) => Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              e,
                                              style: new TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                      .toList();
                                },
                                items: holeList.map((valueItem) {
                                  return DropdownMenuItem(
                                    child: SizedBox(
                                      width: 100.0, // for example
                                      child: Text(
                                        valueItem,
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    value: valueItem,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.white),
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                )),
                            child: new DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                iconEnabledColor: Colors.white,
                                isExpanded: true,
                                value: throwChoose,
                                onChanged: (newThrow) {
                                  setState(() {
                                    throwChoose = newThrow;
                                  });
                                },
                                selectedItemBuilder: (_) {
                                  return throwList
                                      .map((e) => Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              e,
                                              style: new TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                      .toList();
                                },
                                items: throwList.map((throwNumber) {
                                  return DropdownMenuItem(
                                    child: SizedBox(
                                      width: 100.0, // for example
                                      child: Text(
                                        throwNumber,
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    value: throwNumber,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: currentPage,
                ),
                //TabBarView(children: [ImageList(),])
              ])))),
    );
  }
}
