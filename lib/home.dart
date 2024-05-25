import 'dart:js_interop_unsafe';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final words = nouns.take(50).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text ('Flutter testapp'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('favorites').listenable(),
        builder: (context, box, child) {
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index){
              final word = words[index];
              final isFav = box.get(index) != null;
              return ListTile(
                title: Text(word),
                trailing: IconButton(
                  onPressed: () async {
                    if(isFav){
                      await box.delete(index);
                    } else {
                      await box.put(index, word);
                    }
                },
                  icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border),
                  color: Colors.red,),
              );
            },
          );
        },
      )
    );
  }
}
