import 'package:chhaviboot/dogclassification.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class ChoiceClassification extends StatefulWidget {
  const ChoiceClassification({Key? key}) : super(key: key);

  @override
  State<ChoiceClassification> createState() => _ChoiceClassificationState();
}

// class _ChoiceClassificationState extends State<ChoiceClassification> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//
//         child: Container(
//           alignment:Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(onPressed: (){}, child: Text('Dog Classification'),),
//               SizedBox(height: 20,),
//               ElevatedButton(onPressed: (){}, child: Text('Coin Classification')),
//               SizedBox(height: 20,),
//               ElevatedButton(onPressed: (){}, child: Text('Cat Classification')),
//             ],
//           ),
//
//         ),
//       ),
//
//     );
//   }
// }

class _ChoiceClassificationState extends State<ChoiceClassification> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _animation,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>DogClassification()),
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Dog Classification'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _animation,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Coin Classification'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _animation,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Cat Classification'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

