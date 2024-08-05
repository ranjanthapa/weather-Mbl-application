import 'package:flutter/material.dart';

class SearchAppBar extends SearchDelegate {
  final List<String> searchHistory;
  final Function(String) onAddToSearchHistory;
  final Function(String) onRemoveSearchHistory;
  SearchAppBar({
    required this.onAddToSearchHistory,
    required this.searchHistory,
    required this.onRemoveSearchHistory,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      onAddToSearchHistory(query);

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, query);
      });
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = searchHistory;
    return StatefulBuilder(builder: (context, setState) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            trailing: IconButton(
              onPressed: () {
                onRemoveSearchHistory(suggestion);
                setState(() {});
              },
              icon: const Icon(Icons.clear),
            ),
          );
        },
      );
    });
  }
}
