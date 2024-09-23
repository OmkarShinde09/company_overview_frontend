// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class FirstPanelColumn extends StatelessWidget {
  final String text;
  const FirstPanelColumn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 2),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.link_rounded,
              color: Colors.teal,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
