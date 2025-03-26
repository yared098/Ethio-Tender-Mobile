import '../../utils/db_config.dart';
import '../services/firebase_service.dart';
import '../services/mongodb_service.dart';
import '../services/api_service.dart';

class ProductRepository {
  final DBType dbType;

  ProductRepository(this.dbType);

  final FirebaseService _firebaseService = FirebaseService();
  final MongoDBService _mongoDBService = MongoDBService();
  final ApiService _apiService = ApiService();

  Future<void> addProduct(Map<String, dynamic> data) async {
    switch (dbType) {
      case DBType.firebase:
        await _firebaseService.addProduct(data);
        break;
      case DBType.mongodb:
        await _mongoDBService.addProduct(data);
        break;
      case DBType.api:
        await _apiService.addTender(data);
        break;
    }
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    switch (dbType) {
      case DBType.firebase:
        return _firebaseService.getProducts();
      case DBType.mongodb:
        return _mongoDBService.getProducts();
      case DBType.api:
        return _apiService.getTenders();
    }
  }
}
