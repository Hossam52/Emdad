import 'dart:developer';

import 'package:emdad/models/transportations/transportation_offer_model.dart';
import 'package:emdad/models/transportations/transportation_offers_model.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import './vendor_shipping_offers_states.dart';

//Bloc builder and bloc consumer methods
typedef VendorShippingOffersBlocBuilder
    = BlocBuilder<VendorShippingOffersCubit, VendorShippingOffersStates>;
typedef VendorShippingOffersBlocConsumer
    = BlocConsumer<VendorShippingOffersCubit, VendorShippingOffersStates>;

//
class VendorShippingOffersCubit extends Cubit<VendorShippingOffersStates> {
  VendorShippingOffersCubit(this.transportationRequestId)
      : super(IntitalVendorShippingOffersState());
  static VendorShippingOffersCubit instance(BuildContext context) =>
      BlocProvider.of<VendorShippingOffersCubit>(context);
  final String transportationRequestId;

  final _vendorServices = VendorServices.instance;

  TransportationOffersModel? _offersModel;
  List<TransportationOfferModel> get offers =>
      _offersModel?.transportationOffers ?? [];

  bool get errorInOffers => _offersModel == null;

  Future<void> getVendorTransportationOffers() async {
    try {
      emit(GetVendorTransportationOffersLoadingState());
      final map = await _vendorServices.transportationServices
          .getTransportationOffers(transportationRequestId);
      _offersModel = TransportationOffersModel.fromMap(map);
      emit(GetVendorTransportationOffersSuccessState());
    } catch (e) {
      emit(GetVendorTransportationOffersErrorState(error: e.toString()));
    }
  }

  Future<void> acceptTransportationOffer(
      BuildContext context, String offerId) async {
    log('Test$offerId Test');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      emit(AcceptTransportationOfferLoadingState());
      final map =
          await _vendorServices.transportationServices.acceptOffer(offerId);
      emit(AcceptTransportationOfferSuccessState());
    } catch (e) {
      emit(AcceptTransportationOfferErrorState(error: e.toString()));
    } finally {
      Navigator.pop(context);
    }
  }
}
