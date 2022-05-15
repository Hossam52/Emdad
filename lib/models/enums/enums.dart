enum SnackBarStates { idle, success, warning, error }
enum SortBy { none, name, date }
enum VerifyOtpStep { phone, email }
enum ImageType { products, users }

enum FacilityType { user, vendor, transport }
enum PaymentStatus { unpaid, paid }
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
