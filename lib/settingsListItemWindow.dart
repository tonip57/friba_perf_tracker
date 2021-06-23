import 'package:flutter/material.dart';

// This is a widget that is shown when pressing a settings list item.
// It's a window that covers the whole screen, and it has an appbar and some
// provided content.
class SettingsListItemWindow extends StatelessWidget {
  final String title;
  final Widget content;

  SettingsListItemWindow({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            //Goes back to Settings window.
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.blue[600],
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: content,
        )),
      ),
    );
  }
}
