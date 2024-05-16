class Product {
  int id;
  int businessID;
  String name;
  String description;
  String code;
  double price;
  double discount;
  double tax;
  String image;

  Product({
    required this.id,
    required this.businessID,
    required this.name,
    required this.description,
    required this.code,
    required this.price,
    required this.discount,
    required this.tax,
    required this.image
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id : json["ID"],
    businessID : json["BusinessID"],
    name : json["Name"],
    description : json["Description"],
    code : json["Code"],
    price : json["Price"].toDouble(),
    discount : json["Discount"].toDouble(),
    tax : json["Tax"].toDouble(),
    image : json["Image"]
  );
}