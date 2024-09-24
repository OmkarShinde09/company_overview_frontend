// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:frontend/widget/first_panel_column.dart';
import 'package:frontend/widget/second_panedl_dropdown.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; //For parsing HTML

class CompanyInfo extends StatefulWidget {
  const CompanyInfo({super.key});

  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  List<Panel> panels = [];

  @override
  void initState() {
    super.initState();
    loadPanels();
  }

  Future<void> loadPanels() async {
    final String response = await rootBundle.loadString('assets/output.json');
    final Map<String, dynamic> data = json.decode(response);

    setState(() {
      // Access the list of panels correctly
      panels = (data['Article']['Panel'] as List)
          .map((panel) => Panel.fromJson(panel))
          .toList();

      print('Panels loaded: ${panels.length}');
      if (panels.isNotEmpty) {
        print('First Panel ID: ${panels[0].panelId}');
      }
    });
  }

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
                  //Display the First_Text from the first panel's left part
                  HtmlRenderer(htmlString: panels[0].left.header),
                  Row(
                    //A row to hold the left and right parts of the panel
                    children: [
                      //Column containing the three children
                      Expanded(
                        child: Column(
                          children: [
                            HtmlRenderer(
                                htmlString: panels[0].left.firstText[0]),
                          ],
                        ),
                      ),

                      //Information in the first panel
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.all(40),
                            child: HtmlRenderer(
                              htmlString:
                                  panels[0].right.display.displayInfo[0].text,
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

                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Third panel Bull's Eye Plot
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("Bull's Eye Plot"),
                  Container(
                    width: 800,
                    margin: EdgeInsets.only(left: 400),
                    child: Text(
                        "The Bullseye chart organizes drugs by their mechanisms of action, highlighting the scientific strategies and innovations behind each therapy. The innermost circle shows all approved drugs, followed by early Phase 1 trials, advanced Phase 2 trials, and nearly market-ready Phase 3 drugs.",
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

                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Fourth panel which includes the State of Approved Care
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("State of Approved Care"),
                  Container(
                    width: 800,
                    margin: EdgeInsets.only(left: 400),
                    child: Text(
                        "The Standard of Care Panel is designed to be your go-to resource for understanding the approved drug regimens across various therapeutic lines, with focus on providing comprehensive and clear information. It aims to support the delivery of effective and personalised patient care.",
                        style: TextStyle(fontSize: 16)),
                  ),

                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Fifth panel which includes the Landscape of Approved Drugs
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("Landscape of Approved Drugs "),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Sixth panel which includes State of Trials of Approved Drugs
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("State of Trials of Approved Drugs"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Seventh panel which includes the State of Trials of Approved Drugs - Graphical Analysis
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text(
                      "State of Trials of Approved Drugs - Graphical Analysis"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Eighth panel which includes the State of Trials of Drugs in Development
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("State of Trials of Drugs in Development"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Ninth panel which includes the State of Trials of Drugs in Development - Graphical Analysis
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("State of Trials of Drugs in Development"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Tenth panel which includes the State of Trials of Drugs in Development - Graphical Analysis Company wise
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text(
                      "State of Trials of Drugs in Development - Graphical Analysis Company wise"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Eleventh panel which includes the Comparison of Trials for Approved Drugs
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("Comparison of Trials for Approved Drugs"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),

            //Twelfth panel which includes the Comparison of Trials for Drugs in Development
            Container(
              margin: EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //The tiltle of the panel
                  Text("Comparison of Trials for Drugs in Development"),
                  //This container displays the Sunburst plot -> To be added when working with json.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Class to render HTML data which comes from the output json.

class HtmlRenderer extends StatelessWidget {
  final String? htmlString;

  HtmlRenderer({this.htmlString});

  @override
  Widget build(BuildContext context) {
    String decodedHtml = Uri.decodeComponent(htmlString!);

    return Container(
      margin: EdgeInsets.all(40),
      child: HtmlWidget(
        decodedHtml,
      ),
    );
  }
}

// Models

class Panel {
  final String panelId;
  final String panelInfo;
  final Left left;
  final Right right;

  Panel({
    required this.panelId,
    required this.panelInfo,
    required this.left,
    required this.right,
  });

  factory Panel.fromJson(Map<String, dynamic> json) {
    return Panel(
      panelId: json['Panel_Id'],
      panelInfo: json['Panel_Info'] ?? '',
      left: Left.fromJson(json['Left']),
      right: Right.fromJson(json['Right']),
    );
  }
}

// Define Left and Right models similarly to how you've done

// Left model
class Left {
  final String header;
  final List<String> firstText;
  final List<String> secondText;
  final List<String> thirdText;
  final List<String> forthText;
  final List<String>? fifthText;
  final List<String>? sixthText;
  final String? linkTitle;
  final List<Link>? links;

  Left({
    required this.header,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.forthText,
    this.fifthText,
    this.sixthText,
    this.linkTitle,
    this.links,
  });

  factory Left.fromJson(Map<String, dynamic> json) {
    var linkList = json['Links'] as List? ?? [];
    List<Link> links = linkList.map((i) => Link.fromJson(i)).toList();

    return Left(
      header: json['Header'],
      firstText: List<String>.from(json['First_Text']),
      secondText: List<String>.from(json['Second_Text']),
      thirdText: List<String>.from(json['Third_Text']),
      forthText: List<String>.from(json['Forth_Text']),
      fifthText: json['Fifth_Text'] != null
          ? List<String>.from(json['Fifth_Text'])
          : null,
      sixthText: json['Sixth_Text'] != null
          ? List<String>.from(json['Sixth_Text'])
          : null,
      linkTitle: json['Link_Title'] ?? '',
      links: links,
    );
  }
}

// Right model
class Right {
  final Display display;

  Right({required this.display});

  factory Right.fromJson(Map<String, dynamic> json) {
    return Right(
      display: Display.fromJson(json['Display']),
    );
  }
}

// Display model
class Display {
  final String displayType;
  final List<DisplayInfo> displayInfo;

  Display({
    required this.displayType,
    required this.displayInfo,
  });

  factory Display.fromJson(Map<String, dynamic> json) {
    var displayInfoList = json['Display_Info'] as List;
    List<DisplayInfo> displayInfos =
        displayInfoList.map((i) => DisplayInfo.fromJson(i)).toList();

    return Display(
      displayType: json['Display_Type'],
      displayInfo: displayInfos,
    );
  }
}

// DisplayInfo model
class DisplayInfo {
  final String plot;
  final int location;
  final String plotData;
  final String text;
  final String title;
  final String valueType;

  DisplayInfo({
    required this.plot,
    required this.location,
    required this.plotData,
    required this.text,
    required this.title,
    required this.valueType,
  });

  factory DisplayInfo.fromJson(Map<String, dynamic> json) {
    return DisplayInfo(
      plot: json['Plot'],
      location: json['Location'],
      plotData: json['Plot_Data'] ?? '',
      text: json['Text'] ?? '',
      title: json['Title'] ?? '',
      valueType: json['Value_Type'] ?? '',
    );
  }
}

// Link model
class Link {
  final String link;
  final String linkText;

  Link({required this.link, required this.linkText});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      link: json['Link'] ?? '',
      linkText: json['Link_Text'] ?? '',
    );
  }
}
