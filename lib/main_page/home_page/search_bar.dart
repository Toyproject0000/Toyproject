import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MySearchDelegate extends SearchDelegate {

  List<String> searchResults = ['Brazil', 'china', 'korea', 'japan', 'USA'];  

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios));

  @override
  Widget buildSuggestions(BuildContext context) {
      
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index]; // suggestion Allocation

        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,

          ),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildResults(BuildContext context) => Center(
          child: Text(
        query,
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ));
}
