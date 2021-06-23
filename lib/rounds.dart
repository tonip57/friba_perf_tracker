import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/courseListDialog.dart';
import 'package:friba_performance_tracker/roundListItem.dart';
import 'package:friba_performance_tracker/fileManagement.dart' as fileManager;

import 'roundListItem.dart';

// This is basically the Rounds screen in which a list of played
// rounds is shown.
//
class Rounds extends StatefulWidget {
  @override
  _RoundsState createState() => _RoundsState();
}

class _RoundsState extends State<Rounds> {
  // This method re-renders this particular widget when called.
  //
  void updateWidget() {
    print('Should update rounds list');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Creates a dialog which has all the playable courses.
    // Rendered on top of the Rounds screen.
    //
    createCourseDialog() {
      return showDialog(
          context: context,
          builder: (context) {
            return CourseListDialog(updateWidget);
          });
    }

    return Stack(
      children: [
        // This is where the reading of the playedCourses.json happens and
        // the list is made.
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var parsedJsonData = jsonDecode(snapshot.data.toString());
              return ListView.builder(
                  itemCount: parsedJsonData?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return RoundListItem(
                        parsedJsonData[index], index, updateWidget);
                  });
            } else
              /* return Center(
                  child: Wrap(
                children: [
                  Column(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Loading played rounds',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  )
                ],
              )); */

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text('No played rounds',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text('Press New Round to start playing',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              );
          },
          future: fileManager.readRounds(),
        ),
        Container(
          width: double.infinity,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: FloatingActionButton.extended(
                  label: Text('NEW ROUND'),
                  icon: Icon(Icons.add),
                  tooltip: 'Start playing',
                  onPressed: () {
                    createCourseDialog();
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
