import 'package:mp_payment_client/domain/business/model/business.dart';

abstract class IBusiness {
  Future<List<Business>> getAllBusiness();
}