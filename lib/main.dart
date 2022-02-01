import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dédé'),
          backgroundColor: Colors.red,
        ),
        body: DiceChange(),
      ),
    ),
  );
}

class DiceChange extends StatefulWidget {
  const DiceChange({Key? key}) : super(key: key);

  @override
  _DiceChangeState createState() => _DiceChangeState();
}

class _DiceChangeState extends State<DiceChange> {
  int random1 = Random().nextInt(6) + 1;
  int random2 = Random().nextInt(6) + 1;
  void DiceChange1() {
    setState(() {
      random1 = Random().nextInt(6) + 1;
      random2 = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FlatButton(
                onPressed: (DiceChange1),
                child: Image.asset(
                  'images/dice$random1.png',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FlatButton(
                onPressed: (DiceChange1),
                child: Image.asset(
                  'images/dice$random2.png',
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
