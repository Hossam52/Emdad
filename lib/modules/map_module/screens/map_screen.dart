import 'dart:developer';

import 'package:emdad/modules/map_module/screens/map_cubit/map_cubit.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {Key? key,
      required this.lat,
      required this.lng,
      required this.screenTitle,
      this.infoData,
      this.locationName})
      : super(key: key);
  final double lat;
  final double lng;
  final String screenTitle;
  final String? infoData;
  final String? locationName;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final LatLng _center;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.lat, widget.lng);
  }

  @override
  Widget build(BuildContext context) {
    final user = AppCubit.get(context).getUser;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.screenTitle),
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: AppBarTheme.of(context)
              .titleTextStyle!
              .copyWith(color: Colors.white),
          foregroundColor: Colors.red,
        ),
        body: BlocProvider(
          create: (context) => MapCubit(
              LatLng(user!.locationObject!.lat, user.locationObject!.lng),
              LatLng(widget.lat, widget.lng)),
          child: MapCubitBlocBuilder(
            builder: (context, state) {
              return SafeArea(
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 5.3,
                      ),
                      markers: MapCubit.instance(context).markers,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                    _MyLocationManagement(
                      locationName: widget.locationName ?? '',
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  void _onMapCreated(GoogleMapController? googleMapController) {}
}

class _MyLocationManagement extends StatelessWidget {
  const _MyLocationManagement({Key? key, required this.locationName})
      : super(key: key);
  final String locationName;
  @override
  Widget build(BuildContext context) {
    return MapCubitBlocBuilder(
      builder: (context, state) {
        return SizedBox(
          height: 150.h,
          child: Material(
            elevation: 5,
            shadowColor: AppColors.primaryColor,
            color: AppColors.textWhiteGrey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('اظهار موقعي'),
                      onTap: () {
                        MapCubit.instance(context).toggleViewMyLocation();
                      },
                      trailing: Checkbox(
                          value: MapCubit.instance(context).displayMyLocation,
                          onChanged: (val) {
                            MapCubit.instance(context).toggleViewMyLocation();
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListTile(
                      onTap: () {
                        MapCubit.instance(context).toggleViewOtherLocation();
                      },
                      title: const Text('اظهار الموقع الاخر '),
                      trailing: Checkbox(
                          value:
                              MapCubit.instance(context).displayOtherLocation,
                          onChanged: (val) {
                            MapCubit.instance(context)
                                .toggleViewOtherLocation();
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
