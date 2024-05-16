import 'package:mp_payment_client/utils/api/enviroments.dart';

class Api {

  //Timeout
  static const timeout = 15000;

  //Set enviroment
  static const Enviroments env = Enviroments.prod;

  //Endpoints
  static const String business = '/api/business';
  static const String productByBusiness = '/api/product/by-business';
  static const String promotionalProduct = '/api/product/promotional';
  static const String order = '/api/order';
  static const String orderByUser = '/api/order/user';
  static const String orderDetails = '/api/order/details';
  static const String orderPayment = '/api/mp-payment';

  static String getAPIBase(){
    switch (env) {
      case Enviroments.dev:
        //DEV url
        return '2756-181-78-85-132.ngrok-free.app';
      case Enviroments.qa:
        //QA url
        return '';
      case Enviroments.prod:
        return 'mp.dev-jorgemvv01.online';
      default:
        //DEFAULT url
        return '';
    }
  }
  
}