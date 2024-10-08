// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SinglePanel extends StatelessWidget {
  final Panel panel;
  const SinglePanel({
    super.key,
    required this.panel,
  });

  @override
  Widget build(BuildContext context) {
    return panel.panelInfo == 'Full_Panel' || panel.panelId == 'a1_0'
        ?
        //For Full Panel.
        Container(
            child: panel.panelId == 'a1_0'
                ?
                //If the panel is the first panel, then display the first panel in a different way.
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(panel.left.header),
                        Row(
                          children: [
                            //Left of the first Panel
                            Expanded(
                              child: HtmlRenderer(
                                htmlString: panel.left.firstText[0].replaceAll(
                                  '\n',
                                  '<br>',
                                ),
                              ),
                            ),

                            //Right of the first Panel
                            Expanded(
                              child: HtmlRenderer(
                                htmlString:
                                    panel.right.display.displayInfo[0].text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 100, right: 100, top: 50),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(panel.left.header),

                            //Texts of the left Panel
                            if (panel.left.firstText.isNotEmpty)
                              HtmlRenderer(
                                htmlString: panel.left.firstText[0].replaceAll(
                                  '\n',
                                  '<br>',
                                ),
                              ),
                            if (panel.left.secondText.isNotEmpty)
                              HtmlRenderer(
                                htmlString: panel.left.secondText[0].replaceAll(
                                  '\n',
                                  '<br>',
                                ),
                              ),
                            if (panel.left.thirdText.isNotEmpty)
                              HtmlRenderer(
                                htmlString: panel.left.thirdText[0].replaceAll(
                                  '\n',
                                  '<br>',
                                ),
                              ),
                            if (panel.left.forthText.isNotEmpty)
                              HtmlRenderer(
                                htmlString: panel.left.forthText[0].replaceAll(
                                  '\n',
                                  '<br>',
                                ),
                              ),

                            //Plots of the right Panel
                            if (panel.panelId != 'a1_0')
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: HtmlRendererForPlot(
                                  plotString: panel.left.header ==
                                          'State of Approved Care'
                                      ? padBase64(panel.right.display
                                          .displayInfo[0].plotData)
                                      : panel.right.display.displayInfo[0]
                                          .plotData,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
          )
        :
        //For Half Panel.
        Container(
            height: 700,
            child: Row(
              children: [
                //Column to print the left side of the half panel.
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 50, top: 50, right: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          panel.left.header,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                        if (panel.left.firstText.isNotEmpty)
                          HtmlRendererForHalf(
                            htmlString: panel.left.firstText[0],
                          ),
                        if (panel.left.secondText.isNotEmpty)
                          HtmlRendererForHalf(
                            htmlString: panel.left.secondText[0],
                          ),
                        if (panel.left.thirdText.isNotEmpty)
                          HtmlRendererForHalf(
                            htmlString: panel.left.thirdText[0],
                          ),
                        if (panel.left.forthText.isNotEmpty)
                          HtmlRendererForHalf(
                            htmlString: panel.left.forthText[0],
                          ),
                      ],
                    ),
                  ),
                ),

                //Render the plot
                if (panel.right.display.displayInfo[0].plotData != "")
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    child: HtmlRendererForPlotHalfPanel(
                      plotString: panel.right.display.displayInfo[0].plotData,
                    ),
                  ),
              ],
            ),
          );
  }
}

//Function to pad the base64 string, for State of Approved Care Data.
String padBase64(String base64) {
  int mod = base64.length % 4;
  if (mod > 0) {
    base64 += '=' * (4 - mod);
  }
  return base64;
}

//Class to render HTML data which comes from the output json.
class HtmlRenderer extends StatelessWidget {
  final String? htmlString;

  HtmlRenderer({this.htmlString});

