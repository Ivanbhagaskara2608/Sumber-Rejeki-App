import 'package:flutter/material.dart';
import 'package:sumber_rezeki/pages/login.dart';
import 'package:sumber_rezeki/pages/splashscreen.dart';
import 'package:sumber_rezeki/pages/dashboard.dart';
import 'package:sumber_rezeki/pages/add_transaction.dart';

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
        '/add-transaction': (context) => const AddTransactionPage(),
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
