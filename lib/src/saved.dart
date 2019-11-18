import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'bloc/Bloc.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {

              var saved = Set<WordPair>();

              if(snapshot.hasData) {
                    saved.addAll(snapshot.data);
              } else {
                    bloc.addCurrentSaved;
              }

          return ListView.builder(
              itemCount: snapshot.data.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider();
                }

                int realIndex = index ~/ 2;

                return _buildRow(snapshot.data.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
