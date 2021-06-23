import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/toniMain.dart';

// This widget builds a dialog list widget with the provided parameters.
//
class CourseListItem extends StatelessWidget {
  final dynamic jsonCourseData;
  final Function updateWidget;

  CourseListItem(this.jsonCourseData, this.updateWidget);

  @override
  Widget build(BuildContext context) {
    var courseData = new Course.fromJson(jsonCourseData);

    // Makes a list that has holes' par numbers and return this list.
    //
    List<int> _generateParList() {
      List<int> parList = List.generate(
          courseData.holes.length, (index) => courseData.holes[index].holePar);

      //print('ParList: $parList');

      return parList;
    }

    // Starts a new round. When the round's window is popped and it returns
    // true, run updateWidget-method (in rounds screen) so that the finished round is
    // shown on the list of played rounds.
    //
    _navigateToNewRound(BuildContext context) async {
      Navigator.pop(context);
      bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ToniMain(
                  courseName: courseData.courseName,
                  layout: courseData.layout,
                  numberOfHoles: courseData.holes.length,
                  parList: _generateParList(),
                )),
      );

      if (result) {
        updateWidget();
      }
    }

    return InkWell(
      onTap: () {
        _navigateToNewRound(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseData.courseName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            courseData.layout ?? "",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'PAR ' + courseData.coursePar.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

class Course {
  String courseName;
  String layout;
  int coursePar;
  List<Holes> holes;

  Course({this.courseName, this.layout, this.coursePar, this.holes});

  Course.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    layout = json['layout'];
    coursePar = json['coursePar'];
    if (json['holes'] != null) {
      holes = [];
      json['holes'].forEach((v) {
        holes.add(new Holes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = this.courseName;
    data['layout'] = this.layout;
    data['coursePar'] = this.coursePar;
    if (this.holes != null) {
      data['holes'] = this.holes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Holes {
  int holeNumber;
  int holePar;

  Holes({this.holeNumber, this.holePar});

  Holes.fromJson(Map<String, dynamic> json) {
    holeNumber = json['holeNumber'];
    holePar = json['holePar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holeNumber'] = this.holeNumber;
    data['holePar'] = this.holePar;
    return data;
  }
}
