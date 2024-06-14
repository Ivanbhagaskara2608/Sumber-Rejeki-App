import 'package:flutter/material.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang Kembali',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('masuk sekarang untuk melanjutkan pekerjaanmu',
                style: TextStyle(fontStyle: FontStyle.italic)),
            Center(
              child: Image.asset("assets/images/logo_sumberrejeki.png"),
            ),
            const Text('User ID',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            const SizedBox(height: 5),
            CustomTextField(
                controller: userIdTextController, hintText: 'Masukkan User ID'),
            const SizedBox(height: 10),
            const Text('Password',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            const SizedBox(height: 5),
            TextFormField(
              controller: passwordTextController,
              obscureText: isPasswordVisible,
              decoration: InputDecoration(
                  hintText: 'Masukkan Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Masuk',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
