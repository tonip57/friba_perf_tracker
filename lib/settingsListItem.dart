import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/settingsListItemWindow.dart';

// Widget for the list items in settings screen.
//
class SettingsListItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData optionIcon;
  final Widget windowContent;

  SettingsListItem(
      {@required this.title,
      @required this.desc,
      @required this.optionIcon,
      @required this.windowContent});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingsListItemWindow(
                      title: title,
                      content: windowContent,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  optionIcon,
                  size: 28,
                  color: Colors.black87,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                  Text(desc, style: TextStyle(color: Colors.black45))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
