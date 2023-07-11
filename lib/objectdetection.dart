import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class ObjectDetection extends StatefulWidget {
  final List<CameraDescription> cameras;

  ObjectDetection(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<ObjectDetection> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String? _model = "";
  double borderRadius = 50;
  //
  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String? res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return  Container(
      // color: Colors.lightBlue,
      color: Colors.black,
      // decoration: BoxDecoration(
      //
      //   image: DecorationImage(
      //     image: AssetImage("assets/download.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:
        _model == ""
            ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    onSelect('ssd');
                  },
                  child: const Text('ssd'),

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    onSelect('yolo');
                  },
                  child: const Text('yolo'),
                  // ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    onSelect('mobilenet');
                  },
                  child: const Text('mobilenet'),
                  // ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    onSelect('posenet');
                  },
                  child: const Text('posenet'),
                  // ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    padding: EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children:[
          //     ElevatedButton(
          //
          //         onPressed: () =>{
          //           onSelect(ssd),
          //         },
          //         child: const Text('ssd'),
          //         style: ElevatedButton.styleFrom(
          //           minimumSize: Size(200, 50),)
          //     ),
          //     SizedBox(height: 20,),
          //     ElevatedButton(
          //
          //         onPressed: () =>{
          //           onSelect(yolo),
          //         },
          //         child: const Text('yolo'),
          //         style: ElevatedButton.styleFrom(
          //           minimumSize: Size(200, 50),)
          //     ),
          //     SizedBox(height: 20,),
          //     ElevatedButton(
          //
          //         onPressed: () =>{
          //           onSelect(mobilenet),
          //         },
          //         child: const Text('mobilenet'),
          //         style: ElevatedButton.styleFrom(
          //           minimumSize: Size(200, 50),)
          //     ),
          //     SizedBox(height: 20,),
          //     ElevatedButton(
          //
          //         onPressed: () =>{
          //           onSelect(posenet),
          //         },
          //         child: const Text('posenet'),
          //         style: ElevatedButton.styleFrom(
          //           minimumSize: Size(200, 50),)
          //     ),
          //   ],
          // ),
        )
            : Stack(
          children: [
            Camera(
              widget.cameras,
              _model!,
              setRecognitions,
            ),
            BndBox(
                _recognitions==null ? [] : _recognitions! ,
                math.max(_imageHeight, _imageWidth),
                math.min(_imageHeight, _imageWidth),
                screen.height,
                screen.width,
                _model!),
          ],
        ),
      ),
    );
  }
}