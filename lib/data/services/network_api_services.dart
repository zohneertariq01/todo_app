import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:todo_app/data/app_exception.dart';
import 'package:http/http.dart';
import 'package:todo_app/data/services/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic jsonResponse;
    try {
      Response response =
          await post(Uri.parse(url), body: data).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseReturn = jsonDecode(response.body.toString());
        return responseReturn;
      case 400:
        throw UnauthorizedException(response.body.toString());
      case 500:
      case 404:
        throw InternetAddress(response.body.toString());
      default:
        throw FetchDataException('Error occur while communicating with server' +
            'with source code' +
            response.statusCode.toString());
    }
  }
}
