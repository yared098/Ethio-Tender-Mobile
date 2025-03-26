import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 🔹 **Register User**
  Future<bool> register(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return response.user != null;
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }

  /// 🔹 **Login User**
  Future<String?> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return response.session?.accessToken;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  /// 🔹 **Logout User**
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      print("User logged out!");
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  /// 🔹 **Add Product**
  Future<bool> addProduct(Map<String, dynamic> data) async {
    try {
      final response = await _supabase.from('products').insert(data);
      return response.isEmpty;
    } catch (e) {
      print("Add Product Error: $e");
      return false;
    }
  }

  /// 🔹 **Get All Products**
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _supabase.from('products').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Get Products Error: $e");
      return [];
    }
  }

  /// 🔹 **Post a Tender**
  Future<bool> postTender(Map<String, dynamic> tenderData) async {
    try {
      final response = await _supabase.from('tenders').insert(tenderData);
      return response.isEmpty;
    } catch (e) {
      print("Post Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Get All Tenders**
  Future<List<Map<String, dynamic>>> getTenders() async {
    try {
      final response = await _supabase.from('tenders').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Get Tenders Error: $e");
      return [];
    }
  }

  /// 🔹 **Update Tender**
  Future<bool> updateTender(String tenderId, Map<String, dynamic> tenderData) async {
    try {
      final response = await _supabase
          .from('tenders')
          .update(tenderData)
          .eq('id', tenderId); // Assuming 'id' is the primary key field
      return response.isEmpty;
    } catch (e) {
      print("Update Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Delete Tender**
  Future<bool> deleteTender(String tenderId) async {
    try {
      final response = await _supabase.from('tenders').delete().eq('id', tenderId);
      return response.isEmpty;
    } catch (e) {
      print("Delete Tender Error: $e");
      return false;
    }
  }

  /// 🔹 **Create a Bid for a Tender**
  Future<bool> createBid(String tenderId, Map<String, dynamic> bidData) async {
    try {
      final response = await _supabase.from('bids').insert({
        "tender_id": tenderId,
        ...bidData,
      });
      return response.isEmpty;
    } catch (e) {
      print("Create Bid Error: $e");
      return false;
    }
  }

  /// 🔹 **Get All Bids for a Tender**
  Future<List<Map<String, dynamic>>> getBids(String tenderId) async {
    try {
      final response = await _supabase
          .from('bids')
          .select()
          .eq('tender_id', tenderId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Get Bids Error: $e");
      return [];
    }
  }
}
