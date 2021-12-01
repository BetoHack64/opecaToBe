import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool _isLoading = false;
void main() {
  //fetch();
}

entrar(String Username, String Password) async {
  Uri url = Uri.parse("http://83.240.225.239:130/api/Authenticate");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map body = {"Username": Username, "Password": Password};
  var jsonResponse;
  var res = await http.post(url, body: body);

  if (res.statusCode == 200) {
    print("Estado da resposta: ${res.statusCode}");
    print("Estado da Resposta: ${res.body}");
    if (jsonResponse != null) {
      _isLoading = false;
    }
    sharedPreferences.setString("token", jsonResponse['token']);

  }
}
