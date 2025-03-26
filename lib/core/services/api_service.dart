import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://your-api.com"));

  /// 🔹 **Register User**
  Future<bool> register(String email, String password) async {
    try {
      var response = await _dio.post('/auth/register', data: {
        "email": email,
        "password": password,
      });
      return response.statusCode == 201;
    } catch (e) {
      print("Registration Error: $e");
      return false;
    }
  }

  /// 🔹 **Login User**
  Future<String?> login(String email, String password) async {
    try {
      var response = await _dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        String token = response.data["token"];
        _dio.options.headers["Authorization"] = "Bearer $token"; // Save token for future requests
        return token;
      }
      return null;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  /// 🔹 **Logout User**
  Future<void> logout() async {
    _dio.options.headers.remove("Authorization");
    print("User logged out!");
  }

  /// 🔹 **Add Tender**
  Future<bool> addTender(Map<String, dynamic> tenderData) async {
    try {
      var response = await _dio.post('/tenders', data: tenderData);
      return response.statusCode == 201;
    } catch (e) {
      print("Add Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Get All Tenders**
  Future<List<Map<String, dynamic>>> getTenders() async {
    try {
      var response = await _dio.get('/tenders');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      print("Get Tenders Error: $e");
      return [];
    }
  }

  /// 🔹 **Get Tender by ID**
  Future<Map<String, dynamic>?> getTender(String tenderId) async {
    try {
      var response = await _dio.get('/tenders/$tenderId');
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      print("Get Tender Error: $e");
      return null;
    }
  }

  /// 🔹 **Update Tender**
  Future<bool> updateTender(String tenderId, Map<String, dynamic> tenderData) async {
    try {
      var response = await _dio.put('/tenders/$tenderId', data: tenderData);
      return response.statusCode == 200;
    } catch (e) {
      print("Update Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Delete Tender**
  Future<bool> deleteTender(String tenderId) async {
    try {
      var response = await _dio.delete('/tenders/$tenderId');
      return response.statusCode == 200;
    } catch (e) {
      print("Delete Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Create a Bid for a Tender**
  Future<bool> createBid(String tenderId, Map<String, dynamic> bidData) async {
    try {
      var response = await _dio.post('/tenders/$tenderId/bids', data: bidData);
      return response.statusCode == 201;
    } catch (e) {
      print("Create Bid Error: $e");
      return false;
    }
  }
}
