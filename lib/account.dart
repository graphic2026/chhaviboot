

// import 'package:downloadfile/uploadfile.dart';
import 'package:chhaviboot/uploadfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebase_api.dart';
import 'firebase_file.dart';
import 'image_page.dart';

// Future  main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();   // initialize  the firebase
//   runApp(const MyApp());
// }

class Files extends StatelessWidget {
  const Files({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // color: Colors.black,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Files'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<FirebaseFile>> futureFiles;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    futureFiles = FirebaseApi.listAll('files/');
  }
  void initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      // backgroundColor: Colors.black26,
      title: Text(widget.title),
      centerTitle: true,
    ),
    body: FutureBuilder<List<FirebaseFile>>(

      future: futureFiles,
      builder: (context, snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files.length),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(

                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed:(){
        // const Uploadfile();
        Navigator.push(context,CupertinoPageRoute(builder: (context)=> const Uploadfile()));

      },

      // tooltip: 'Increment',
      child: const Icon(Icons.upload),
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) {
    Widget leadingWidget;
    String fileExtension = file.name.split('.').last.toLowerCase();

    if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
      // Display image for image files
      leadingWidget = ClipOval(
        child: Image.network(
          file.url,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        ),
      );
    } else if(fileExtension=='txt') {
      // Show default file icon for other file types
      leadingWidget = Icon(Icons.insert_drive_file, size: 52, color: Colors.blue);
    }
    else if(fileExtension=='mp4') {
      // Show default file icon for other file types
      leadingWidget = Icon(Icons.video_camera_back, size: 52, color: Colors.blue);
    }
    else{
      leadingWidget = Icon(Icons.file_copy_outlined, size: 52, color: Colors.blue);
    }

    return Column(
      children: [
        ListTile(
          leading: leadingWidget,
          title: Text(
            file.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.blue,
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ImagePage(file: file)),
          ),
        ),
        Divider(
          // color: Colors.black,
        ),
      ],
    );
  }
  Widget buildHeader(int length) => ListTile(
    tileColor: Colors.blue,
    leading: Container(
      width: 52,
      height: 52,
      child: Icon(
        Icons.file_copy,
        color: Colors.white,
      ),
    ),
    title: Text(
      '$length Files',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}

