import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await SharedPreferencesHelper.getToken();
    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/dashboard'); 
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/login'); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo_sumberrejeki.png"),
      ),
    );
  }
}
