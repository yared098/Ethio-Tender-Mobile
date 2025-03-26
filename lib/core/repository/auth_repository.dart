import '../../utils/db_config.dart';
import '../services/firebase_service.dart';
import '../services/api_service.dart';
import '../services/mongodb_service.dart';

class AuthRepository {
  final DBType dbType;
  AuthRepository(this.dbType);

  final FirebaseService _firebaseService = FirebaseService();
  final ApiService _apiService = ApiService();
  final MongoDBService _mongoDBService = MongoDBService();

 Future<bool> login(String email, String password) async {
  switch (dbType) {
    case DBType.firebase:
      return (await _firebaseService.login(email, password)) != null;
    case DBType.api:
      return (await _apiService.login(email, password)) != null;
    case DBType.mongodb:
      return (await _mongoDBService.login(email, password)) != null;
  }
}


  Future<bool> register(String email, String password) async {
  switch (dbType) {
    case DBType.firebase:
      return (await _firebaseService.register(email, password)) != null;
    case DBType.api:
      return (await _apiService.register(email, password)) != null;
    case DBType.mongodb:
      return (await _mongoDBService.register(email, password)) != null;
  }
}

}
