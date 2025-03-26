enum DatabaseType { firebase, mongodb, api }
enum DBType { firebase, mongodb, api }


class DBConfig {
  static DatabaseType currentDB = DatabaseType.firebase; // Default DB

  static void setDatabase(DatabaseType dbType) {
    currentDB = dbType;
  }
}
