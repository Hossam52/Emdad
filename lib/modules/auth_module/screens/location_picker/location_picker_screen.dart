import 'dart:developer';

import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:open_location_picker/open_location_picker.dart';

import 'bloc.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key, required this.authCubit})
      : super(key: key);

  final AuthCubit authCubit;

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final Location location = Location();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: OpenMapPicker(
        //     decoration: const InputDecoration(hintText: "My location"),
        //     expands: false,
        //     onChanged: (newValue) => log(
        //       newValue!.toLatLng().toString(),
        //     ),
        //   ),
        // ),
        body: OpenMapSettings(
      getLocationStream: () => location.onLocationChanged.map((event) {
        return LatLng(event.latitude!, event.longitude!);
      }),
      child: OpenStreetMaps(
        searchHint: context.tr.search_here,
        myLocationButton: (value) => FloatingActionButton(
          onPressed: () async {
            Location location = Location();

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
            _locationData = await location.getLocation();
            value(LatLng(_locationData.latitude!, _locationData.longitude!));
          },
          child: const Icon(Icons.location_on),
        ),
        onDone: (locationd) async {
          log((await location.onLocationChanged.last).toString());
          return;
          widget.authCubit.addLocation(locationd);
          Navigator.pop(context);
        },
        options: OpenMapOptions(),
        bloc: CustomBloc(
          OpenMapState.selected(
            SelectedLocation.single(null),
          ),
        ),
      ),
    ));
  }
}
