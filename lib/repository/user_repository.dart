import 'package:todo_app/data/services/base_api_services.dart';
import 'package:todo_app/data/services/network_api_services.dart';
import 'package:todo_app/utils/utils.dart';

class UserRepository {
  Future<dynamic> getSignUpApi(dynamic data) async {
    try {
      BaseApiServices baseApiServices = NetworkApiServices();
      final response =
          await baseApiServices.getPostApiResponse(Utils.signupEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getLoginApi(dynamic data) async {
    try {
      BaseApiServices baseApiServices = NetworkApiServices();
      final response =
          await baseApiServices.getPostApiResponse(Utils.loginEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
