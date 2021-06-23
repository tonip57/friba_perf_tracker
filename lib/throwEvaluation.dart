import 'dart:ui';

import 'package:flutter/material.dart';

class ThrowEvaluation extends StatefulWidget {
  final Function backToPreThrowNEXTSHOT;
  final Function backToPreThrowWENTIN;
  final Function addThrowEvaluation;
  final Function addToHolesAndThrowsMAP;

  //Geeting functions from toniMain
  ThrowEvaluation(this.backToPreThrowWENTIN, this.backToPreThrowNEXTSHOT,
      this.addThrowEvaluation, this.addToHolesAndThrowsMAP);

  @override
  _ThrowEvaluation createState() => _ThrowEvaluation();
}

class _ThrowEvaluation extends State<ThrowEvaluation> {
  List<bool> toggleButtons1 = [false, false, false];
  List<bool> toggleButtons2 = [false, true, false];
  List<bool> toggleButtons3 = [false, false, false];
  List<bool> penaltyToggle = [false];
  @override
  Widget build(context) {
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          new ToggleButtons(
                            isSelected: toggleButtons1,
                            selectedColor: Colors.white,
                            color: const Color.fromARGB(255, 152, 47, 110),
                            fillColor: const Color.fromARGB(255, 223, 90, 170),
                            children: <Widget>[
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("LongLeft",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("LongCenter",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("LongRight",
                                          style: TextStyle(fontSize: 14)))),
                            ],
                            onPressed: (int newIndex) {
                              setState(() {
                                toggleButtons3[0] = false;
                                toggleButtons3[1] = false;
                                toggleButtons3[2] = false;
                                toggleButtons2[0] = false;
                                toggleButtons2[1] = false;
                                toggleButtons2[2] = false;

                                for (int index = 0;
                                    index < toggleButtons1.length;
                                    index++)
                                  if (index == newIndex) {
                                    toggleButtons1[index] = true;
                                    this.widget.addThrowEvaluation(index);
                                  } else {
                                    toggleButtons1[index] = false;
                                  }
                              });
                            },
                          ),
                          new ToggleButtons(
                            isSelected: toggleButtons2,
                            selectedColor: Colors.white,
                            color: const Color.fromARGB(255, 152, 47, 110),
                            fillColor: const Color.fromARGB(255, 223, 90, 170),
                            children: <Widget>[
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("CenterLeft",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Perfect",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("CenterRight",
                                          style: TextStyle(fontSize: 14)))),
                            ],
                            onPressed: (int newIndex) {
                              setState(() {
                                toggleButtons1[0] = false;
                                toggleButtons1[1] = false;
                                toggleButtons1[2] = false;
                                toggleButtons3[0] = false;
                                toggleButtons3[1] = false;
                                toggleButtons3[2] = false;

                                for (int index = 0;
                                    index < toggleButtons2.length;
                                    index++)
                                  if (index == newIndex) {
                                    toggleButtons2[index] = true;
                                    this.widget.addThrowEvaluation(index + 3);
                                  } else {
                                    toggleButtons2[index] = false;
                                  }
                              });
                            },
                          ),
                          new ToggleButtons(
                            isSelected: toggleButtons3,
                            selectedColor: Colors.white,
                            color: const Color.fromARGB(255, 152, 47, 110),
                            fillColor: const Color.fromARGB(255, 223, 90, 170),
                            children: <Widget>[
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("ShortLeft",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("ShortCenter",
                                          style: TextStyle(fontSize: 14)))),
                              Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          4,
                                  height:
                                      (MediaQuery.of(context).size.width - 70) /
                                          3.5,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("ShortRight",
                                          style: TextStyle(fontSize: 14)))),
                            ],
                            onPressed: (int newIndex) {
                              setState(() {
                                toggleButtons1[0] = false;
                                toggleButtons1[1] = false;
                                toggleButtons1[2] = false;
                                toggleButtons2[0] = false;
                                toggleButtons2[1] = false;
                                toggleButtons2[2] = false;

                                for (int index = 0;
                                    index < toggleButtons3.length;
                                    index++)
                                  if (index == newIndex) {
                                    toggleButtons3[index] = true;
                                    this.widget.addThrowEvaluation(index + 6);
                                  } else {
                                    toggleButtons3[index] = false;
                                  }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: ToggleButtons(
                      children: <Widget>[
                        Container(
                            width: (MediaQuery.of(context).size.width - 70) / 2,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (penaltyToggle[0]) Icon(Icons.done),
                                  Text("Add penalty (+1)",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            )),
                      ],
                      borderColor: const Color.fromARGB(255, 223, 90, 170),
                      isSelected: penaltyToggle,
                      selectedColor: Colors.white,
                      color: const Color.fromARGB(255, 152, 47, 110),
                      fillColor: const Color.fromARGB(255, 223, 90, 170),
                      onPressed: (int penaltyIndex) {
                        setState(() {
                          if (penaltyToggle[0] == false) {
                            penaltyToggle[0] = true;
                          } else {
                            penaltyToggle[0] = false;
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              this.widget.addToHolesAndThrowsMAP("Made");
                              this.widget.backToPreThrowWENTIN();
                            },
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16,
                                )),
                                side: MaterialStateProperty.all(BorderSide(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 223, 90, 170))),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width / 2 - 40,
                                    MediaQuery.of(context).size.width / 4 -
                                        20))),
                            child: Text(
                              'WENT IN',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 152, 47, 110),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              this.widget.addToHolesAndThrowsMAP("Missed");
                              this
                                  .widget
                                  .backToPreThrowNEXTSHOT(penaltyToggle[0]);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 223, 90, 170)),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 16,
                                )),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width / 2 - 40,
                                    MediaQuery.of(context).size.width / 4 -
                                        20))),
                            child: Row(
                              children: [
                                Text('NEXT THROW'),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
