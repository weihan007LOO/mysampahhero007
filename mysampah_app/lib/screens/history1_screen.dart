import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class BinHistoryScreen extends StatelessWidget
{
  const BinHistoryScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    const Map<String, IconData> iconMap = {
      'rocket_launch': Icons.rocket_launch,
      'undo': Icons.undo,
      'warning': Icons.warning,
      // Add more icons if needed
    };
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 26, 105, 28),
        title: Text('Hub Operation', 
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
      body: StreamBuilder
      (
        stream: FirebaseFirestore.instance
          .collection('BinOperation')
          .orderBy('timestamp',descending: true)
          .snapshots(),
        
        builder: (context,snapshot)
        {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final BinOperation = snapshot.data!.docs;
          return ListView.builder
          (
            itemCount: BinOperation.length,
            itemBuilder: (context,index)
            {
              final data = BinOperation[index].data();
              final iconName = data['icon'] ?? 'delete';
              final iconData = iconMap[iconName] ?? Icons.help_outline; // fallback icon
              final date = DateFormat.yMMMd().add_jm().format(data['timestamp'].toDate());

              return Column
              (
                children: 
                [
                  Align
                  (alignment: Alignment.topLeft,
                  child: Text("${data['location']}", style: TextStyle(color: const Color.fromARGB(255, 26, 105, 28),fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                  ),
                  ListTile
                  (
                    leading: Icon(iconData),
                    title: Text("${data['work']}"),
                    subtitle: Text(date),
                  ),
                ],
                
              );
            }
          );
        }

      ),
    );
  }
}

