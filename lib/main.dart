import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dictionary(),
    );
  }
}

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final List<WordPair> _words = generateWordPairs().take(100).toList();
  final TextEditingController _filter = TextEditingController();
  List<WordPair> _filteredWords = [];
  String _selectedLetter = '';

  @override
  void initState() {
    _filteredWords.addAll(_words);
    super.initState();
  }

  List<WordPair> filterWordsByLetter(String letter) {
    return _words
        .where((word) => word.asLowerCase.startsWith(letter.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: _filteredWords.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredWords[index].asPascalCase),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 26,
              itemBuilder: (context, index) {
                final String letter = String.fromCharCode(65 + index);
                return ListTile(
                  title: Text(
                    letter,
                    style: TextStyle(
                      color: _selectedLetter == letter ? Colors.blue : null,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedLetter = letter;
                      _filteredWords = filterWordsByLetter(letter);
                      _filter.text = letter;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
