import 'package:flutter/material.dart';
import 'main.dart';

class Hamburger extends StatefulWidget {
  const Hamburger({Key? key}) : super(key: key);

  @override
  State<Hamburger> createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('iitrpr.ac.in'),
            accountEmail: Text('example@gmail.com'),

            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/ropar1.jpg")
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Instructions'),
            onTap: () => _openInstructionsScreen(context),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About Us'),
            onTap: () => _openAboutUsScreen(context),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}


void _openInstructionsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => InstructionsScreen(),
    ),
  );
}
void _openAboutUsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AboutUsScreen(),
    ),
  );
}


class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'INSTRUCTIONS FOR USE',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(

              'a.  Launch the  app.\n\n'
                  'b.  Hold the Android device on the top of the Indian currency note that you wish to recognize. Around three inches is the recommended distance between the phone camera and the currency note. \n\n'
                  'c.  Tap on the screen and hear the message. The App would speak out either the predicted denomination of the currency note or the message to Try again. If Talkback is ON, you have to then Double Tap on screen\n\n'
                  'd.  It is recommended to use the App at least twice for the same currency note by showing both the front and back side. If the App speaks out the same denomination for both ends, then one can be more convinced about the results. \n\n'
                  'e.  For listening the last currency denomination spoken out by App, one can press the REPEAT button that is located at the bottom of the App. \n\n'
                  'f.  Rear camera is set to be the default camera, but one can choose to use the front camera. When using the front camera option, hold the currency note around three inches above the Android device. Button to switch the camera is located at the top right corner of the App\n\n '
                  'g.  One can also turn on the flash light of the device, if so needed and available. h. Button to turn on/off the Flash light is located at the top left corner of the App.\n\n'
              ,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Another paragraph of instructions...',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'ChhaviBoot App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Image.asset('assets/imj.png'), // Replace with your currency image
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'About App',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),

          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Another paragraph of instructions...',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),

          // Container(
          //   margin: EdgeInsets.only(bottom: 16.0),
          //   child: Text(
          //     'Paragraph about the app goes here...',
          //     style: TextStyle(
          //       fontSize: 16.0,
          //       fontFamily: 'Roboto',
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Features',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Another paragraph of instructions...',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Developer',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Paragraph about the developer goes here...',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}