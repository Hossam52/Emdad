class ProductDetailsModel {
  final int productId;
  final String unit;
  final String minimum;
  final String itemPrice;
  final String tax;

  ProductDetailsModel({
    required this.productId,
    required this.unit,
    required this.minimum,
    required this.itemPrice,
    required this.tax,
  });
}