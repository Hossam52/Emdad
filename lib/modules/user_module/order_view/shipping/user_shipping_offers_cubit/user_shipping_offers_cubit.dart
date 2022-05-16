import 'dart:developer';

import 'package:emdad/models/transportations/transportation_offer_model.dart';
import 'package:emdad/models/transportations/transportation_offers_model.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import './user_shipping_offers_states.dart';

//Bloc builder and bloc consumer methods
typedef UserShippingOffersBlocBuilder
    = BlocBuilder<UserShippingOffersCubit, UserShippingOffersStates>;
typedef UserShippingOffersBlocConsumer
    = BlocConsumer<UserShippingOffersCubit, UserShippingOffersStates>;

//
class UserShippingOffersCubit extends Cubit<UserShippingOffersStates> {
  UserShippingOffersCubit(this.transportationRequestId)
      : super(IntitalUserShippingOffersState());
  static UserShippingOffersCubit instance(BuildContext context) =>
      BlocProvider.of<UserShippingOffersCubit>(context);
  final String transportationRequestId;

  final _userServices = UserServices.instance;

  TransportationOffersModel? _offersModel;
  List<TransportationOfferModel> get offers =>
      _offersModel?.transportationOffers ?? [];

  bool get errorInOffers => _offersModel == null;

  Future<void> getVendorTransportationOffers() async {
    try {
      emit(GetUserTransportationOffersLoadingState());
      final map = await _userServices.userTransportServices
          .getTransportationOffers(transportationRequestId);
      _offersModel = TransportationOffersModel.fromMap(map);
      emit(GetUserTransportationOffersSuccessState());
    } catch (e) {
      emit(GetUserTransportationOffersErrorState(error: e.toString()));
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
      emit(AcceptUserTransportationOfferLoadingState());
      final map =
          await _userServices.userTransportServices.acceptOffer(offerId);
      emit(AcceptUserTransportationOfferSuccessState());
    } catch (e) {
      emit(AcceptUserTransportationOfferErrorState(error: e.toString()));
    } finally {
      Navigator.pop(context);
    }
  }
}
