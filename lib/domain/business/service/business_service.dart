import 'package:mp_payment_client/domain/business/interface/i_business.dart';
import 'package:mp_payment_client/domain/business/model/business.dart';

class BusinessService {
  final IBusiness iBusiness;

  BusinessService({
    required this.iBusiness
  });

  Future<List<Business>> getAllBusiness() async {
    return await iBusiness.getAllBusiness();
  }
}