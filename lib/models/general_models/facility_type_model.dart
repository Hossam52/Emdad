import 'package:emdad/models/enums/enums.dart';

class FacilityTypeModel {
  final String imagePath;
  final String title;
  final FacilityType facilityType;

  FacilityTypeModel({
    required this.imagePath,
    required this.title,
    required this.facilityType,
  });
}

List<FacilityTypeModel> listOfTypesItems = [
  FacilityTypeModel(
    imagePath: 'assets/icons/restaurant.svg',
    title: 'مطعم \\ كافيه',
    facilityType: FacilityType.user,
  ),
  FacilityTypeModel(
    imagePath: 'assets/icons/market.svg',
    title: 'مورد',
    facilityType: FacilityType.vendor,
  ),
  FacilityTypeModel(
    imagePath: 'assets/icons/transport.svg',
    title: 'شركه نقل',
    facilityType: FacilityType.transport,
  ),
];