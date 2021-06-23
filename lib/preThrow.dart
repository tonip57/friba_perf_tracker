import 'dart:ui';

import 'package:flutter/material.dart';

class PreThrow extends StatefulWidget {
  Function toThrowEvaluation;
  Function toPutting;
  Function addTypeChosen;
  Function addStyleChosen;

  PreThrow(this.toThrowEvaluation, this.toPutting, this.addTypeChosen,
      this.addStyleChosen);

  @override
  _PreThrow createState() => _PreThrow();
}

class _PreThrow extends State<PreThrow> {
  String valueChoose;
  List holeList = [
    "Hole 1",
    "Hole 2",
    "Hole 3",
    "Hole 4",
    "Hole 5",
    "Hole 6",
    "Hole 7",
    "Hole 8",
    "Hole 9",
    "Hole 10",
    "Hole 11",
    "Hole 12",
    "Hole 13",
    "Hole 14",
    "Hole 15",
    "Hole 16",
    "Hole 17",
    "Hole 18"
  ];

  List throwList = ["Throw 1", "Throw 2"];
  List<bool> isTypeSelected = [true, false, false];
  List<bool> isStyleSelected = [true, false, false];

  @override
  Widget build(context) {
    return Expanded(
      child: Flex(direction: Axis.vertical, children: [
        Expanded(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 3.4 / 2.6),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      this.widget.toPutting();
                    },
                    label: Text('START PUTTING'),
                    icon: Icon(Icons.wifi_tethering),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(height: 1, color: Colors.black12),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: new ToggleButtons(
                      isSelected: isTypeSelected,
                      selectedColor: Colors.white,
                      color: const Color.fromARGB(255, 152, 47, 110),
                      fillColor: const Color.fromARGB(255, 223, 90, 170),
                      children: <Widget>[
                        Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Drive",
                                    style: TextStyle(fontSize: 18)))),
                        Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Mid-Range",
                                    style: TextStyle(fontSize: 18)))),
                        Container(
                            width: (MediaQuery.of(context).size.width - 70) / 3,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Approach",
                                    style: TextStyle(fontSize: 18)))),
                      ],
                      onPressed: (int newIndex) {
                        setState(() {
                          for (int index = 0;
                              index < isTypeSelected.length;
                              index++)
                            if (index == newIndex) {
                              isTypeSelected[index] = true;
                              this.widget.addTypeChosen(index);
                            } else {
                              isTypeSelected[index] = false;
                            }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      color: Colors.white,
                      child: new ToggleButtons(
                        isSelected: isStyleSelected,
                        selectedColor: Colors.white,
                        color: const Color.fromARGB(255, 152, 47, 110),
                        fillColor: const Color.fromARGB(255, 223, 90, 170),
                        children: <Widget>[
                          Container(
                              width:
                                  (MediaQuery.of(context).size.width - 70) / 3,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Backhand",
                                      style: TextStyle(fontSize: 18)))),
                          Container(
                              width:
                                  (MediaQuery.of(context).size.width - 70) / 3,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Forehand",
                                      style: TextStyle(fontSize: 18)))),
                          Container(
                              width:
                                  (MediaQuery.of(context).size.width - 70) / 3,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Other",
                                      style: TextStyle(fontSize: 18)))),
                        ],
                        onPressed: (int newIndex) {
                          setState(() {
                            for (int index = 0;
                                index < isStyleSelected.length;
                                index++)
                              if (index == newIndex) {
                                isStyleSelected[index] = true;
                                this.widget.addStyleChosen(index);
                              } else {
                                isStyleSelected[index] = false;
                              }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: new ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 3.4 / 2.6),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary:
                        const Color.fromARGB(255, 223, 90, 170), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    this.widget.toThrowEvaluation();
                  },
                  label: Text("CONFIRM THROW"),
                  icon: Icon(Icons.arrow_forward_outlined),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
