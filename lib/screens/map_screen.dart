import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'package:location/location.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late UserProvider? userProvider;

  //Locations
  Location location = Location();
  late StreamSubscription<LocationData> listen;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    configLocation();
    super.initState();
  }

  configLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.enableBackgroundMode(enable: true);

    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;

    listen = location.onLocationChanged.listen((LocationData currentLocation) {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
      if (userProvider != null) {
        userProvider!.setUserLocation(latitude!, longitude!);
      }
      setState(() {});
    });
    listen.resume();
  }

  @override
  void dispose() {
    listen.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: getAppBar(context, 'Mapa', userProvider!.user),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Center(child: Text(latitude.toString() + '/' + longitude.toString())),
        ],
      ),
    );
  }
}
