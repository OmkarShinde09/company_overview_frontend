// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:frontend/widget/list_item.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
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

  void _toggleCompanySelection(int index) {
    setState(() {
      // Toggle the selected state of the filtered company
      filteredCompanies[index]['selected'] =
          !filteredCompanies[index]['selected'];

      // Sync the original companies list with the selected state
      String companyName = filteredCompanies[index]['company'];
      // Find the corresponding company in the original list and update it
      companies.firstWhere(
              (company) => company['company'] == companyName)['selected'] =
          filteredCompanies[index]['selected'];
    });
  }

  Future<void> _startProcessing() async {
    // Gather only the selected companies
    final selectedCompanies =
        filteredCompanies.where((company) => company['selected']).toList();

    // Prepare the request body
    final body = json.encode(selectedCompanies);

    try {
      // Send POST request to the Go server
      final response = await http.post(
        Uri.parse(
            'http://localhost:8080/update'), // Update with your server URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle successful response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Companies updated successfully!')),
        );

        // Refresh the screen
        await loadCompanies(); // Reload companies from the JSON file
        setState(() {}); // Update the state to reflect the changes
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update companies.')),
        );
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
              // Handle button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              // Handle button press
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
                  onChanged: _filterCompanies,
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
                  text: filteredCompanies[index]['company'],
                  isChecked: filteredCompanies[index]['selected'],
                  onCheckedChanged: () => _toggleCompanySelection(index),
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
                  onPressed: _startProcessing, // Call the processing function
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
