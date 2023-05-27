// ignore_for_file: prefer_is_empty, camel_case_types, unused_field
//import 'package:aboutpaws/widgets/plantdiseasecard.dart';
import 'package:aboutpaws/models/desc_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:aboutpaws/widgets/dogdisplay.dart';
import 'package:flutter/material.dart';
// Imports para sa Machine Learning Side
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class cameraPage extends StatefulWidget {
  const cameraPage({super.key});
  @override
  State<cameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<cameraPage> {
  List<Object> _plantdiseaseList = [];
  List<String> plants = [
    "Airedale",
    "Aspin",
    "Beagle",
    "Bearded Collie",
    "Bloodhound",
    "Boston Terrier",
    "Boxer",
    "Bull Mastiff",
    "Bull Terrier",
    "Bulldog",
    "Chihuahua",
    "Chow Chow",
    "Cocker",
    "Collie",
    "Corgi",
    "Dalmatian",
    "Dobberman",
    "Elk Hound",
    "French Bulldog",
    "German Shepherd",
    "Golden Retriever",
    "Great Dane",
    "Greyhound",
    "Irish Spaniel",
    "Japanese Spaniel",
    "Labrador",
    "Malinois",
    "Pekinese",
    "Pit Bull",
    "Poodle",
    "Pug",
    "Rottweiler",
    "Saint Bernard",
    "Scotch Terrier",
    "Shiba Inu",
    "Shih Tzu",
    "Siberian Husky",
    "Yorkie"
  ];
  String getPlantName() {
    String currentplant = "";
    String mainString = _output?.elementAt(0)['label'];
    for (int i = 0; i < plants.length; i++) {
      if (mainString.contains(plants[i])) {
        currentplant = plants[i];
        break;
      } else {
        continue;
      }
    }
    return currentplant;
  }

  bool loading = true;
  // Lahat ng comment na ito ay para sa Machine Learning Side

  late File _image;
  List? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 24,
        threshold: 0.4,
        asynch: true,
        imageMean: 0,
        imageStd: 1);
    setState(() {
      _output = output;
      if (_output != null && _output!.length > 0) {
        loading = false;
      } else {
        _output?[0] = 'Object cannot be identified';
      }
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/aboutpaws_model_fp16.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
    getPlantName();
    getPlantDiseaseList();
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
    getPlantName();
    getPlantDiseaseList();
  }

  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar para sa taas na design

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "AboutPaws",
          style: TextStyle(
              color: Color.fromRGBO(1, 3, 41, 1.0),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(255, 95, 94, 94),
      ),
      backgroundColor: const Color.fromRGBO(213, 213, 213, 1),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Center(
            child: loading
                ? SizedBox(
                    height: 310,
                    width: 250,
                    child: Column(children: <Widget>[
                      Image.asset('assets/images/placeholder.jpg')
                    ]),
                  )
                : /*const Text(
                      'Yung mga susunod dito yung ilalabas na output kapag na detect yung image') */
                SizedBox(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 300,
                        child: Image.file(_image),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _output != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Dog Breed:\n${_output?.elementAt(0)['label'] ?? 'Object cannot be identified.'}',
                                  style: const TextStyle(
                                      decorationColor:
                                          Color.fromRGBO(59, 59, 59, 1),
                                      fontSize: 20,
                                      fontFamily: 'NunitoMedium',
                                      color: Color.fromRGBO(1, 3, 41, 1.0),
                                      height: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                    child: Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => SecondPage(
                                                  plantname: getPlantName(),
                                                  dimage: _image)));
                                    },
                                    child: const Text(
                                      "Facts About Them",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'NunitoMedium',
                                        color: Color.fromRGBO(1, 3, 41, 1.0),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                )),
                                /* Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: SizedBox(
                                      height: 200.0,
                                      width: 200.0,
                                      child: ListView.builder(
                                        itemCount: _plantdiseaseList.length,
                                        itemBuilder: (context, index) {
                                          return PlantCard(_plantdiseaseList[0]
                                              as PlantDisplay);
                                        },
                                        padding: const EdgeInsets.only(top: 10),
                                      ),
                                    )),
                                  ],
                                )*/
                              ],
                            )
                          : Container(),
                    ]),
                  ),
          ),
          const SizedBox(
            height: 45,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(1, 3, 41, 1.0)),
            child: Column(children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[SizedBox(height: 15)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //Para sa pag open ng Gallery pangkuha ng Image
                      pickGalleryImage();
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(1, 3, 41, 1.0),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xffeeeeee),
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const Text(
                          'From Storage',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NunitoMedium',
                              color: Color(0xffeeeeee)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Para sa pag open ng Camera pangkuha ng Image
                      pickImage();
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(1, 3, 41, 1.0),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xffeeeeee),
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const Text(
                          'Use Camera',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'NunitoMedium',
                              color: Color(0xffeeeeee)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      )),
    );
  }

  void getPlantDiseaseList() async {
    var data =
        await FirebaseFirestore.instance.collection(getPlantName()).get();
    setState(() {
      _plantdiseaseList =
          List.from(data.docs.map((doc) => PlantDisplay.fromSnapshot(doc)));
    });
  }
}
