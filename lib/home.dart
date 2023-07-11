// import 'package:flutter/material.dart';
// // import 'changetheme.dart';
// import 'hamburger.dart';
// import 'navbar.dart';
// // import 'theme_provider.dart';
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final text = MediaQuery.of(context).platformBrightness== Brightness.light
//     //     ? 'DarkTheme'
//     //     : 'LightTheme';
//     return Scaffold(
//       backgroundColor: Colors.black,
//       drawer: const Hamburger(),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Center(child: Text('Home')),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Handle notification icon button press
//             },
//             icon: Icon(Icons.notifications),
//           ),
//         ],
//         // actions: [
//         //   ChangeThemeButtonWidget(),
//         // ],
//       ),
//       body:  const Center(
//
//       ),
//
//     );
//   }
// }

import 'package:camera/camera.dart';
import 'package:chhaviboot/choiceclassification.dart';
import 'package:chhaviboot/objectdetection.dart';
import 'package:chhaviboot/segmentation.dart';
import 'package:chhaviboot/textconverter.dart';
import 'package:flutter/material.dart';
// import 'changetheme.dart';
import 'hamburger.dart';
import 'navbar.dart';
// import 'theme_provider.dart';


class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  const Home(this.cameras, {super.key});
  @override
  Widget build(BuildContext context) {
    // final text = MediaQuery.of(context).platformBrightness== Brightness.light
    //     ? 'DarkTheme'
    //     : 'LightTheme';
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const Hamburger(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notification icon button press
            },
            icon: Icon(Icons.notifications),
          ),
        ],
        // actions: [
        //   ChangeThemeButtonWidget(),
        // ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: _buildAnimatedContainer(
                    context,
                    image: Image.asset('assets/txt.png'),
                    text: 'Text Converter',
                    color:  Colors.blue,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>ObjectDetection(cameras!)),
                    );
                  },
                  child: _buildAnimatedContainer(
                    context,
                    image: Image.asset('assets/imagesoo.png',width:120 ,height: 120,),
                    text: 'Object Detection',
                    color: Colors.blue,
                  ),
                ),

              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>ChoiceClassification()),
                    );

                  },
                  child: _buildAnimatedContainer(
                    context,
                    image: Image.asset(
                      'assets/ncbg.png',
                      width: 150, // Adjust the width as per your requirement
                      height: 150, // Adjust the height as per your requirement
                    ),
                    text: 'Classification',
                    color: Colors.blue,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>Segmentation(cameras!)),
                    );

                  },
                  child: _buildAnimatedContainer(
                    context,
                    image: Image.asset('assets/seg3.png',height:140 ,width: 120,),
                    text: 'Segmentation',
                    color: Colors.blue,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(BuildContext context,
      {required Image image,required Color color, required String text}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  SizedBox(height: 10),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
