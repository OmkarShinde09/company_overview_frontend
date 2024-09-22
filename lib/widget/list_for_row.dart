import 'package:flutter/material.dart';

class ListForRow extends StatelessWidget {
  const ListForRow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Text(
              "Company",
            ),
            SizedBox(width: 16), // add some space between text field and button
            TextButton(
              onPressed: () {},
              child: Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}
