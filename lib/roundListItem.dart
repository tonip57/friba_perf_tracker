import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/feedback.dart' as roundFeedback;
import 'package:friba_performance_tracker/scoreBubble.dart';
import 'package:friba_performance_tracker/singleRound.dart';
import 'package:intl/intl.dart';

// This widget is the card for an round that is shown on the Rounds screen.
//
class RoundListItem extends StatelessWidget {
  final dynamic jsonDataRound;
  final int index;
  final Function updateWidget;

  RoundListItem(this.jsonDataRound, this.index, this.updateWidget);

  @override
  Widget build(BuildContext context) {
    var roundData = new SingleRound.fromJson(jsonDataRound);
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(roundData.endTime);

    var format = new DateFormat("Hm");
    var dateString = format.format(date);

    // Open the pressed round card's Feedback window.
    // When the Feedback window is popped and it returns true,
    // the updateWidget-method (in Rounds window) is called so
    // that the deleted round won't show up there anymore.
    //
    _navigateToFeedback(BuildContext context) async {
      bool shouldUpdate = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => roundFeedback.Feedback(
                  roundData: roundData,
                  index: index,
                )),
      );

      if (shouldUpdate == null) {
        shouldUpdate = false;
      }

      if (shouldUpdate) {
        updateWidget();
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black12)),
        child: InkWell(
          onTap: () {
            _navigateToFeedback(context);
          },
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(roundData.course,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                /* Text(" Väliaikainen " + roundData.layout,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)), */
                              ],
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 61,
                                                child: Text(
                                                    'PAR ' +
                                                        roundData.par
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              ScoreBubble(
                                                  roundData.throwsTotal -
                                                      roundData.par)
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                roundData.date +
                                                    " ended " +
                                                    dateString,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      _navigateToFeedback(context);
                    },
                    child: Text('FEEDBACK'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
