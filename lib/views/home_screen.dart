import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/viewmodel/product_viewmodel.dart';
import '../utils/db_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseType selectedDB = DBConfig.currentDB;

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          DropdownButton<DatabaseType>(
            value: selectedDB,
            onChanged: (DatabaseType? newDB) {
              if (newDB != null) {
                setState(() {
                  selectedDB = newDB;
                  DBConfig.setDatabase(newDB);
                });
                productVM.fetchProducts();
              }
            },
            items: DatabaseType.values.map((DatabaseType dbType) {
              return DropdownMenuItem<DatabaseType>(
                value: dbType,
                child: Text(dbType.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: productVM.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: productVM.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(productVM.products[index]['name']),
                subtitle: Text(productVM.products[index]['price'].toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await productVM.addProduct({
            "name": "New Product",
            "price": 99.99,
            "description": "A sample product",
            "category": "Electronics",
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
