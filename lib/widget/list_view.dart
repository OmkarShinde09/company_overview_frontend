// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  final String text;
  const ListBuilder({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 130, right: 130, bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(128, 158, 158, 158), // border color
          width: 1, // border width
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Basic text for the company name
          Text(
            text,
            style: TextStyle(fontSize: 17),
          ),

          //TextButton for the Company row to open the processing of the company
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.teal,
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(17),
              textStyle: TextStyle(fontSize: 15),
              side: BorderSide(color: Colors.teal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              // handle button 2 press
            },
            child: Text('Open'),
          ),
        ],
      ),
    );
  }
}
