enum SnackBarStates { idle, success, warning, error }

enum VerifyOtpStep { phone, email }

enum FacilityType { user, vendor, transport }
enum SupplyRequestStatus {
  awaitingQuotation,
  awaitingApproval,
  preparing,
  awaitingTransportation,
  onWay,
  delivered
}
enum TransportationStatus {
  awaitingOfferes,
  pending,
  pickupLocation,
  deliveryLocation,
  delivered
}
