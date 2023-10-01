import 'package:flutter/material.dart';

class UnSelectedItem extends StatelessWidget {
  String selectedText;

  UnSelectedItem(this.selectedText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(selectedText),
    );
  }
}
