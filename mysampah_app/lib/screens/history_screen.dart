import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class HistoryScreen extends StatelessWidget
{
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    const Map<String, IconData> iconMap = {
      'delete': Icons.delete,
      'cleaning_services': Icons.cleaning_services,
      'build': Icons.build,
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
            onPressed: (){Navigator.pushNamed(context, '/hub');},
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
          .collection('HubOperation')
          .orderBy('timestamp',descending: true)
          .snapshots(),
        
        builder: (context,snapshot)
        {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final HubOperation = snapshot.data!.docs;
          return ListView.builder
          (
            itemCount: HubOperation.length,
            itemBuilder: (context,index)
            {
              final data = HubOperation[index].data();
              final iconName = data['icon'] ?? 'delete';
              final iconData = iconMap[iconName] ?? Icons.help_outline; // fallback icon
              final date = DateFormat.yMMMd().add_jm().format(data['timestamp'].toDate());

              return ListTile
              (
                leading: Icon(iconData),
                title: Text("${data['work']}"),
                subtitle: Text(date),
              );
            }
          );
        }

      ),
    );
  }
}

