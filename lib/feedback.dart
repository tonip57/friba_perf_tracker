import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/puttingPerfCard.dart';
import 'package:friba_performance_tracker/scoreBubble.dart';
import 'package:friba_performance_tracker/scoreCard.dart';
import 'package:friba_performance_tracker/singleRound.dart';
import 'package:friba_performance_tracker/fileManagement.dart' as fileManager;
import 'package:friba_performance_tracker/throwsCard.dart';

// This is the feedback window.
//
class Feedback extends StatelessWidget {
  final SingleRound roundData;
  final SnackBar snackBar;
  final int index;

  Feedback({@required this.roundData, this.snackBar, @required this.index});

  @override
  Widget build(BuildContext context) {
    // Called after the rendering has been completed.
    //
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Shows the toast notification if it exists. This is checked so that the
      // 'Round finished!' notification can be shown after round has ended.
      //
      if (snackBar != null) {
        //print('snackbar will be shown');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    // Calls
    void _deleteRound() async {
      bool isSuccess = await fileManager.deleteOneRound(index);
      Navigator.pop(context, true);

      final snackBar = SnackBar(
        content: Text(
          isSuccess
              ? 'Round was deleted.'
              : "Error! There was a problem deleting the round.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[500],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // This creates the confirm dialog for the deletion of a round.
    //
    Future<void> _deleteDialog() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete round?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    _deleteRound();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.blue[600],
        title: Text('Feedback'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: _deleteDialog,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 8),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue[600], Colors.blue[600]]),
                        boxShadow: kElevationToShadow[4]),
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            roundData.course,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PAR ' + roundData.par.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ScoreBubble(
                                  roundData.throwsTotal - roundData.par),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                roundData.date,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ScoreCard(holes: roundData.holes),
                  PuttingPerfCard(
                    putts: roundData.putts,
                  ),
                  ThrowsCard(roundData.holes),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
