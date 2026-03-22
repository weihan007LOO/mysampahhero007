import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/hub_screen.dart';
import 'screens/bin_screen.dart';
import 'screens/kk12_screen.dart';
import 'screens/kk1_screen.dart';
import 'screens/kk2_screen.dart';
import 'screens/history_screen.dart';
import 'screens/history1_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp
  (
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'MySampahHero',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 241, 152)),
      initialRoute: '/',
      routes: 
      {
        '/': (context)=> HomeScreen(),
        '/hub': (context)=> HubScreen(),
        '/bin': (context)=> BinScreen(),
        '/kk12': (context)=> KK12Screen(),
        '/kk1': (context)=> KK1Screen(),
        '/kk2': (context)=> KK2Screen(),
        '/history': (context) => HistoryScreen(),
        '/historya': (context) => BinHistoryScreen(),
      },
    );
  }
}