// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> userProfile() async {
    final token = await SharedPreferencesHelper.getToken();
    var response = await BaseClient()
        .postWithToken("users/me", jsonEncode({}), token!)
        .catchError((err) {});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SharedPreferencesHelper.saveRole(data['data']['role']);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['data']['role']),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    userProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(
        child: Image.asset(
          "assets/images/logo_sumberrejeki.png",
          scale: 5,
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        '600.000',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        'Selisih',
        style: TextStyle(fontSize: 14),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Divider(
          color: Colors.black,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '1.000.000',
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pemasukan',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              child: VerticalDivider(
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Text(
                  '400.000',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pengeluaran',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 60,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/add-transaction');
              },
              child: Column(
                children: [
                  Image.asset("assets/images/transaksi.png", scale: 4),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Transaksi')
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/stock-barang');
              },
              child: Column(
                children: [
                  Image.asset("assets/images/troly.png", scale: 4),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Stok Barang')
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              child: Column(
                children: [
                  Image.asset("assets/images/logout.png", scale: 4),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Logout')
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
