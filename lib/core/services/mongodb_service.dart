import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class MongoDBService {
  final String uri = "mongodb://your_mongo_url";
  Db? _db;
  DbCollection? _usersCollection;
  DbCollection? _productsCollection;
  DbCollection? _tendersCollection;

  Future<void> init() async {
    _db = await Db.create(uri);
    await _db?.open();
    _usersCollection = _db?.collection('users');
    _productsCollection = _db?.collection('products');
    _tendersCollection = _db?.collection('tenders'); // Initialize tenders collection
  }

  /// 🔹 **Register a new user**
  Future<bool> register(String email, String password) async {
    final existingUser = await _usersCollection?.findOne({"email": email});
    if (existingUser != null) {
      print("User already exists!");
      return false;
    }

    String hashedPassword = _hashPassword(password);
    final user = {"email": email, "password": hashedPassword};
    
    await _usersCollection?.insertOne(user);
    return true;
  }

  /// 🔹 **Login a user**
  Future<bool> login(String email, String password) async {
    final user = await _usersCollection?.findOne({"email": email});
    
    if (user == null) {
      print("User not found!");
      return false;
    }

    String hashedPassword = _hashPassword(password);
    if (user["password"] == hashedPassword) {
      print("Login successful!");
      return true;
    } else {
      print("Incorrect password!");
      return false;
    }
  }

  /// 🔹 **Logout (optional, just clear session)**
  Future<void> logout() async {
    // Handle session management in UI
    print("User logged out!");
  }

  /// 🔹 **Add Product**
  Future<void> addProduct(Map<String, dynamic> data) async {
    await _productsCollection?.insertOne(data);
  }

  /// 🔹 **Get Products**
  Future<List<Map<String, dynamic>>> getProducts() async {
    return await _productsCollection?.find().toList() ?? [];
  }

  /// 🔹 **Add Tender**
  Future<void> addTender(Map<String, dynamic> tenderData) async {
    await _tendersCollection?.insertOne(tenderData);
    print("Tender added successfully!");
  }

  /// 🔹 **Get Tender by ID**
  Future<Map<String, dynamic>?> getTender(String tenderId) async {
    try {
      var tender = await _tendersCollection?.findOne(where.eq('_id', ObjectId.fromHexString(tenderId)));
      return tender;
    } catch (e) {
      print("MongoDB Get Tender Error: $e");
      return null;
    }
  }

  /// 🔹 **Get All Tenders**
  Future<List<Map<String, dynamic>>> getTenders() async {
    try {
      var tenders = await _tendersCollection?.find().toList();
      return tenders ?? [];
    } catch (e) {
      print("MongoDB Get Tenders Error: $e");
      return [];
    }
  }

  /// 🔹 **Update Tender**
  Future<void> updateTender(String tenderId, Map<String, dynamic> tenderData) async {
    try {
      var result = await _tendersCollection?.update(
        where.eq('_id', ObjectId.fromHexString(tenderId)),
        modify.set('tenderData', tenderData), // Update fields
      );

      // Check if update was successful by looking for acknowledgment in result
      if (result != null && result["nModified"] > 0) {
        print("Tender updated successfully!");
      } else {
        print("Tender update failed or no changes were made!");
      }
    } catch (e) {
      print("MongoDB Update Tender Error: $e");
    }
  }

  /// 🔹 **Delete Tender**
  Future<void> deleteTender(String tenderId) async {
    try {
      var result = await _tendersCollection?.remove(
        where.eq('_id', ObjectId.fromHexString(tenderId)),
      );

      // Check if deletion was acknowledged by result
      if (result != null && result["n"] > 0) {
        print("Tender deleted successfully!");
      } else {
        print("Tender deletion failed or no documents found to delete!");
      }
    } catch (e) {
      print("MongoDB Delete Tender Error: $e");
    }
  }

  /// 🔹 **Hashing password using SHA256**
  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
