import 'package:emdad/shared/network/services/transporter/services/transporter_order_services.dart';
import 'package:emdad/shared/network/services/transporter/services/transporter_orders_services.dart';

class TransporterServices {
  TransporterServices._();

  static TransporterServices get instance => TransporterServices._();
  TransporterOrdersServices get ordersServices =>
      TransporterOrdersServices.instance;
  TransporterOrderServices get orderServices =>
      TransporterOrderServices.instance;
}
