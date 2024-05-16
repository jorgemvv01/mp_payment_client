import 'package:mp_payment_client/domain/product/interface/i_product.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';

class ProductService {
  final IProduct iProduct;

  ProductService({
    required this.iProduct
  });

  Future<List<Product>> getAllProductsByBusiness(int businessID) async {
    return await iProduct.getAllProductsByBusiness(businessID);
  }

  Future<List<Product>> getPromotionalProductsByBusiness(int businessID) async {
    return await iProduct.getPromotionalProductsByBusiness(businessID);
  }
}