// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String text;
  final bool isChecked;
  final VoidCallback onCheckedChanged;

  const ListItem({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onCheckedChanged,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 130, right: 130, bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(128, 158, 158, 158),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(133, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: GestureDetector(
              onTap: () {
                widget.onCheckedChanged();
              },
              child: CircleAvatar(
                radius: 12,
                backgroundColor: widget.isChecked
                    ? const Color.fromARGB(160, 0, 150, 135)
                    : Colors.white,
                child: widget.isChecked
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
