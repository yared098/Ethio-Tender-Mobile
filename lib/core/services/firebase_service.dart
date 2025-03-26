import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Firebase Login Error: $e");
      return null;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Firebase Register Error: $e");
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    await _firestore.collection('products').add(data);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    var snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getTenders() async {
    try {
      var snapshot = await _firestore.collection('tenders').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Firebase Get Tenders Error: $e");
      return [];
    }
  }

  // Add Tender method
  Future<void> addTender(Map<String, dynamic> tenderData) async {
    try {
      await _firestore.collection('tenders').add(tenderData);
    } catch (e) {
      print("Firebase Add Tender Error: $e");
    }
  }

  // Update Tender method
  Future<void> updateTender(String tenderId, Map<String, dynamic> tenderData) async {
    try {
      await _firestore.collection('tenders').doc(tenderId).update(tenderData);
    } catch (e) {
      print("Firebase Update Tender Error: $e");
    }
  }

  // Delete Tender method
  Future<void> deleteTender(String tenderId) async {
    try {
      await _firestore.collection('tenders').doc(tenderId).delete();
    } catch (e) {
      print("Firebase Delete Tender Error: $e");
    }
  }
}
