import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/fileManagement.dart' as fileManager;

// This widget build a box that has the app's reset function.
//
class ResetApp extends StatefulWidget {
  @override
  _ResetAppState createState() => _ResetAppState();
}

class _ResetAppState extends State<ResetApp> {
  bool isChecked = false;

  // Toggles isChecked between true and false and updates the whole widget so
  // that the boolean change is reflected on the checkmark widget and
  // 'Reset App' button.
  //
  void _changeCheckmark(bool newValue) => setState(() {
        isChecked = !isChecked;
      });

  // Deletes the json file(s) and shows a toast notification
  //
  Future<void> _deleteFile() async {
    bool isSuccess = await fileManager.deleteEverything();
    isChecked = !isChecked;
    final snackBar = SnackBar(
      content: Text(
        isSuccess
            ? 'Data was reset.'
            : "Error! Maybe there was nothing to reset?",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue[500],
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Caution!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Reset operation will erase all your played courses, feedback and stats. Are you sure you want to continue?',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Container(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Yes, I want to reset my data.'),
                  value: isChecked,
                  onChanged: _changeCheckmark,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isChecked ? _deleteFile : null,
                    child: Text('RESET DATA'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
