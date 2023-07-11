import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

// Global Camera object
// late List<CameraDescription> cameras;
//
// // main load function: async because of camera initiations
//  segmentationimage() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     print('Error: $e.code\nError Message: $e.message');
//   }
//   runApp(MyApp());
// }
//
// // stateless widget to load the main home widget
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'tflite image segmentation',
//       home: Segmentation(cameras),
//     );
//   }
// }

class Segmentation extends StatefulWidget {
  // private camera object: get assigned to global one
  final List<CameraDescription> cameras;

  const Segmentation(this.cameras, {super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Segmentation> {
  late CameraController controller;
  var recognitions;
  int whichCamera = 0;
  Uint8List? _segmentedImage;
  bool isProcessing = false;

  // load tflite model for deeplab v3
  loadModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: "assets/deeplabv3_257_mv_gpu.tflite",
      labels: "assets/deeplabv3_257_mv_gpu.txt",
    );
    print(res);
  }

  // initiate camera controller
  void initiateCamera(int whichCamera) {
    this.controller = CameraController(
      widget.cameras[whichCamera],
      ResolutionPreset.low,
    );
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      this.controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        controller.startImageStream((CameraImage img) {
          if (!isProcessing) {
            Tflite.runSegmentationOnFrame(
              bytesList: img.planes.map((plane) => plane.bytes).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              rotation: 90,
              outputType: "png",
              asynch: true,
            ).then((rec) {
              setState(() {
                recognitions = rec;
                isProcessing = false;
              });
            }).catchError((error) {
              setState(() {
                isProcessing = false;
              });
              print('Error running segmentation: $error');
            });
          }
        });
      });
    }
  }

  // Pick image from camera
  void pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      segmentImage(File(pickedImage.path));
    }
  }

  // Pick image from gallery
  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      segmentImage(File(pickedImage.path));
    }
  }

  // Perform image segmentation on the selected image
  void segmentImage(File image) async {
    var output = await Tflite.runSegmentationOnImage(
      path: image.path,
    );
    setState(() {
      _segmentedImage = output;
    });
  }

  // Restart the realtime segmentation when tapping on the screen
  void restartSegmentation() {
    if (isProcessing) return;
    isProcessing = true;
    setState(() {
      recognitions = null;
    });
  }

  // Widget for rendering the realtime camera on the screen
  Widget cameraShow() {
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        child: Text("Not initialized"),
      );
    }

    Size? tmp = MediaQuery.of(context).size;
    var screenW;
    var screenH;

    if (tmp == null) {
      screenW = 0;
    } else {
      screenW = tmp.width;
      screenH = tmp.height;
      tmp = controller.value.previewSize;
    }

    return GestureDetector(
      onTap: restartSegmentation, // Restart the realtime segmentation on tap
      child: Container(
        child: CameraPreview(controller),
        constraints: BoxConstraints(
          maxHeight: 550,
          maxWidth: screenW,
        ),
      ),
    );
  }

  // Widget for rendering the segmented portion of the image
  Widget renderSegmentPortion() {
    if (whichCamera == 2) {
      return RotatedBox(
        quarterTurns: 2,
        child: Image.memory(recognitions, fit: BoxFit.fill),
      );
    } else {
      return Image.memory(recognitions, fit: BoxFit.fill);
    }
  }

  // Widget for segmentation results
  Widget segmentationResults() {
    return Opacity(
      opacity: 0.4,
      child: recognitions == null
          ? Center(child: Text('Not initialized'))
          : renderSegmentPortion(),
    );
  }

  // Widget for displaying the segmented image
  Widget segmentedImageContainer() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Image.memory(_segmentedImage!, fit: BoxFit.cover),
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initiateCamera(whichCamera);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size? tmp = MediaQuery.of(context).size;
    var screenW;
    var screenH;

    if (tmp == null) {
      screenW = 0;
    } else {
      screenW = tmp.width;
      screenH = tmp.height;
      tmp = controller.value.previewSize;
    }

    setState(() {});
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Image Segmentation')),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                child: Icon(Icons.people),
                tooltip: 'Pick from Camera',
                backgroundColor: Colors.redAccent,
                onPressed: pickImageFromCamera,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(Icons.camera),
                tooltip: 'Pick from Gallery',
                backgroundColor: Colors.redAccent,
                onPressed: pickImageFromGallery,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: cameraShow(),
          ),
          Positioned(
            top: 0,
            left: 0,
            width: screenW,
            height: 550,
            child: segmentationResults(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _segmentedImage != null
                  ? segmentedImageContainer()
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}