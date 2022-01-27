import 'dart:async';

import 'package:covid_app_api/views/worldstates.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController = new AnimationController(
    duration: Duration(seconds: 3),
    vsync: this)..repeat();
    @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    
  }

    @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStates())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Data"),
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        // foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: Container(
                child: Center(
                  child: Image(
                    image: AssetImage("assets/images/virus.png")),
                ),
              ),
               builder: (BuildContext context,
               Widget? child){
                return Transform.rotate(angle: _animationController.value *2.0*math.pi,child: child ,);
            }),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            Align(
                 alignment: Alignment.center,
                 child :Text('Covid-19\nTracker App' , textAlign: TextAlign.center ,
                     style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25)
                     ,))
 
          ],
        ),
      ),
    );

  }
}