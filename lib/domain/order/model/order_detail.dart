import 'package:mp_payment_client/domain/product/model/product.dart';

class OrderDetail {
  int id;
  int orderID;
  Product product;
  int quantity;
  double price;
  double discount;
  double unitDiscountValue;
  double tax;
  double unitTaxValue;

  OrderDetail({
    required this.id,
    required this.orderID,
    required this.product,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.unitDiscountValue,
    required this.tax,
    required this.unitTaxValue
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id : json["ID"],
    orderID : json["OrderID"],
    product : Product.fromJson(json["Product"]),
    quantity : json["Quantity"],
    price : json["Price"].toDouble(),
    discount : json["Discount"].toDouble(),
    unitDiscountValue : json["UnitDiscountValue"].toDouble(),
    tax : json["Tax"].toDouble(),
    unitTaxValue : json["UnitTaxValue"].toDouble(),
  );
}