import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
      });
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else {
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
