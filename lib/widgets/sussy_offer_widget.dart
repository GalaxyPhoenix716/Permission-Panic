import 'package:flutter/material.dart';

typedef SussyChoiceCallback = void Function(SussyOfferAction action);

enum SussyOfferAction { cancel, install }

void showSussyOfferPopup(BuildContext context, SussyChoiceCallback onChoice) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.amber),
            SizedBox(width: 8),
            Text("Suspicious Offer", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(
          "Downloading fishy.exe gets you extra 10 seconds!! Dont miss this chance!",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onChoice(SussyOfferAction.cancel);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onChoice(SussyOfferAction.install);
            },
            child: Text("Install", style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      );
    },
  );
}
