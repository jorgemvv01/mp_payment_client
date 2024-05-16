class OrderRequest {
  int businessID;
  int userID;
  List<Item> items;

  OrderRequest({
    required this.businessID,
    required this.userID,
    required this.items
  });
  
  Map<String, dynamic> toJson() => {
    "business_id": businessID,
    "user_id": userID,
    "products": items,
  };
}

class Item {
  int productID;
  int quantity;

  Item({
    required this.productID,
    required this.quantity
  });

  Map<String, dynamic> toJson() => {
    "product_id": productID,
    "quantity": quantity
  };
}