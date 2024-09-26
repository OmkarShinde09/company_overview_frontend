// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

// class PanelWidget extends StatelessWidget {
//   final Panel panel;
//   const PanelWidget({
//     super.key,
//     required this.panel,
//   });

//   //function to consider all the data in the panel
//   //Build the panel considering all the conditions if the fields are empty or not.

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 70, right: 70),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 4,
//             blurRadius: 4,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //Header of the Panel
//           Text(
//             panel.left.header,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           //Specially for first panel
//           if (panel.panelId == 'a1_0')
//             Container(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.teal,
//                           width: 1,
//                         ),
//                       ),
//                       child: HtmlWidget(
//                         panel.left.firstText.join('').replaceAll('\n', '<br>'),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width / 50,
//                           bottom: 70),
//                       child: HtmlRenderer(
//                         htmlString: panel.right.display.displayInfo[0].text,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           //Texts to be printed in the panel(2nd panel onwards)

//           //Left side of the panel
//           Container(
//             child: Column(
//               children: [
//                 if (panel.left.firstText.isNotEmpty && panel.panelId != 'a1_0')
//                   Container(
//                     child: HtmlRenderer(
//                       htmlString: panel.left.firstText.join(''),
//                     ),
//                   ),
//                 if (panel.left.secondText.isNotEmpty)
//                   Container(
//                       child: HtmlRenderer(
//                           htmlString: panel.left.secondText.join(''))),
//                 if (panel.left.thirdText.isNotEmpty)
//                   Container(
//                       child: HtmlRenderer(
//                           htmlString: panel.left.thirdText.join(''))),
//                 if (panel.left.forthText.isNotEmpty)
//                   Container(
//                       child: HtmlRenderer(
//                           htmlString: panel.left.forthText.join(''))),
//               ],
//             ),
//           ),

//           if (panel.panelId != 'a1_0')
//             Container(
//               height: MediaQuery.of(context).size.height,
//               child: HtmlRendererForPlot(
//                 plotString: panel.left.header == 'State of Approved Care'
//                     ? padBase64(panel.right.display.displayInfo[0].plotData)
//                     : panel.right.display.displayInfo[0].plotData,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// //Class to render HTML data which comes from the output json.

// class HtmlRenderer extends StatelessWidget {
//   final String? htmlString;

//   HtmlRenderer({this.htmlString});

//   @override
//   Widget build(BuildContext context) {
//     String decodedHtml = Uri.decodeComponent(htmlString!);

//     //return this decoded HTML in HtmlWidget with bigger font size.
//     return HtmlWidget(
//       decodedHtml,
//       textStyle: TextStyle(fontSize: 16),
//     );

//     //Just return the decoded HTML. Handle the styling in the Flutter.
//     //return HtmlWidget(decodedHtml);
//   }
// }

// String padBase64(String base64) {
//   int mod = base64.length % 4;
//   if (mod > 0) {
//     base64 += '=' * (4 - mod);
//   }
//   return base64;
// }

// class HtmlRendererForPlot extends StatefulWidget {
//   final String? plotString;

//   HtmlRendererForPlot({this.plotString});

//   @override
//   State<HtmlRendererForPlot> createState() => _HtmlRendererForPlotState();
// }

// class _HtmlRendererForPlotState extends State<HtmlRendererForPlot> {
//   InAppWebViewController? webViewController;

//   getheight() async {
//     if (webViewController != null) {
//       var height = await webViewController!
//           .evaluateJavascript(source: '''document.body.scrollHeight;''');
//       if (height != null) {
//         int value = await height;
//         print("Height: $value");
//         setState(() {});
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String div64 = decodePlotDataBody(widget.plotString!);
//     String script64 = decodePlotDataScript(widget.plotString!);
//     return InAppWebView(
//       onWebViewCreated: (controller) async {
//         webViewController = controller;
//         controller.loadData(data: '''
//       <!DOCTYPE html>
//       <html>
//       <head>
//       <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/libs/jszip.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/dist/pptxgen.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
//        </head>
//       <body>
//  <div id="content">
//             ${div64}
//           </div>
//           <script>
//             ${script64}
//           </script>
//       </html>
//       ''');
//         Future<int?> value = controller.getContentHeight();
//         int? value1 = await value;
//         var height = await controller
//             .evaluateJavascript(source: '''document.body.scrollHeight;''');
//         setState(() {
//           print("Height: $height");
//         });
//       },
//       initialData: InAppWebViewInitialData(data: '''
//       <!DOCTYPE html>
//       <html>
//       <head>
//       <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/libs/jszip.min.js"></script>
//         <script src="https://cdn.jsdelivr.net/gh/gitbrent/pptxgenjs@3.12.0/dist/pptxgen.min.js"></script>
//         <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
//        </head>
//       <body>
//  <div id="content">
//             ${div64}
//           </div>
//           <script>
//             ${script64}
//           </script>
//       </html>
//       '''),
//     );
//   }
// }

// //Plot data widget to decode and render the plot data in the panel.

