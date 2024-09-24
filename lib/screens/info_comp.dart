// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:frontend/widget/panel_widget.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; //For parsing HTML

class InfoComp extends StatefulWidget {
  const InfoComp({super.key});

  @override
  State<InfoComp> createState() => _InfoCompState();
}

class _InfoCompState extends State<InfoComp> {
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

      //ListView builder to build all the panels.
      body: ListView.builder(
        itemCount: panels.length,
        itemBuilder: (context, index) {
          return PanelWidget(panel: panels[index]);
        },
      ),
    );
  }
}

// Models

class InfoPanel {
  final String panelId;
  final String panelInfo;
  final Left left;
  final Right right;

  InfoPanel({
    required this.panelId,
    required this.panelInfo,
    required this.left,
    required this.right,
  });

  factory InfoPanel.fromJson(Map<String, dynamic> json) {
    return InfoPanel(
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
