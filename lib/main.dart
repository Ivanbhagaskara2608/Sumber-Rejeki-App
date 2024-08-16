import 'package:flutter/material.dart';
import 'package:sumber_rezeki/pages/add_barang_jadi.dart';
import 'package:sumber_rezeki/pages/add_purchase.dart';
import 'package:sumber_rezeki/pages/add_sale.dart';
import 'package:sumber_rezeki/pages/purchase.dart';
import 'package:sumber_rezeki/pages/login.dart';
import 'package:sumber_rezeki/pages/sale.dart';
import 'package:sumber_rezeki/pages/splashscreen.dart';
import 'package:sumber_rezeki/pages/dashboard.dart';
import 'package:sumber_rezeki/pages/stock_barang.dart';
import 'package:sumber_rezeki/pages/transaction.dart';
import 'package:sumber_rezeki/pages/update_barang_jadi.dart';
import 'package:sumber_rezeki/pages/update_barang_mentah.dart';
import 'package:sumber_rezeki/pages/update_sale.dart';

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
        '/add-sale': (context) => const AddSalePage(),
        '/stock-barang': (context) => const StockBarangPage(),
        '/add-barang-jadi': (context) => const AddBarangJadiPage(),
        '/update-sale': (context) => const UpdateSalePage(),
        '/update-barang-jadi': (context) => const UpdateBarangJadiPage(),
        '/update-barang-mentah': (context) => const UpdateBarangMentahPage(),
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
