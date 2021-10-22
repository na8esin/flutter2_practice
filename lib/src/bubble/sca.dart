import 'package:flutter/material.dart';

import 'bubble.dart';

void main() {
  runApp(MaterialApp(
    home: MySca(),
  ));
}

class MySca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('fabの上に吹き出し'),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Bubble(
                  text: 'こちらを押すと新規登録です',
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {},
                )),
          ],
        ),
        body: SizedBox.shrink());
  }
}
