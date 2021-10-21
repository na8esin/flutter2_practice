import 'package:flutter/material.dart';

import 'my_chart.dart';

void main() {
  runApp(MaterialApp(
    home: MySca(),
  ));
}

class MySca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(), body: MyGridView()),
    );
  }
}

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [MyBox(), MyBox()],
    );
  }
}

class MyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: MyChart(total: 300, rest: 240, outerRPerParentHeightHalf: 0.5),
    );
  }
}
