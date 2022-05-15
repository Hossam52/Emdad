//
abstract class TransporterOrderDetailsStates {}

class IntitalTrnasporterOrderDetailsState
    extends TransporterOrderDetailsStates {}

//
class ChangeOrderTransportationPriceState
    extends TransporterOrderDetailsStates {}

//GetTransport online fetch data
class GetTransportLoadingState extends TransporterOrderDetailsStates {}

class GetTransportSuccessState extends TransporterOrderDetailsStates {}

class GetTransportErrorState extends TransporterOrderDetailsStates {
  final String error;
  GetTransportErrorState({required this.error});
}

//CreatePriceOffer online fetch data
class CreatePriceOfferLoadingState extends TransporterOrderDetailsStates {}

class CreatePriceOfferSuccessState extends TransporterOrderDetailsStates {}

class CreatePriceOfferErrorState extends TransporterOrderDetailsStates {
  final String error;
  CreatePriceOfferErrorState({required this.error});
}
