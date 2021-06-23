import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/courseListItem.dart';

// This widget builds a dialog in which a list of playable courses is shown.
//
class CourseListDialog extends StatelessWidget {
  final Function updateWidget;

  CourseListDialog(this.updateWidget);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Choose course',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    var showData = json.decode(snapshot.data.toString());
                    return ListView.builder(
                        itemCount: showData?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return CourseListItem(showData[index], updateWidget);
                        });
                  },
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/courses.json'),
                ),
              ),
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL')),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
