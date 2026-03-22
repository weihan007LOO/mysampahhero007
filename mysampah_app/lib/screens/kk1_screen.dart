import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class KK1Screen extends StatelessWidget
{
  const KK1Screen({super.key});
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 26, 105, 28),
        title: Text('Bin KK1', 
        style: TextStyle(color: Colors.white, fontSize: 30,)),
        centerTitle: true,

        leading: IconButton
        (
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            tooltip: 'Back',
            onPressed: (){Navigator.pushNamed(context, '/');},
        ),

        actions: 
        [
          IconButton
          (
            icon: Icon(Icons.arrow_forward),
            color: Colors.white,
            tooltip: 'Next',
            onPressed: (){Navigator.pushNamed(context, '/kk2');},
          ),
        ],

      ),
      body: SafeArea
      (
        child: KK1Widget(),
      ),
    );
  }
}

class KK1Widget extends StatelessWidget
{
  void logBin(String work, String iconName, String loco)
  {
    FirebaseFirestore.instance.collection('BinOperation').add
    (
      {
        'work': work,
        'icon': iconName,
        'location': loco,
        'timestamp': DateTime.now(),
      }
    );
  }
  KK1Widget({super.key});
  @override
  Widget build(BuildContext context)
  {
    return Stack
    (
      children: 
      [
        Container
        (
          color: const Color.fromARGB(241, 255, 250, 204),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned
        ( 
          top: 340,
          child: Container
          (
            color: const Color.fromARGB(255, 227, 227, 227),
            width: MediaQuery.of(context).size.width,
            height: 320,
          ),
        ),
        Center
        (
          child: Column
          (
            children: 
            [
              InkWell
              (
                onTap: (){Navigator.pushNamed(context, '/bin');},
                child: Image.asset('assets/images/KK1.png', width: 600,height: 300,),
              ),
            ],
          ),
        ),

        Positioned
        (
          left: 30,
          top: 290,
          child: SizedBox
          (
            width: 300,
            height: 28,
          child: TextButton.icon
              (
                onPressed: (){},
                style: TextButton.styleFrom
                (
                  backgroundColor: const Color.fromARGB(255, 209, 103, 96),
                  foregroundColor: Colors.black,
                ),
                label: Text('Kolej Kediaman Tunku Abdul Rahman (KK1), Universiti Malaya', style: TextStyle(fontSize: 9),),
                icon: Icon(Icons.place, size: 13,),
              ),
        ),),

        Positioned
        (
          left: 15,
          top: 360,
          child: Text
          (
            'Bin Storage Level',
            style: TextStyle
            (
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        Positioned
        ( 
          left: 15,
          top:415,
          
            child: CircularPercentIndicator
            (
              radius: 80.0,
              lineWidth: 20.0,
              percent: 0.85,
              center: Text
              (
                "85%",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.red,
              backgroundColor: Colors.grey,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),

          Positioned
          (
            left: 210,
            top: 420,
            child: SizedBox(
              width: 145,
              height: 50,
            child: TextButton.icon
            (
              onPressed: ()=> logBin("Go to Hub","rocket_launch", "Bin KK1"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 119, 207, 122),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Go to Hub'),
              icon: Icon(Icons.rocket_launch),
            ),
          ),),

          Positioned
          (
            left: 210,
            top: 505,
            child: SizedBox(
              width: 145,
              height: 50,
            child: TextButton.icon
            (
              onPressed: ()=> logBin("Return Point","undo", "Bin KK1"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 255, 255, 99),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Return Point'),
              icon: Icon(Icons.undo),
            ),
          ),),

          Positioned
          (
            left: 210,
            top: 585,
            child: SizedBox(
              width: 145,
              height: 50,
            child: TextButton.icon
            (
              onPressed: ()=> logBin("Alert Alarm","warning", "Bin KK1"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 209, 103, 96),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Alert Alarm'),
              icon: Icon(Icons.warning),
            ),
          ),),

          Positioned
          (
            left: 20,
            top: 590,
            child: TextButton.icon
              (
                onPressed:(){Navigator.pushNamed(context, '/historya');},
                label: Text('View my history'),
                icon: Icon(Icons.history),
                style: TextButton.styleFrom
                (
                  backgroundColor: const Color.fromARGB(255, 87, 90, 94),
                  foregroundColor: Colors.black,
                ),
              ),
          ),

      ],
    );
  }
}