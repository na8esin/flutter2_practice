import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: MyBody(),
    ),
  ));
}

class MyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            // Setting floatHeaderSlivers to true is required in order to float
            // the outer slivers over the inner scrollable.
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // Text()などだとowner!._debugCurrentBuildTarget == this': is not true.
                // が発生する
                SliverAppBar(
                  title: const Text('Floating Nested SliverAppBar'),
                  floating: true,
                  expandedHeight: 200.0,
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: Text('hello')));
  }
}
