import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _pseudo = TextEditingController();

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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
    int total = random1 + random2;
    setState(() {
      random1 = Random().nextInt(6) + 1;
      random2 = Random().nextInt(6) + 1;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            //title: Text('Login'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _pseudo,
                      decoration: InputDecoration(
                        labelText: 'Entrez votre pseudo',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("Votre score est de $total"),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text(
                    "Envoyer",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    sendScore();
                    Navigator.pop(context);
                  })
            ],
          );
        },
      );
    });
  }

  sendScore() async {
    int total = random1 + random2;
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('http://localhost/api1/public/api/dedes'));
    request.body = json.encode({"pseudo": _pseudo.text, "score": total});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
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
