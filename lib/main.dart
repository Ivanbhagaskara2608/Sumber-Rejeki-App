import 'package:flutter/material.dart';
import 'package:sumber_rezeki/pages/add_purchase.dart';
import 'package:sumber_rezeki/pages/purchase.dart';
import 'package:sumber_rezeki/pages/login.dart';
import 'package:sumber_rezeki/pages/sale.dart';
import 'package:sumber_rezeki/pages/splashscreen.dart';
import 'package:sumber_rezeki/pages/dashboard.dart';
import 'package:sumber_rezeki/pages/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splashscreen',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/add-transaction': (context) => const TransactionPage(),
        '/purchase': (context) => const PurchasePage(),
        '/sale': (context) => const SalePage(),
        '/add-purchase': (context) => const AddPurchasePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}
