import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

var entries = <WordPair>[];
var faventries = <WordPair>[];

class FavApp extends StatefulWidget {
  const FavApp({Key? key}) : super(key: key);

  @override
  State<FavApp> createState() => _FavApp();
}

class _FavApp extends State<FavApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Generator'),
        leading: InkWell(
          child: const Icon(Icons.star),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Favourittes()));
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          // each choti listtile ma entires[i] display bhayechi
          //code will return here and again 5 more items are added to entreis

          entries.addAll(generateWordPairs().take(5));
//isFAv checks if faventires already has content of entreis..returns true if faventries has entires element
//this will help us show starred names
          final isFAv = faventries.contains(entries[i]);
//suppose entries[i] is rambabu...if rambabu is in faventries then isFAv is true..so icons.favourei is displayed in red
          return ListTile(
            trailing: InkWell(
              onTap: () {
                setState(() {
                  if (isFAv) {
                    faventries.remove(entries[i]);
                  } else {
                    faventries.add(entries[i]);
                  }
                });
              },
              child: Icon(
                isFAv ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFAv ? Colors.red : null,
              ),
            ),
            //pascalCAse is used to return a word pair as a stirng...as Text can only take a string
            title: Text(entries[i].asPascalCase),
          );
        },
      ),
    );
  }
}

class Favourittes extends StatefulWidget {
  const Favourittes({Key? key}) : super(key: key);

  @override
  State<Favourittes> createState() => _FavourittesState();
}

class _FavourittesState extends State<Favourittes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: faventries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(faventries[index].asPascalCase),
          );
        },
      ),
    );
  }
}
