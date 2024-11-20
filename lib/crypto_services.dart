import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String baseUrl = "https://api.coingecko.com/api/v3";

  Future<List<dynamic>> getCryptoPrices() async {
    final response = await http.get(Uri.parse('$baseUrl/coins/markets?vs_currency=usd'));

    if (response.statusCode == 200) {
      return json.decode(response.body);  // Retourne une liste de cryptomonnaies
    } else {
      throw Exception("Échec du chargement des données des cryptomonnaies");
    }
  }
}
