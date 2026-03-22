import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HubScreen extends StatelessWidget
{
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 26, 105, 28),
        title: Text('The Hub', 
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
            icon: Icon(Icons.settings),
            color: Colors.white,
            tooltip: 'Settings',
            onPressed: (){},
          ),
        ],

      ),
      body: SafeArea
      (
        child: HubWidget(),
      ),
    );
  }
}

class HubWidget extends StatefulWidget
{
  const HubWidget({super.key});

  @override
  State<HubWidget> createState() => _HubWidgetState();
}

class _HubWidgetState extends State<HubWidget>
{
  double binPercent = 0.0;
  void logWork(String work, String iconName)
  {
    FirebaseFirestore.instance.collection('HubOperation').add
    (
      {
        'work': work,
        'icon': iconName,
        'timestamp': DateTime.now(),
      }
    );
  }
  @override
void initState() {
  super.initState();
  fetchBinLevel();
}

void fetchBinLevel() async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("BinStorageCam")
        .orderBy("count", descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      final double fetchedPercent = data['percent']?.toDouble() ?? 0.0;
      setState(() {
        binPercent = fetchedPercent;
      });
    }
  } catch (e) {
    print("❌ Error fetching bin percent: $e");
  }
}
  @override
  Widget build(BuildContext context)
  {
    Color colorvar;
    if (binPercent < 0.5)
      {colorvar = const Color.fromARGB(255, 63, 179, 208);}
    else if (binPercent >= 0.5 && binPercent <= 0.8)
      {colorvar = Colors.yellow;}
    else
      {colorvar = Colors.red;}

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
                child: Image.asset('assets/images/hubStorage2.png', width: 600,height: 300,),
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
                label: Text('Dewan Tunku Canselor (DTC), Universiti Malaya', style: TextStyle(fontSize: 9),),
                icon: Icon(Icons.place, size: 13,),
              ),
        ),),

        Positioned
        (
          left: 15,
          top: 360,
          child: Text
          (
            'Hub Storage Level',
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
              percent: binPercent,
              center: Text("${(binPercent * 100).round()}%",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              progressColor: colorvar,
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
              onPressed: ()=> logWork("Recollection","delete"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 119, 207, 122),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Recollection',style: TextStyle(fontSize: 12),),
              icon: Icon(Icons.delete),
            ),
          ),),

          Positioned
          (
            left: 210,
            top: 505,
            child: SizedBox(
              width: 145,
              height: 52,
            child: TextButton.icon
            (
              onPressed: () => logWork("Cleaning","cleaning_services"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 255, 255, 99),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Cleaning',style: TextStyle(fontSize: 12),),
              icon: Icon(Icons.cleaning_services),
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
              onPressed: () => logWork("Maintenance","build"),
              style: TextButton.styleFrom
              (
                backgroundColor: const Color.fromARGB(255, 209, 103, 96),
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(17),
              ),
              label: Text('Maintenance', style: TextStyle(fontSize: 12),),
              icon: Icon(Icons.build),
            ),
          ),),

          Positioned
          (
            left: 20,
            top: 590,
            child: TextButton.icon
              (
                onPressed:(){Navigator.pushNamed(context, '/history');},
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
