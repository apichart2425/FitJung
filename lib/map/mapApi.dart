import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'place_detail.dart';

const kGoogleApiKey = "AIzaSyD0LqZgBAAQ13CrzjuXXL6nD6oLNC5p0Hk";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// void main() {
//   runApp(MaterialApp(
//     title: "Fitness",
//     home: Home(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class MapApiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapScreen();
  }
}

class MapScreen extends State<MapApiPage> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    } else {
      expandedChild = buildPlacesList();
    }

    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("Fitness"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refresh();
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 200.0,
                  child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      options: GoogleMapOptions(
                          myLocationEnabled: true,
                          cameraPosition:
                              const CameraPosition(target: LatLng(0.0, 0.0))))),
            ),
            Expanded(child: expandedChild)
          ],
        ));
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude,center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2000);
    var list = [
      'gym',
      'health',
      'point_of_interest',
      'establishment',
      'health club',
      'park',
      'food',
      'ยิม'
    ];
    var listname = [
      'fitness',
      'ฟิตเนส',
      'kmitl',
      'market',
      'FBT',
      'Fitness',
      'Avion'
    ];

    print("result.status thisis -*-*-*-*-*- ${result}");
    setState(() {
      this.isLoading = false;

      if (result.status == "OK") {
        // this.places = result.results;
        result.results.forEach((f) {
          print('F types ${f.types} ++++  f name ${f.name}');

          for(var a in f.types){
            // print("checking list ${list.contains(a.toLowerCase())}");
            print('F types ${a}');
            if (list.contains(a.toLowerCase())){
              print(list.contains(a.toLowerCase()));
              this.places.add(f);
              final markerOptions = MarkerOptions(
                position:
                    LatLng(f.geometry.location.lat, f.geometry.location.lng),
                infoWindowText:
                    InfoWindowText("${f.name}", "${f.types}"));
              mapController.addMarker(markerOptions);
            }
            break;
            }

          // print("a.toLowerCase   ${f.name.toLowerCase()}");

          // if (listname.contains(f.name.toLowerCase())){
          //   this.places.add(f);
          //   final markerOptions = MarkerOptions(
          //     position:
          //         LatLng(f.geometry.location.lat, f.geometry.location.lng),
          //     infoWindowText:
          //         InfoWindowText("${f.name}", "${f.types?.first}"));
          //   mapController.addMarker(markerOptions);
          // }

          // for(var a in f.name){
          //   print("this is AAAAA ${a}");
          //   print("${listname.contains(a)}");
          //   print("---------------------------------");
          // if (listname.contains(a.toLowerCase())){
          //     print("a.toLowerCase   ${a.toLowerCase()}");
          //   this.places.add(f);
          //   final markerOptions = MarkerOptions(
          //     position:
          //         LatLng(f.geometry.location.lat, f.geometry.location.lng),
          //     infoWindowText:
          //         InfoWindowText("${f.name}", "${f.types?.first}"));
          //   mapController.addMarker(markerOptions);
          // }

          // break;
          // }
          // final markerOptions = MarkerOptions(
          //   position:
          //       LatLng(f.geometry.location.lat, f.geometry.location.lng),
          //   infoWindowText:
          //       InfoWindowText("${f.name}", "${f.types?.first}"));
          // mapController.addMarker(markerOptions);
              });
            } else {
              this.errorMessage = result.errorMessage;
            }
          });

          
          //OG
      //     setState(() {
      //       this.isLoading = false;
      //       if (result.status == "OK") {
      //         this.places = result.results;
      //         result.results.forEach((f) {
      //           // print("this f.name ${f.name}");
      //           final markerOptions = MarkerOptions(
      //               position: LatLng(
      //                   f.geometry.location.lat, f.geometry.location.lng),
      //               infoWindowText:
      //                   InfoWindowText("${f.name}", "${f.types?.first}"));
      //           mapController.addMarker(markerOptions);
      //         });
      //       } else {
      //         this.errorMessage = result.errorMessage;
      //       }
      //     });
      //   });
      // } else {
      //   this.errorMessage = result.errorMessage;
      // }
    // });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();
    
    return ListView(shrinkWrap: true, children: placesWidget,);
  }
}