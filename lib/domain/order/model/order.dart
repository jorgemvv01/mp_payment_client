class Order {
  int id;
  int businessID;
  int userID;
  String mpClientID;
  String mpPreferenceID;
  String mpInitPoint;
  String mpPreferenceCreatedAt;
  double discount;
  double tax;
  double subtotal;
  double total;

  Order({
    required this.id,
    required this.businessID,
    required this.userID,
    required this.mpClientID,
    required this.mpPreferenceID,
    required this.mpInitPoint,
    required this.mpPreferenceCreatedAt,
    required this.discount,
    required this.tax,
    required this.subtotal,
    required this.total
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id : json["ID"],
    businessID : json["BusinessID"],
    userID : json["UserID"],
    mpClientID : json["MpClientID"],
    mpPreferenceID : json["MpPreferenceID"],
    mpInitPoint : json["MpInitPoint"],
    mpPreferenceCreatedAt : json["MpPreferenceCreatedAt"],
    discount : json["Discount"].toDouble(),
    tax : json["Tax"].toDouble(),
    subtotal : json["Subtotal"].toDouble(),
    total : json["Total"].toDouble()
  );
}