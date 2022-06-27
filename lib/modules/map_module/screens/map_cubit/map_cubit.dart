import 'package:emdad/modules/map_module/screens/map_cubit/map_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Bloc builder and bloc consumer methods
typedef MapCubitBlocBuilder = BlocBuilder<MapCubit, MapStates>;
typedef MapCubitBlocConsumer = BlocConsumer<MapCubit, MapStates>;

//
class MapCubit extends Cubit<MapStates> {
  MapCubit(this.myLocation, this.otherLocation) : super(IntitalMapCubitState());
  static MapCubit instance(BuildContext context) =>
      BlocProvider.of<MapCubit>(context);

  final LatLng myLocation;
  final LatLng otherLocation;

  bool _displayMyLocation = false;
  bool _displayOtherLocation = true;

  bool get displayMyLocation => _displayMyLocation;
  bool get displayOtherLocation => _displayOtherLocation;

  void toggleViewMyLocation() {
    _displayMyLocation = !_displayMyLocation;
    emit(ToggleLocationView());
  }

  void toggleViewOtherLocation() {
    _displayOtherLocation = !_displayOtherLocation;
    emit(ToggleLocationView());
  }

  Set<Marker> get markers {
    final Set<Marker> m = {};
    if (displayMyLocation) {
      m.add(
        Marker(
            markerId: const MarkerId('location1'),
            position: myLocation,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(title: 'My location')),
      );
    }
    if (displayOtherLocation) {
      m.add(
        Marker(
          markerId: const MarkerId('location2'),
          position: otherLocation,
        ),
      );
    }
    return m;
  }
}
