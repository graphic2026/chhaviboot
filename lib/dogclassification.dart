import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tflite/tflite.dart';

class DogClassification extends StatefulWidget {
  const DogClassification({Key? key}) : super(key: key);

  @override
  State<DogClassification> createState() => _DogClassificationState();
}

class _DogClassificationState extends State<DogClassification> {
  bool? _loading;
  File? _image;
  List? _outputs;
  final _imagePicker = ImagePicker();
  FlutterTts flutterTts=FlutterTts();
  String res=" ";

  // int _counter = 0;


  speak(String str) async{
    if(str==""){
      await flutterTts.speak("Please select the Image ");
    }
    await flutterTts.speak(str);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  pickImageFromGallery() async {
    var image = await _imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState((){
      _loading =true;
      _image=File(image.path);
    }
    );
    classifyImage(_image!);
  }

  pickImageFromCamera() async {
    var image1 = await _imagePicker.getImage(source: ImageSource.camera);
    if (image1 == null) return null;
    setState((){
      _loading =true;
      _image=File(image1.path);
    }
    );
    classifyImage(_image!);
  }

  // classify the image selected
  classifyImage(File image) async {
    // var path;
    // var path;
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd:127.5,

    );
    setState(() {
      _loading=false;
      _outputs=output!;
      print(
          "Hello");
      print(_outputs);

      res= "${_outputs![0]["label"]}".replaceAll(RegExp(r'[0-9]'), '');
      print(res);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () {
          if(identical(res, " ")){
            speak("Please select the Image");
          }
          else{
            speak(res);
          }
        },
        child: Container(
          decoration: const BoxDecoration(

            image: DecorationImage(
              image: AssetImage("assets/download.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: _loading!
              ? Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
              : Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image == null
                    ? Container()
                    :  Container(
                  // height: 180,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(

                      topRight: Radius.circular(100.0),
                      bottomRight: Radius.circular(100.0),
                      topLeft: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0),
                    ),
                    // color: Colors.white,
                    //   fit: BoxFit.cover,

                  ),
                  child: Container(

                    child: Image.file(_image!),
                    height: 500,
                    width: MediaQuery.of(context).size.width - 200,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                // print(_outputs);
                _outputs != null

                    ? Text(
                  "${_outputs![0]["label"]}"
                      .replaceAll(RegExp(r'[0-9]'), ''),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()..color = Colors.white,
                      fontWeight: FontWeight.bold),
                )
                    : Text("Classification Waiting.....", style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      ),


      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'soundButton',
            onPressed: (){

            if(identical(res, " ")){
              speak("Plase select the Image");
            }
            else{
              speak(res);
            }

          },
            label: const Text('Sound'),
            icon: const Icon(Icons.keyboard_voice_sharp),
            // backgroundColor: Colors.blue/,
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: 'galleryButton',
            onPressed: pickImageFromGallery,
            tooltip: 'Increment',
            child: const Icon(Icons.photo_album),
          ),
          SizedBox(height: 20,),
          FloatingActionButton(
            heroTag: 'cameraButton',
            onPressed: pickImageFromCamera,
            tooltip: 'Increment',
            child: const Icon(Icons.camera),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

