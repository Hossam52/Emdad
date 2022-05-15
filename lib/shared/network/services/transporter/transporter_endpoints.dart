import 'package:emdad/shared/network/services/generate_path_variable.dart';

class TransporterEndPoints {
//Original path
  static const _path = 'transporter/';

  static const transportationRequests = _path + 'transportationRequests';
  static const transportationOrders = _path + 'transportationOrders';

  static const transportationoffers = _path + 'transportationOffers';

  static String transportDetails(String transportId) {
    return generatePathVariable(transportationRequests, transportId);
  }
}
