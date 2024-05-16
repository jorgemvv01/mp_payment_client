import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mp_payment_client/domain/business/model/business.dart';
import 'package:mp_payment_client/domain/business/service/business_service.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/domain/product/service/product_service.dart';
import 'package:mp_payment_client/infrastructure/business/business_repository.dart';
import 'package:mp_payment_client/infrastructure/product/product_repository.dart';

class MainController extends GetxController{

  RxList<Business> business = <Business>[].obs;
  RxInt selectedBusinessIndex = 0.obs;
  RxList<Product> promotionalProduct = <Product>[].obs;
  RxList<dynamic> favoriteProducts = <dynamic>[].obs;
  RxBool isProductsLoading = false.obs;

  String mpInitPoint = 'https://google.com';

  final BusinessService businessService = BusinessService(iBusiness: BusinessRepository());
  final ProductService productService = ProductService(iProduct: ProductRepository());
  final storage = GetStorage('mp_payment');

  @override
  void onInit() async{
    isProductsLoading.value = true;
    await getAllBusiness();
    getFavoriteProducts();
    super.onInit();
  }
  
  Future<void> getAllBusiness() async{
    business.value = await businessService.getAllBusiness();
    if(business.isNotEmpty) {
      getPromotionalProductsByBusiness();
      return;
    }
    isProductsLoading.value = false;
  }

  Future<void> getPromotionalProductsByBusiness() async {
    isProductsLoading.value = true;
    if (business.isEmpty) {
      getAllBusiness();
      return;
    }
    int businessID = business[selectedBusinessIndex.value].id;
    promotionalProduct.value = await productService.getPromotionalProductsByBusiness(businessID);
    isProductsLoading.value = false;
  }

  void getFavoriteProducts() {
    if(!storage.hasData('favorite_products')) return;
    favoriteProducts.value = storage.read("favorite_products");
  }

  Future<void> saveFavoriteProduct(int id) async{
    favoriteProducts.contains(id)
    ? favoriteProducts.remove(id)
    : favoriteProducts.add(id);

    await storage.write('favorite_products', favoriteProducts);
  }

  Future<void> testRefrest() async {
    print('--->>>>>> Hola mundo');
  }
}