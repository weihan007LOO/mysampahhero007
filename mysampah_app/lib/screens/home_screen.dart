import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 26, 105, 28),
        title: Text('MySampahHero', 
        style: TextStyle(color: Colors.white,fontSize: 30)),
        centerTitle: true,

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
        child: HomeWidget(),
      ),
      
    );
  }
}

class HomeWidget extends StatelessWidget
{
  const HomeWidget({super.key});
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
          top: 15,
          child: Text
          (
            '  Welcome, XXX!',
            style: TextStyle
            (
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),

        Center
        (
          child: Column
          ( 
            children: 
            [
              const SizedBox(height: 50),
              TextField
              (
                style: TextStyle(color: const Color.fromARGB(255, 154, 154, 154)),
                decoration: InputDecoration
                (
                  labelText: 'Search your Taman',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              InkWell
              (
                onTap:()
                {Navigator.pushNamed(context, '/bin');},
                child: Image.asset('assets/images/mapBin.png', width: 900, height: 300, ),
              ),
              
              const SizedBox(height: 30,),
              InkWell
              (
                onTap:()
                {Navigator.pushNamed(context, '/hub');},
                child: Image.asset('assets/images/hubBin1.png', width: 700, height: 150),
              ),

              const SizedBox(height: 15,),
              TextButton.icon
              (
                onPressed:(){Navigator.pushNamed(context, '/history');},
                label: Text('View my history'),
                icon: Icon(Icons.history),
                style: TextButton.styleFrom
                (
                  backgroundColor: const Color.fromARGB(255, 110, 176, 229),
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        )

      ],
    );
  }
}