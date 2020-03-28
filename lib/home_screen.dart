import 'dart:math';

import 'package:flutter/material.dart';
import 'package:truth_and_dare/truth_dare_repository.dart';
import 'package:truth_and_dare/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  AnimationController rotationController;
  final int MIN_TIME = 500;
  final int MAX_TIME = 6000;
  int randomTime;
  double randomEndDirection;

  @override
  void initState() {
    super.initState();
    randomTime = getRandomTimeToRotate();
    randomEndDirection = getRandomEndDirection();
    rotationController = AnimationController(
        duration:  Duration(milliseconds: randomTime), vsync: this);
    rotationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        showTruthDareChooseDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
//          color: Colors.yellow,
            image: DecorationImage(
              image: AssetImage("images/homebg.jpg"),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Text("Truth Or Dare",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Shutle',
              fontWeight: FontWeight.w800,
              fontSize: 48.0,
            ),),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      randomTime = getRandomTimeToRotate();
                      randomEndDirection = getRandomEndDirection();
                    });
                    rotationController.forward(from: 0.0);
                  },
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: randomEndDirection).animate(rotationController),
                    child: Image.asset('images/bottle.png',
                     height: 210.0,) ,
              ),
                ),
      ),
            ),
            Text("Tap on bottle to spin",
            style: TextStyle(
              fontFamily: 'Microsoft',
              color: Colors.red,
              fontSize: 28.0
            ),),
            SizedBox(
              height: 40.0,
            )
          ],
        ),)
    );
  }

  getRandomTimeToRotate(){
    int randomTime = MIN_TIME + Random().nextInt(MAX_TIME - MIN_TIME);
    debugPrint("random time $randomTime");
    return randomTime;
  }

  double getRandomEndDirection() {
    double randomEndDirection = 2.0 + Random().nextDouble();
    debugPrint("end direction $randomEndDirection");
    return randomEndDirection;
  }

  void showTruthDareChooseDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.blue,
            content: Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        showTruthDareDialog(1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("TRUTH",style: dialogTextStyle,),
                      )),
                  Container(
                    width: 2.0,
                    height: 48.0,
                    color: Colors.white,
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        showTruthDareDialog(2);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("DARE",style: dialogTextStyle,),
                      ))
                ],
              ),
            ),
          );
        }
    );

  }

  void showTruthDareDialog(int truthDare) {
    int index = Random().nextInt(10);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.blue,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: Text(truthDare==1?getTruthList()[index]:getDareList()[index],style: dialogTextStyle,)),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text("OK",style: dialogTextStyle,),
                      ))
                ],
              ),
            ),
          );
        }
    );

  }
}
