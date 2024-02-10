import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../../data/model/body/RegisterBody.dart';
import '../../../../../../../injection.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({super.key,  this.lat,this.address,  this.long});
  final String? lat;
  final String? long;
  final String? address;

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  RegisterBody registerBody = getIt();

  late GoogleMapController mapController;
  LatLng currentLocation = const LatLng(0, 0);
  bool isLoading = false;

  String lat = '';
  String long = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    requestLocationPermission();
  }

  void _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng newLocation = LatLng(position.latitude, position.longitude);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String newLocationName = widget.address==null?placemarks.isNotEmpty
          ? '${placemarks[0].street ?? ''}' ?? ''
          : '':widget.address??'';
      print(placemarks);
      setState(() {
        currentLocation = newLocation;
        lat =widget.lat?? newLocation.latitude.toString();
        long =widget.long?? newLocation.longitude.toString();
        registerBody.latitude = lat;
        registerBody.longitude = long;
        registerBody.address = newLocationName;
        isLoading = false;
      });
      mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _updateAddress(LatLng newLocation) async {
    print(newLocation.longitude); //this new long
    print(newLocation.latitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        newLocation.latitude, newLocation.longitude);
    String newLocationName = placemarks.isNotEmpty
        ? '${placemarks[0].street ?? ''}' ?? ''
        : '';

    setState(() {
      currentLocation = newLocation;
      lat = newLocation.latitude.toString();
      long = newLocation.longitude.toString();
      registerBody.latitude = lat;
      registerBody.longitude = long;
      registerBody.address = newLocationName;
    });
  }

  void _moveMarker(LatLng newLocation) {
    mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
    _updateAddress(newLocation);
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.address}");
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.latitude}");
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.address}");
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.latitude}");
    print("kdfnvkdfnbjkdfnbjkdfb${registerBody.longitude}");

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _moveMarker,
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 15,
              ),
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId('current_location'),
                  position: currentLocation,
                  draggable: true,
                  onDragEnd: (newPosition) => _updateAddress(newPosition),
                ),
              ]),
            ),
    );
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Location permission permanently denied');
      await openAppSettings();
    } else if (status.isRestricted) {
      // Permission is restricted (iOS only)
      print('Location permission restricted');
    }
    _getCurrentLocation();
  }
}
