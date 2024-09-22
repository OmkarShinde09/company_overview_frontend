import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widget/list_item.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  List<String> companies = [];
  List<String> filteredCompanies = [];
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
      companies = data.map((company) => company['company'] as String).toList();
      filteredCompanies = companies; // Initialize filtered companies
    });
  }

  void _filterCompanies(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchQuery = query;
        filteredCompanies = companies
            .where((company) =>
                company.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        searchQuery = '';
        filteredCompanies =
            companies; // Reset to original list when query is empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            padding: EdgeInsets.only(top: 20, left: 25, right: 60, bottom: 20),
            child: Text(
              "Add Companies",
              style: TextStyle(fontSize: 25),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Please search and select Company. Add Company to your module.",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(78, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: _filterCompanies, // Update on input change
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Company',
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(193, 244, 67, 54),
                      size: 30,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "These are related indications from our database. Select the ones you want to include.",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                return ListItem(
                  text: filteredCompanies[index],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 30),
            height: 85,
            color: const Color.fromARGB(38, 158, 158, 158),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(20),
                    textStyle: TextStyle(fontSize: 12),
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    // handle button press
                  },
                  child: Text('Start Processing'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
