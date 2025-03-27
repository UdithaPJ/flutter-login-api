import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users.dart';

class LoginApiService {
  Future<Users?> login(String username, String password) async {
    // URL for API
    const url = 'https://api.example.com/api/External_Api/Mobile_Api/Invoke';
    // API Request
    final body = jsonEncode({
      "API_Body": [
        {
          "Unique_Id": "",
          "Pw": password,
        }
      ],
      "Api_Action": "GetUserData",
      "Company_Code": username
    });

    // Getting response from API
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["Status_Code"] == 200) {
        return Users.fromMap(json["Response_Body"][0]);
      }
    }
    return null;
  }
}
