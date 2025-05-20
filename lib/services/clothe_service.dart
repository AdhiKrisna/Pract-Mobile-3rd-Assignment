import 'dart:convert'; // <- Untuk melakukan encode dan decode JSON
import 'package:asisten_tpm_8/models/clothe_model.dart';

// Supaya dapat mengirimkan HTTP request
import 'package:http/http.dart' as http;

class ClotheApi {
  static const url =
      "https://tpm-api-tugas-872136705893.us-central1.run.app/api/clothes";

  static Future<Map<String, dynamic>> getClothes() async {
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createClothe(Clothe clothe) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(clothe),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getClotheById(int id) async {
    final response = await http.get(Uri.parse("$url/$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load clothe: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateClothe(Clothe clothe, id) async {
    final response = await http.put(
      Uri.parse("$url/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': clothe.name,
        'category': clothe.category,
        'brand': clothe.brand,
        'material': clothe.material,
        'price': clothe.price,
        'sold': clothe.sold,
        'stock': clothe.stock,
        'yearReleased': clothe.yearReleased,
        'rating': clothe.rating,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> deleteClothe(int id) async {
    final response = await http.delete(Uri.parse("$url/$id"));
    return jsonDecode(response.body);
  }
}
