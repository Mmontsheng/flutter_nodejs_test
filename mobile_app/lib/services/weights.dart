import 'package:http/http.dart' as http;
import 'package:mobile_app/config/constants.dart';
import 'package:mobile_app/services/authentication.dart';

class WeightService {
  final AuthenticationService authenticationService;

  WeightService({required this.authenticationService});

  Future<http.Response> get() async {
    final baseUrl = '${Constants.base_url}/get_weight_history';
    String token = authenticationService.getBearer();

    http.Response response = await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
