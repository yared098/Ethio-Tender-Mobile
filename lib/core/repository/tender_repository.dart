import '../../utils/db_config.dart';  // Assuming DBType is defined here
import '../services/firebase_service.dart';
import '../services/api_service.dart';
import '../services/mongodb_service.dart';
import '../models/tender_model.dart';

class TenderRepository {
  final DBType dbType;
  TenderRepository(this.dbType);

  final FirebaseService _firebaseService = FirebaseService();
  final ApiService _apiService = ApiService();
  final MongoDBService _mongoDBService = MongoDBService();

  // Get all tenders
  Future<List<Tender>> getTenders() async {
    switch (dbType) {
      case DBType.firebase:
        var tenders = await _firebaseService.getTenders();
        return tenders.map((tenderData) => Tender.fromMap(tenderData)).toList();
      case DBType.api:
        var tenders = await _apiService.getTenders();
        return tenders.map((tenderData) => Tender.fromMap(tenderData)).toList();
      case DBType.mongodb:
        var tenders = await _mongoDBService.getTenders();
        return tenders.map((tenderData) => Tender.fromMap(tenderData)).toList();
      default:
        throw Exception("Unknown DB type");
    }
  }

  // Add a new tender
  Future<void> addTender(Tender tender) async {
    switch (dbType) {
      case DBType.firebase:
        await _firebaseService.addTender(tender.toMap());
        break;
      case DBType.api:
        await _apiService.addTender(tender.toMap());
        break;
      case DBType.mongodb:
        await _mongoDBService.addTender(tender.toMap());
        break;
      default:
        throw Exception("Unknown DB type");
    }
  }

  // Update an existing tender
  Future<void> updateTender(String tenderId, Tender tender) async {
    switch (dbType) {
      case DBType.firebase:
        await _firebaseService.updateTender(tenderId, tender.toMap());
        break;
      case DBType.api:
        await _apiService.updateTender(tenderId, tender.toMap());
        break;
      case DBType.mongodb:
        await _mongoDBService.updateTender(tenderId, tender.toMap());
        break;
      default:
        throw Exception("Unknown DB type");
    }
  }

  // Delete a tender by ID
  Future<void> deleteTender(String tenderId) async {
    switch (dbType) {
      case DBType.firebase:
        await _firebaseService.deleteTender(tenderId);
        break;
      case DBType.api:
        await _apiService.deleteTender(tenderId);
        break;
      case DBType.mongodb:
        await _mongoDBService.deleteTender(tenderId);
        break;
      default:
        throw Exception("Unknown DB type");
    }
  }
}

// Assuming DBType enum is defined as:
enum DBType { firebase, api, mongodb }
