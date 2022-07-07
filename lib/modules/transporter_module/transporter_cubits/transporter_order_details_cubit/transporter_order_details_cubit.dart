import 'package:emdad/models/request_models/transporter/create_price_request_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transportation_rsupply_request_model.dart';
import 'package:emdad/models/transportations/transportation_supply_requests/transporter_supply_request.dart';
import 'package:emdad/shared/network/services/transporter/transporter_services.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './transporter_order_details_states.dart';

//Bloc builder and bloc consumer methods
typedef TrnasporterOrderDetailsBlocBuilder
    = BlocBuilder<TrnasporterOrderDetailsCubit, TransporterOrderDetailsStates>;
typedef TrnasporterOrderDetailsBlocConsumer
    = BlocConsumer<TrnasporterOrderDetailsCubit, TransporterOrderDetailsStates>;

//
class TrnasporterOrderDetailsCubit
    extends Cubit<TransporterOrderDetailsStates> {
  TrnasporterOrderDetailsCubit({required this.transportId})
      : super(IntitalTrnasporterOrderDetailsState());
  static TrnasporterOrderDetailsCubit instance(BuildContext context) =>
      BlocProvider.of<TrnasporterOrderDetailsCubit>(context);
  final String transportId;
  final TextEditingController myNotesController = TextEditingController();
  final _services = TransporterServices.instance;

  TransporterOrderDetailsModel? _order;
  bool get errorInOrder => _order == null;
  TransporterSupplyRequest get order => _order!.transportationRequest;

  double? _transportationPrice;
  bool get hasProvidePrice => _transportationPrice != null;

  double? get transportationPrice => _transportationPrice;
  set setTransportationPrice(double price) {
    _transportationPrice = price;
    emit(ChangeOrderTransportationPriceState());
  }

  String? _transportationMethod;
  set setTransportationMethod(String method) {
    _transportationMethod = method;
  }

  Future<void> getTransport() async {
    try {
      emit(GetTransportLoadingState());
      final map = await _services.orderServices.getOrderDetails(transportId);
      _order = TransporterOrderDetailsModel.fromMap(map);
      emit(GetTransportSuccessState());
    } catch (e) {
      emit(GetTransportErrorState(error: e.toString()));
    }
  }

  Future<void> createPriceOffer(BuildContext context) async {
    try {
      emit(CreatePriceOfferLoadingState());
      if (_transportationMethod == null)
        throw context.tr.transportation_method_required;
      await _services.orderServices.createTransportPrice(
          CreatePriceRequestModel(
              transportationRequestId: transportId,
              price: _transportationPrice!,
              notes: myNotesController.text));

      emit(CreatePriceOfferSuccessState());
    } catch (e) {
      emit(CreatePriceOfferErrorState(error: e.toString()));
    }
  }
}
