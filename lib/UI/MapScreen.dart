// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MapState();
//   }
// }

// class MapState extends State<MapScreen> {
//   GoogleMapController _mapController;

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ETST"),
//       ),
//       body: Stack(children: [
//         GoogleMap(
//           mapType: MapType.hybrid,
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (controller) {
//             _mapController = controller;
//           },
//         ),
//         Positioned(
//           bottom: 16.0,
//           left: 16.0,
//           child: RaisedButton(
//             child: Text("Move Camera"),
//             onPressed: (){
//               _mapController.animateCamera(
//                 CameraUpdate.newLatLng(LatLng(51.5, 0)),
//               );
//             },
//           )
//         ),
//       ]),
//     );
//   }
// }