// class PlotDataWidget extends StatelessWidget {
//   final String plotData;

//   PlotDataWidget({required this.plotData});

//   @override
//   Widget build(BuildContext context) {
//     Uint8List decodedData = base64.decode(plotData);
//     return Image(image: MemoryImage(decodedData));
//   }
// }

// String decodePlotDataBody(String plotData) {
//   String decodedString = utf8.decode(base64Decode(plotData));
//   final Map<String, dynamic> decodedJson = jsonDecode(decodedString);

//   // Step 4: Extract the value from the JSON (from the "div64" key)
//   final String renderedText = decodedJson['div64'] ?? 'No data found';
//   String decodedHTML = utf8.decode(base64.decode(renderedText));

//   return decodedHTML;
// }

// String decodePlotDataScript(String plotData) {
//   String decodedString = utf8.decode(base64Decode(plotData));
//   final Map<String, dynamic> decodedJson = jsonDecode(decodedString);

//   // Step 4: Extract the value from the JSON (from the "div64" key)
//   final String renderedText = decodedJson['script64'] ?? 'No data found';
//   String decodedHTML = utf8.decode(base64.decode(renderedText));

//   return decodedHTML;
// }

// class Panel {
//   final String panelId;
//   final String panelInfo;
//   final Left left;
//   final Right right;

//   Panel({
//     required this.panelId,
//     required this.panelInfo,
//     required this.left,
//     required this.right,
//   });

//   factory Panel.fromJson(Map<String, dynamic> json) {
//     return Panel(
//       panelId: json['Panel_Id'],
//       panelInfo: json['Panel_Info'] ?? '',
//       left: Left.fromJson(json['Left']),
//       right: Right.fromJson(json['Right']),
//     );
//   }
// }

// // Define Left and Right models similarly to how you've done

// // Left model
// class Left {
//   final String header;
//   final List<String> firstText;
//   final List<String> secondText;
//   final List<String> thirdText;
//   final List<String> forthText;
//   final List<String>? fifthText;
//   final List<String>? sixthText;
//   final String? linkTitle;
//   final List<Link>? links;

//   Left({
//     required this.header,
//     required this.firstText,
//     required this.secondText,
//     required this.thirdText,
//     required this.forthText,
//     this.fifthText,
//     this.sixthText,
//     this.linkTitle,
//     this.links,
//   });

//   factory Left.fromJson(Map<String, dynamic> json) {
//     var linkList = json['Links'] as List? ?? [];
//     List<Link> links = linkList.map((i) => Link.fromJson(i)).toList();

//     return Left(
//       header: json['Header'],
//       firstText: List<String>.from(json['First_Text']),
//       secondText: List<String>.from(json['Second_Text']),
//       thirdText: List<String>.from(json['Third_Text']),
//       forthText: List<String>.from(json['Forth_Text']),
//       fifthText: json['Fifth_Text'] != null
//           ? List<String>.from(json['Fifth_Text'])
//           : null,
//       sixthText: json['Sixth_Text'] != null
//           ? List<String>.from(json['Sixth_Text'])
//           : null,
//       linkTitle: json['Link_Title'] ?? '',
//       links: links,
//     );
//   }
// }

// // Right model
// class Right {
//   final Display display;

//   Right({required this.display});

//   factory Right.fromJson(Map<String, dynamic> json) {
//     return Right(
//       display: Display.fromJson(json['Display']),
//     );
//   }
// }

// // Display model
// class Display {
//   final String displayType;
//   final List<DisplayInfo> displayInfo;

//   Display({
//     required this.displayType,
//     required this.displayInfo,
//   });

//   factory Display.fromJson(Map<String, dynamic> json) {
//     var displayInfoList = json['Display_Info'] as List;
//     List<DisplayInfo> displayInfos =
//         displayInfoList.map((i) => DisplayInfo.fromJson(i)).toList();

//     return Display(
//       displayType: json['Display_Type'],
//       displayInfo: displayInfos,
//     );
//   }
// }

// // DisplayInfo model
// class DisplayInfo {
//   final String plot;
//   final int location;
//   final String plotData;
//   final String text;
//   final String title;
//   final String valueType;

//   DisplayInfo({
//     required this.plot,
//     required this.location,
//     required this.plotData,
//     required this.text,
//     required this.title,
//     required this.valueType,
//   });

//   factory DisplayInfo.fromJson(Map<String, dynamic> json) {
//     return DisplayInfo(
//       plot: json['Plot'],
//       location: json['Location'],
//       plotData: json['Plot_Data'] ?? '',
//       text: json['Text'] ?? '',
//       title: json['Title'] ?? '',
//       valueType: json['Value_Type'] ?? '',
//     );
//   }
// }

// // Link model
// class Link {
//   final String link;
//   final String linkText;

//   Link({required this.link, required this.linkText});

//   factory Link.fromJson(Map<String, dynamic> json) {
//     return Link(
//       link: json['Link'] ?? '',
//       linkText: json['Link_Text'] ?? '',
//     );
//   }
// }
