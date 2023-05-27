import 'package:flutter/material.dart';
import 'package:aboutpaws/models/desc_display.dart';

class DogCard extends StatelessWidget {
  final DogDisplay _dogDisplay;

  const DogCard(this._dogDisplay, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        color: const Color.fromRGBO(1, 3, 41, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "${_dogDisplay.description}",
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'RobotoLight',
                            color: Color(0xffeeeeee)),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
