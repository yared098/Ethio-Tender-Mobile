import 'package:ettmobile/core/repository/tender_repository.dart' as tenderRepo; // Alias for TenderRepository
import 'package:ettmobile/core/viewmodel/tender_viewmodel.dart';
import 'package:ettmobile/utils/db_config.dart' as dbConfig;  // Alias for DBConfig
import 'package:ettmobile/views/tender_screen.dart';
import 'package:ettmobile/widgets/AddTenderForm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'core/repository/product_repository.dart';
// import 'core/viewmodel/product_viewmodel.dart';
import 'views/home_screen.dart';


import 'dart:io' as io;
import 'package:flutter/foundation.dart'; // For kIsWeb

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on platform
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDZm8S2tHmdHUrZTVegZGlrrNNtYE4Z34g", // Use the Firebase web config here
        authDomain: "ethiotender-5cb6e.firebaseapp.com",
        projectId: "ethiotender-5cb6e",
        storageBucket: "ethiotender-5cb6e.firebasestorage.app",
        messagingSenderId: "678859014707",
        appId: "1:678859014707:web:ff49d8e2b020eadcf65946",
        measurementId: "G-TYJ06FRL7C",
      ),
    );
  } else {
    await Firebase.initializeApp(
      
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TenderViewModel(tenderRepo.TenderRepository(tenderRepo.DBType.firebase)),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddTenderForm(),
    );
  }
}
