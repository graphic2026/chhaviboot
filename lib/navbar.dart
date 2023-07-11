import 'package:camera/camera.dart';
import 'package:chhaviboot/account.dart';
import 'package:chhaviboot/calendar.dart';
import 'package:chhaviboot/home.dart';
import 'package:chhaviboot/main.dart';
import 'package:chhaviboot/news.dart';
import 'package:chhaviboot/uploadfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:navbar_jurident/hamburger.dart';


class Navbar extends StatefulWidget {
  // const Navbar({Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  const Navbar(this.cameras, {super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentTab=0;

  //the below code declares a constant (final) variable named screen that holds a
  // list (List) of objects of type Widget.
  final List<Widget> screens=[
     Home(cameras!),
    const News(),
    const Calendar(),
    const Files(),

  ];

  // PageStorageBucket
  // It represents a storage bucket used to store and restore the state of widgets.
  //below lines of code is often used when you need to store and restore the state
  // of widgets in Flutter applications, typically in scenarios where you have multiple
  // screens or pages and want to persist their state when navigating between them.
  final PageStorageBucket bucket=PageStorageBucket();
  Widget currentScreen= Home(cameras!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageStorage(
        bucket: bucket,
        child:currentScreen ,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded,color: Colors.white,size: 35,),
        //Try adding the 'const' keyword to the constructor invocation.
        onPressed: (){
          Navigator.push(context,
              CupertinoPageRoute(
                  builder: (context) => const Uploadfile())
          );

        },
        backgroundColor:  Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: const CircularNotchedRectangle(), //represents a rectangular shape with a circular notch at the bottom
        color: Colors.black,
        notchMargin: 0,
        child: Container(
          height: 60,
          // color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen=Home(cameras!);
                        currentTab=0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab==0? Colors.blue: Colors.white,
                        ),
                        Text('Home',style: TextStyle(
                          color: currentTab==0? Colors.blue : Colors.white,
                        ),)
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen=const News();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.newspaper,
                          color: currentTab==1?   Colors.blue : Colors.white,
                        ),
                        Text('News',style: TextStyle(
                          color: currentTab==1? Colors.blue: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
              //Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen=const Calendar();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: currentTab==2? Colors.blue: Colors.white,
                        ),
                        Text('Chats',style: TextStyle(
                          color: currentTab==2? Colors.blue : Colors.white,
                        ),)
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        currentScreen=const Files();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          color: currentTab==3? Colors.blue : Colors.white,
                        ),
                        Text('Files',style: TextStyle(
                          color: currentTab==3?  Colors.blue: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
