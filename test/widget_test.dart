import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response = await http.get(
    url,
    headers: {
      "key": "ac445fa14f4e72086af4ae19f59097df",
    },
  );

  print(response.body);
}