  @override
  Widget build(BuildContext context) {
    //Decode the textual data coming from the json as it is in Uri encoded format.
    String decodedHtml = Uri.decodeComponent(htmlString!);
    return Container(
      width: 700,
      child: HtmlWidget(
        decodedHtml,
        textStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class HtmlRendererForHalf extends StatelessWidget {
  final String? htmlString;

  HtmlRendererForHalf({this.htmlString});

  @override
  Widget build(BuildContext context) {
    //Decode the textual data coming from the json as it is in Uri encoded format.
    String decodedHtml = Uri.decodeComponent(htmlString!);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black45, // sets the color of the border
            width: 2, // sets the width of the border
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: HtmlWidget(
        decodedHtml,
        textStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class HtmlRendererForPlot extends StatelessWidget {
  final String? plotString;
  const HtmlRendererForPlot({this.plotString});
  @override
  Widget build(BuildContext context) {
    String div64 = decodePlotDataBody(plotString!);
    String script64 = decodePlotDataScript(plotString!);
    return InAppWebView(
      initialData: InAppWebViewInitialData(data: '''
      <!DOCTYPE html>
      <html>
      <head>
      <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/libs/jszip.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/dist/pptxgen.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
       </head>
      <body>
 <div id="content">
            ${div64}
          </div>
          <script>
            ${script64}
          </script>
      </html>
      '''),
    );
  }
}

//Different function for Half Panel because some plots come with script tags inside their decoded strings and some don't.
class HtmlRendererForPlotHalfPanel extends StatelessWidget {
  final String? plotString;
  const HtmlRendererForPlotHalfPanel({this.plotString});
  @override
  Widget build(BuildContext context) {
    String div64 = decodePlotDataBody(plotString!);
    String script64 = decodeHalfPlotDataScript(plotString!);
    return Expanded(
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: '''
      <!DOCTYPE html>
      <html>
      <head>
      <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/libs/jszip.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/dist/pptxgen.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
       </head>
      <body>
            ${div64}
            ${script64}
        </html>
        ''',
        ),
      ),
    );
  }
}

//decodePlotBody function to decode the body of the plot from the json.

String decodePlotDataBody(String plotString) {
  String decodedString = utf8.decode(base64Decode(plotString));
  final Map<String, dynamic> decodedJson = jsonDecode(decodedString);

  // Step 4: Extract the value from the JSON (from the "div64" key)
  final String renderedText = decodedJson['div64'] ?? 'No data found';
  String decodedHTML = utf8.decode(base64.decode(renderedText));

  return decodedHTML;
}

//decodePlotScript function to decode the script of the plot from the json.

String decodePlotDataScript(String plotString) {
  String decodedString = utf8.decode(base64Decode(plotString));
  final Map<String, dynamic> decodedJson = jsonDecode(decodedString);

  // Step 4: Extract the value from the JSON (from the "div64" key)
  final String renderedText = decodedJson['script64'] ?? 'No data found';
  String decodedHTML = utf8.decode(base64.decode(renderedText));

  return decodedHTML;
}

//decodeHalfPlotDataScript function separate for Half Panel because some plots come with script tags inside their decoded strings and some don't. So the decoded string that does not have a script tag are given a script tag here, and the ones that already have a script tag are returned as it is.
String decodeHalfPlotDataScript(String plotString) {
  String decodedString = utf8.decode(base64Decode(plotString));
  final Map<String, dynamic> decodedJson = jsonDecode(decodedString);

  // Step 4: Extract the value from the JSON (from the "div64" key)
  final String renderedText = decodedJson['script64'] ?? 'No data found';
  String decodedHTML = utf8.decode(base64.decode(renderedText));

  return _ensureScriptTags(decodedHTML);
}

//This is the actual function that checks if the script tag is present in the decoded string or not. If not, then it appends the script tag to the string.
String _ensureScriptTags(String html) {
  String newString = "";
  // Check for the presence of a specific script tag
  if (!html.contains("</script>")) {
    // Change to your specific function or identifier
    // Append the necessary script
    newString = "<script>$html</script>";
  } else {
    return html;
  }
  return newString;
}

//Panel Model
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
