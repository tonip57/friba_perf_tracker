import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/fileManagement.dart' as fileManager;
import 'package:friba_performance_tracker/puttingPerfCard.dart';
import 'package:friba_performance_tracker/singleRound.dart';
import 'package:friba_performance_tracker/throwsCard.dart';

// This is basically the stats screen. It has a listview widget
// that has different kinds of stat-card widgets as children.
//
class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var parsedJsonData = jsonDecode(snapshot.data.toString());
            var test = new SingleRound.fromJson(parsedJsonData);

            return ListView(children: [
              PuttingPerfCard(
                putts: test.putts,
              ),
            ]);
          } else
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
                      child: Text('No statistics',
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text('Start playing on Rounds page',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            );
        },
        future: fileManager.readAllStats(),
      ),
    );
  }
}
