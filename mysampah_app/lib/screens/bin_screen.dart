import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BinScreen extends StatelessWidget
{
  const BinScreen({super.key});
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 26, 105, 28),
        title: Text('Bin Map', 
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
        child: BinWidget(),
      ),
    );
  }
}

class BinWidget extends StatefulWidget {
  const BinWidget({super.key});

  @override
  State<BinWidget> createState() => _BinMapScreenState();
}

class _BinMapScreenState extends State<BinWidget> {
  final LatLng hub = const LatLng(3.12171, 101.65659);
  final List<Map<String, dynamic>> bins = [
    {
      "image": 'assets/images/kk12.png',
      "name": "Bin KK12",
      "position": const LatLng(3.12577, 101.66085),
      "storage": "52%",
      "context": "kk12",
    },
    {
      "image": 'assets/images/kk11.png',
      "name": "Bin KK1",
      "position": const LatLng(3.11785, 101.65944),
      "storage": "70%",
      "context": "kk1",
    },
    {
      "image": 'assets/images/kk2.png',
      "name": "Bin KK2",
      "position": const LatLng(3.11764, 101.65719),
      "storage": "43%",
      "context": "kk2",
    },
  ];

  String? selectedPopup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( child:FlutterMap(
        options: MapOptions(
          initialCenter: hub,
          initialZoom: 15,
          onTap: (_, __) => setState(() {
            selectedPopup = null;
          }),
        ),
        children: [
          // Tile Layer
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.mysampah',
          ),

          // Polyline Layer: connect bins to hub
          PolylineLayer(
            polylines: bins
                .map(
                  (bin) => Polyline(
                    points: [bin["position"], hub],
                    color: Colors.blue,
                    strokeWidth: 3.0,
                  ),
                )
                .toList(),
          ),

          // Marker Layer
          MarkerLayer(
            markers: [
              // Bins
              ...bins.map(
                (bin) => Marker(
                  point: bin["position"],
                  width: 300,
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPopup = bin["name"];
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.delete, size: 35, color: Colors.green),
                        if (selectedPopup == bin["name"])
                          Flexible( 
                            child: TextButton.icon(
                              onPressed: (){Navigator.pushNamed(context, '/${bin["context"]}');},
                              label: Text("${bin["name"]} (${bin["storage"]})", style: const TextStyle(fontSize: 6),),
                              icon: Icon(Icons.arrow_forward),
                              style: TextButton.styleFrom
                              (
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(3),
                              ),
                              
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Hub
              Marker(
                point: hub,
                width: 60,
                height: 60,
                child: Column(
                  children: [
                    IconButton(icon: Icon(Icons.home), iconSize: 40, color: Color.fromARGB(255, 26, 105, 28), onPressed:(){Navigator.pushNamed(context, '/hub');},),
                    Text("Hub", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),),
    );
  }
}