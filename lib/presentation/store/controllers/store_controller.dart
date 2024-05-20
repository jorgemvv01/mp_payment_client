import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mp_payment_client/domain/business/model/business.dart';
import 'package:mp_payment_client/domain/order/model/order.dart';
import 'package:mp_payment_client/domain/order/model/order_request.dart';
import 'package:mp_payment_client/domain/order/service/order_service.dart';
import 'package:mp_payment_client/domain/product/model/product.dart';
import 'package:mp_payment_client/domain/product/service/product_service.dart';
import 'package:mp_payment_client/infrastructure/order/order_repository.dart';
import 'package:mp_payment_client/infrastructure/product/product_repository.dart';
import 'package:mp_payment_client/presentation/main/controllers/main_controller.dart';
import 'package:mp_payment_client/presentation/mercadopago/screens/mercadopago_screen.dart';
import 'package:mp_payment_client/utils/widgets/alerts/custom_alerts.dart';

class StoreController extends GetxController{

  final Business businessInfo;

  RxList<Product> products = <Product>[].obs;
  RxMap<Product, int> productsCart = <Product, int>{}.obs;
  TextEditingController generalQuantity = TextEditingController();

  RxDouble subtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble total = 0.0.obs;

  final RxBool isLoading = false.obs;
  TextEditingController searchText = TextEditingController();

  final ProductService productService = ProductService(iProduct: ProductRepository());
  final OrderService orderService = OrderService(iOrder: OrderRepository());
  final MainController mainController = Get.find();

  StoreController({
    required this.businessInfo
  });

  @override
  void onReady() async{
    await getProducts();
    super.onReady();
  }

  String getProductQuantity(int productID){
    if(productsCart.keys.any((element) => element.id == productID)){
      Product p = productsCart.keys.firstWhere((element) => element.id == productID);
      return productsCart[p]! > 99
       ? '+99'
       :  productsCart[p].toString();
    }
    return '0';
  }

  void addAmount(Product product){
    if(productsCart.keys.any((element) => element.id == product.id)){
      Product p = productsCart.keys.firstWhere((element) => element.id == product.id);
      productsCart[p] = productsCart[p]!+1;
      calculateTotal();
      return;
    }
    productsCart.putIfAbsent(product, () => 1);
    calculateTotal();
  }

  void decreaseAmount(Product product){
    if(productsCart.containsKey(product)){
      int quantity = productsCart[product]!;
      if(quantity == 1){
        productsCart.remove(productsCart.keys.firstWhere((element) => element.id == product.id));
        calculateTotal();
        return;
      }
      Product p = productsCart.keys.firstWhere((element) => element.id == product.id);
      productsCart[p] =  productsCart[p]!-1;
      calculateTotal();
    }
  }

  void addQuantity(Product product, String quantity){
    if(quantity == '' || quantity == '0'){
      if(productsCart.keys.any((element) => element.id == product.id)){
        Product p = productsCart.keys.firstWhere((element) => element.id == product.id);
        productsCart.remove(p);
        calculateTotal();
        return;
      }
    };
    int quantityValue = int.parse(quantity);

    if(productsCart.keys.any((element) => element.id == product.id)){
      Product p = productsCart.keys.firstWhere((element) => element.id == product.id);
      productsCart[p] = quantityValue;
      calculateTotal();
      return;
    }
    productsCart.putIfAbsent(product, () => quantityValue);
    calculateTotal();
  }

  void calculateTotal(){
    if(productsCart.isEmpty){
      total.value = 0;
      subtotal.value = 0;
      discount.value = 0;
      tax.value = 0;
      return;
    }
    subtotal.value = 0;
    tax.value = 0;
    discount.value = 0;
    productsCart.forEach((key, value)  {
      double productPrice = key.price;
      double productDiscount = key.discount;
      double productTax = key.tax;
      double productDiscountValue = 0;
      subtotal.value += (productPrice * value);
      
      if(productDiscount > 0) {
        productDiscountValue = ((productDiscount/100) * (productPrice));
        discount.value += ( productDiscountValue * value);
      }
      if(productTax > 0) {
        subtotal.value += (((productTax/100) * (productPrice -productDiscountValue)) * value);
        tax.value += ((productTax / 100) * (productPrice - productDiscountValue)) * (value);
      }
    });
    total.value = subtotal.value - discount.value;
  }

  int getAddedProducts(){
    int quantity = 0;
    for(int q in productsCart.values){
      quantity += q;
    }
    return quantity;
  }
  
  Future<void> getProducts() async{
    isLoading.value = true;
    CustomAlerts.loading();
    products.value = await productService.getAllProductsByBusiness(businessInfo.id);
    isLoading.value = false;
    Get.close(1);
  }

  Future<void> createOrder() async{
    CustomAlerts.loading();
    OrderRequest orderRequest = createOrderRequest();
    Order? order = await orderService.createOrder(
      orderRequest
    );
    Get.close(1);

    if(order != null && order.mpInitPoint != ""){
      mainController.mpInitPoint = order.mpInitPoint;
      CustomAlerts.generalDialog(
        'Éxito',
        'Orden creada con correctamente',
        acceptText: 'Pagar',
        onAcceptPressed:
        () async{
          if(await InternetConnectionChecker().hasConnection){
            Get.close(1);
            Get.to(() => MercadopagoScreen());
            return;
          }
          CustomAlerts.generalDialog(
            'Error',
            'No hay conexión a internet',
            onAcceptPressed: () => Get.close(1),
          );
        }
      );
      return;
    }
    CustomAlerts.generalDialog(
      'Error',
      'No se pudo crear la orden, intente más tarde',
      onAcceptPressed: () => Get.close(1)
    );
  }

  OrderRequest createOrderRequest() {
    List<Item> items = [];
    productsCart.forEach((key, value) {
      items.add(Item(productID: key.id, quantity: value));
    });
    return OrderRequest(
      businessID: businessInfo.id,
      userID: 1,
      items: items
    );
  }
}