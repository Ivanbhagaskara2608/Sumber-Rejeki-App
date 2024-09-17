import 'package:http/http.dart' as http;

const String baseUrl = 'https://carefully-awake-mullet.ngrok-free.app/api';

class BaseClient {
  var client = http.Client();

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse('$baseUrl/$api');
    var response = await client.post(url,
        headers: {"Content-Type": "application/json"}, body: object);

    return response;
  }

  Future<dynamic> postWithToken(
      String api, dynamic object, String token) async {
    var url = Uri.parse('$baseUrl/$api');
    var response = await client.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': "Bearer $token"
        },
        body: object);

    return response;
  }

  Future<dynamic> get(String api) async {
    var url = Uri.parse('$baseUrl/$api');
    var response = await client.get(url);

    return response;
  }

  Future<dynamic> getWithToken(String api, String token) async {
    var url = Uri.parse('$baseUrl/$api');
    var headers = {'Authorization': "Bearer $token"};
    var response = await client.get(url, headers: headers);

    return response;
  }
}