import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:open_location_picker/open_location_picker.dart';

import 'bloc.dart';

class LocationPickerScreen extends StatelessWidget {
  const LocationPickerScreen({Key? key, required this.authCubit})
      : super(key: key);

  final AuthCubit authCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMaps(
        searchHint: 'ابحث هنا',
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
        onDone: (location) {
          authCubit.addLocation(location);
          Navigator.pop(context);
        },
        options: OpenMapOptions(),
        bloc: CustomBloc(OpenMapState.selected(
            SelectedLocation.single(authCubit.selectedLocationTest))),
      ),
    );
  }
}
