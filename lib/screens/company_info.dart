// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/widget/first_panel_column.dart';
import 'package:frontend/widget/second_panedl_dropdown.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Image.asset('assets/Knolens_logo.png'),
        actions: [
          IconButton(
            icon: const Icon(Icons.start),
            onPressed: () {
              // handle button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              // handle button press
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //First panel which includes the left and right parts.
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text('Acne'),
                  Row(
                    //A row to hold the left and right parts of the panel
                    children: [
                      //Column containing the three children
                      Expanded(
                        child: Column(
                          children: [
                            FirstPanelColumn(
                              text: "State of Approved Care",
                            ),
                            FirstPanelColumn(
                              text: "State of Approved Therapies",
                            ),
                            FirstPanelColumn(
                              text: "State of Drugs in Development",
                            ),
                          ],
                        ),
                      ),

                      //Information in the first panel
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.all(40),
                            child: Text(
                              '''This module is designed to asses the state of Therapeutic Area (TA), reviewing the drugs in development or in use, the Mechanism of Action (MoA) being leveraged, the companies driving these studies, the state of clinical progress using data from published trials. The module will compare progress across MoA and by sponsoring organisation, attempt to identify trends in positive versus negative results from studies, estimated timelines for progress. Content will include: Comparison of Development in an indication, Analysis by Approved Drugs, Analysis by Drugs in Development, Timelines, and Comparative Landscape.\nDisclaimer: ANDA applications for generic drugs are currently not included.''',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Second panel which includes the Sunburst plot
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("Overall State of Acne"),
                  Container(
                    width: 800,
                    margin: EdgeInsets.only(left: 400),
                    child: Text(
                        "The Sunburst panel offers an interactive way to explore drugs in development, enabling users to filter the primary product and experimental drugs, by trial status, company and to gain insights into drug development and distribution across phases.",
                        style: TextStyle(fontSize: 16)),
                  ),

                  //This container displays the DropDowns in the second panel
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondPanedlDropdown(
                          title: 'Select Company',
                        ),
                        SecondPanedlDropdown(
                          title: 'Select Phase',
                        ),
                        SecondPanedlDropdown(
                          title: 'Not yet recruting',
                        ),
                        SecondPanedlDropdown(
                          title: 'Select Drugs',
                        ),
                      ],
                    ),
                  ),

                  //This container displays the Sunburst plot
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
