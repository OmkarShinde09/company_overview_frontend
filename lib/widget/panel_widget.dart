// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PanelWidget extends StatelessWidget {
  final Panel panel;
  const PanelWidget({
    super.key,
    required this.panel,
  });

  //function to consider all the data in the panel
  //Build the panel considering all the conditions if the fields are empty or not.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(29, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header of the Panel
          Text(
            panel.left.header,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Specially for first panel
          if (panel.panelId == 'a1_0')
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.teal,
                          width: 1,
                        ),
                      ),
                      child: HtmlWidget(
                        panel.left.firstText.join('').replaceAll('\n', '<br>'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 50,
                          bottom: 70),
                      child: HtmlRenderer(
                        htmlString: panel.right.display.displayInfo[0].text,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          //Texts to be printed in the panel(2nd panel onwards)

          //Left side of the panel
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20, right: 300, left: 300, bottom: 10),
            child: Column(
              children: [
                if (panel.left.firstText.isNotEmpty && panel.panelId != 'a1_0')
                  Container(
                    child: HtmlRenderer(
                      htmlString: panel.left.firstText.join(''),
                    ),
                  ),
                if (panel.left.secondText.isNotEmpty)
                  Container(
                      child: HtmlRenderer(
                          htmlString: panel.left.secondText.join(''))),
                if (panel.left.thirdText.isNotEmpty)
                  Container(
                      child: HtmlRenderer(
                          htmlString: panel.left.thirdText.join(''))),
                if (panel.left.forthText.isNotEmpty)
                  Container(
                      child: HtmlRenderer(
                          htmlString: panel.left.forthText.join(''))),
              ],
            ),
          ),

          //Right side of the panel
          Container(
            child: PlotDataWidget(
              plotData: panel.right.display.displayInfo[0].plotData,
            ),
          )
        ],
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

    // return SizedBox(
    //   height: MediaQuery.of(context).size.height, // or any other fixed height
    //   child: Container(
    //     margin: EdgeInsets.all(40),
    //     child: HtmlWidget(
    //       decodedHtml,
    //     ),
    //   ),
    // );

    //Just return the decoded HTML. Handle the styling in the Flutter.
    return HtmlWidget(decodedHtml);
  }
}

//Plot data widget to decode and render the plot data in the panel.

class PlotDataWidget extends StatelessWidget {
  final String plotData;

  PlotDataWidget({required this.plotData});

  @override
  Widget build(BuildContext context) {
    Uint8List decodedData = base64.decode(plotData);
    return Image(image: MemoryImage(decodedData));
  }
}

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
