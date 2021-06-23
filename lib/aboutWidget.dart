import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  final String infoText =
      "Tap Start Putting if your realistic goal is to throw in the basket. "
      "If your goal is to just get closer to the basket, choose your throwing styles and press Confirm Throw.";
  final String screenTitle;
  final infoTextMap = {
    "PRE-THROW":
        "Tap Start Putting if your realistic goal is to throw in the basket. "
            "If your goal is to just get closer to the basket, choose your throwing type and style, and press Confirm Throw.",
    "THROW-EVALUATION":
        "Choose the option that describes your real throw compared to your target point on the ground. Add penalty if you missed mando or your disc went OB.",
    "PUTTING":
        "Choose the distance to the basket and press NEXT PUTT if you missed the basket and WENT IN if you made it."
  };

  AboutWidget(this.screenTitle);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(screenTitle + ' HELP'),
      content: Text(infoTextMap[screenTitle]),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // background
            onPrimary: Colors.blue, // foreground
          ),
          child: Text("CLOSE"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
