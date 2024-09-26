// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/add_company.dart';
import 'package:frontend/widget/list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> companies = [];
  List<Map<String, dynamic>> filteredCompanies = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadCompanies();
  }

  Future<void> loadCompanies() async {
    final String response =
        await rootBundle.loadString('assets/companies.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      companies = data
          .map((company) => {
                'company': company['company'],
                'selected': company['selected'],
              })
          .toList();
      filteredCompanies = List.from(companies);
    });
  }

  void _filterCompanies(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchQuery = query;
        filteredCompanies = companies
            .where((company) =>
                company['company'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        searchQuery = '';
        filteredCompanies = List.from(companies);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Image.asset(
            'assets/Knolens_logo.png'), // display image on extreme left
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 60, right: 60),
            //1st container
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Add New Analysis Companies",
                    style: TextStyle(fontSize: 25),
                  ),
                ),

                //2nd container
                Container(
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                          minimumSize: Size(100, 40),
                          padding: EdgeInsets.all(20),
                          textStyle: TextStyle(fontSize: 18),
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        onPressed: () {
                          // handle button 1 press
                        },
                        child: Text('Companies (${filteredCompanies.length})'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                          minimumSize: Size(100, 40),
                          padding: EdgeInsets.all(20),
                          textStyle: TextStyle(fontSize: 18),
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        onPressed: () {
                          // handle button 2 press
                        },
                        child: Text('Settings'),
                      ),
                    ],
                  ),
                ),

                //3rd container
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: _filterCompanies,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          minimumSize: Size(100, 40),
                          padding: EdgeInsets.all(20),
                          textStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to the AddCompany page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCompany()),
                          );
                        },
                        child: Text('Add Companies'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //List Container
          Flexible(
            child: ListView.builder(
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                if (filteredCompanies[index]['selected'] == true) {
                  return ListBuilder(
                    text: filteredCompanies[index]['company'],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
