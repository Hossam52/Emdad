enum SnackBarStates { idle, success, warning, error }
enum SortBy { none, name, date }
enum VerifyOtpStep { phone, email }

enum FacilityType { user, vendor, transport }
enum SupplyRequestStatus {
  //Handles inside  my orders
  awaitingQuotation,
  awaitingApproval,
  preparing,
  awaitingTransportation,
  onWay,
  delivered
}
enum TransportationStatus {
  //Handles inside the request page
  awaitingOffers,
  pending,
  pickupLocation,
  deliveryLocation,
  delivered
}
