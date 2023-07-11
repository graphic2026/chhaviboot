import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'navbar.dart';
//
// void main() {
//   runApp(const MyApp());
// }

late List<CameraDescription>? cameras;
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Navbar(cameras!),
    );
  }
}