import 'package:flutter/material.dart';

import 'checkable_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: SafeArea(child: MyScreen())),
    );
  }
}

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: MyWidget(),
              );
            }));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      height: 200,
      child: LayoutBuilder(builder: (context, constraints) {
        return CustomPaint(
            painter: CheckableBox(isChecked: true),
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Center(child: Text('hello')),
            ));
      }),
    );
  }
}
