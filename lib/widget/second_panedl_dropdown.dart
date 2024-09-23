// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SecondPanedlDropdown extends StatefulWidget {
  final String title;
  const SecondPanedlDropdown({
    super.key,
    required this.title,
  });

  @override
  State<SecondPanedlDropdown> createState() => _SecondPanedlDropdownState();
}

class _SecondPanedlDropdownState extends State<SecondPanedlDropdown> {
  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    return Column(
      children: [
        Text(title),
        DropdownButton(
          onChanged: (newValue) {
            setState(() {});
          },
          items: [
            DropdownMenuItem(
              child: Text('Option 1'),
              value: 'option1',
            ),
            DropdownMenuItem(
              child: Text('Option 2'),
              value: 'option2',
            ),
            DropdownMenuItem(
              child: Text('Option 3'),
              value: 'option3',
            ),
          ],
        ),
      ],
    );
  }
}
