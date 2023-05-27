import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aboutpaws/models/desc_display.dart';
import 'package:flutter/material.dart';
import 'package:aboutpaws/widgets/desc_card.dart';

class SecondPage extends StatefulWidget {
  final String dogname;
  final File dimage;
  const SecondPage({Key? key, required this.dogname, required this.dimage})
      : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Object> _dogList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDogList();
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.dogname;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color.fromRGBO(1, 3, 41, 1.0)),
          centerTitle: true,
          title: Text(
            "Facts About $name",
            style: const TextStyle(
                color: Color.fromRGBO(1, 3, 41, 1.0),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(255, 95, 94, 94),
        ),
        body: Column(children: <Widget>[
          SizedBox(
            height: 300,
            child: Image.file(widget.dimage),
          ),
          Expanded(
            child: SizedBox(
                child: SafeArea(
              child: ListView.builder(
                itemCount: _dogList.length,
                itemBuilder: (context, index) {
                  return DogCard(_dogList[index] as DogDisplay);
                },
                padding: const EdgeInsets.only(top: 10),
              ),
            )),
          )
        ]));
  }

  Future getDogList() async {
    var data =
        await FirebaseFirestore.instance.collection(widget.dogname).get();
    setState(() {
      _dogList =
          List.from(data.docs.map((doc) => DogDisplay.fromSnapshot(doc)));
    });
  }
}
