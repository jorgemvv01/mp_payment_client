import 'package:mp_payment_client/domain/product/model/product.dart';

abstract class IProduct {
  Future<List<Product>> getAllProductsByBusiness(int businessID);
  Future<List<Product>> getPromotionalProductsByBusiness(int businessID);
}