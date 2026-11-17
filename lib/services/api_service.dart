import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/produk_model.dart';

class ApiService {
  static const String defaultBaseUrl = 'http://192.168.11.42:8001';
  static const String apiKey = 'toko-rahasia-123';

  static String baseUrl = defaultBaseUrl;

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'X-API-Key': apiKey,
      };

  // ================= USER ENDPOINTS =================

  /// Mengambil semua user (GET /user)
  static Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List list = decoded['data'] ?? [];
      return list.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat user: ${response.statusCode} ${response.body}');
    }
  }

  /// Tambah user (POST /user)
  static Future<bool> addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: _headers,
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Gagal menambahkan user: ${response.statusCode} ${response.body}');
    }
  }

  /// Update user (PUT /user/{id})
  static Future<bool> updateUser(int id, UserModel user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/$id'),
      headers: _headers,
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal mengupdate user: ${response.statusCode} ${response.body}');
    }
  }

  /// Hapus user (DELETE /user/{id})
  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/user/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal menghapus user: ${response.statusCode} ${response.body}');
    }
  }

  // ================= PRODUK ENDPOINTS =================

  /// Mengambil semua produk (GET /produk)
  static Future<List<ProdukModel>> getProduk() async {
    final response = await http.get(
      Uri.parse('$baseUrl/produk'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List list = decoded['data'] ?? [];
      return list.map((item) => ProdukModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat produk: ${response.statusCode} ${response.body}');
    }
  }

  /// Tambah produk (POST /produk)
  static Future<bool> addProduk(ProdukModel produk) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produk'),
      headers: _headers,
      body: jsonEncode(produk.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Gagal menambahkan produk: ${response.statusCode} ${response.body}');
    }
  }

  /// Update produk (PUT /produk/{id})
  static Future<bool> updateProduk(int id, ProdukModel produk) async {
    final response = await http.put(
      Uri.parse('$baseUrl/produk/$id'),
      headers: _headers,
      body: jsonEncode(produk.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal mengupdate produk: ${response.statusCode} ${response.body}');
    }
  }

  /// Hapus produk (DELETE /produk/{id})
  static Future<bool> deleteProduk(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/produk/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal menghapus produk: ${response.statusCode} ${response.body}');
    }
  }
}

