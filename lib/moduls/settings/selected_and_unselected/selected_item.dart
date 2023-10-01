import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  String selectedText;

  SelectedItem(this.selectedText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(selectedText), Icon(Icons.check,color: Theme.of(context).primaryColor,)],
      ),
    );
  }
}
