import 'dart:convert';

class OrderPayment {
  int id;
  int orderId;
  int paymentId;
  String status;
  String statusDetail;
  String currency;
  double transactionAmount;
  double taxesAmount;
  String payer;
  String paymentMethod;
  String ipAddress;
  DateTime dateApproved;
  DateTime dateCreated;
  DateTime dateLastUpdated;

  OrderPayment({
    required this.id,
    required this.orderId,
    required this.paymentId,
    required this.status,
    required this.statusDetail,
    required this.currency,
    required this.transactionAmount,
    required this.taxesAmount,
    required this.payer,
    required this.paymentMethod,
    required this.ipAddress,
    required this.dateApproved,
    required this.dateCreated,
    required this.dateLastUpdated,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
    id: json["ID"],
    orderId: json["OrderID"],
    paymentId: json["PaymentID"],
    status: json["Status"],
    statusDetail: json["StatusDetail"],
    currency: json["Currency"],
    transactionAmount: json["TransactionAmount"].toDouble(),
    taxesAmount: json["TaxesAmount"].toDouble(),
    payer: jsonEncode(json["Payer"]),
    paymentMethod: jsonEncode(json["PaymentMethod"]),
    ipAddress: json["IPAddress"],
    dateApproved: DateTime.parse(json["DateApproved"]),
    dateCreated: DateTime.parse(json["DateCreated"]),
    dateLastUpdated: DateTime.parse(json["DateLastUpdated"]),
  );
}