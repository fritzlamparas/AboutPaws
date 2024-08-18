import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: const Text(
                'About the App',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NunitoBold',
                    color: Color.fromRGBO(198, 142, 77, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: const Text(
                'AboutPaws is a mobile application that utilizes machine learning through image processing to classify the dog breed of the uploaded image.',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'NunitoMedium',
                    color: Color.fromRGBO(59, 59, 59, 1),
                    height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: const Text('App Developer',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'NunitoBold',
                      color: Color.fromRGBO(198, 142, 77, 1.0)),
                  textAlign: TextAlign.center),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Color.fromRGBO(59, 59, 59, 1.0),
                        radius: 60,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage('assets/images/Fritz_pic.jpg'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: const Text(
                          'Fritz D. Lamparas',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NunitoMedium',
                              color: Color.fromRGBO(59, 59, 59, 1)),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
