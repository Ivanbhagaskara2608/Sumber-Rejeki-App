// ignore_for_file: avoid_print, use_build_context_synchronously

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
  String pemasukan = "Rp 0";
  String pengeluaran = "Rp 0";
  String laba = "Rp 0";

  Future<void> userProfile() async {
    final token = await SharedPreferencesHelper.getToken();
    var response = await BaseClient()
        .postWithToken("users/me", jsonEncode({}), token!)
        .catchError((err) {});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SharedPreferencesHelper.saveRole(data['data']['role']);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(data['data']['role']),
      // ));
    }
  }

  Future<void> getLaporan() async {
    final token = await SharedPreferencesHelper.getToken();
    DateTime now = DateTime.now();
    int bulan = now.month;
    int tahun = now.year;
    var response = await BaseClient().getWithToken(
        'laporan/rangkuman-transaksi?bulan=$bulan&tahun=$tahun', token!);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        pemasukan = data['data']['pemasukan'];
        pengeluaran = data['data']['pengeluaran'];
        laba = data['data']['laba'];
      });
    }
  }

  Future<void> refreshData() async {
    final lastUpdatedString =
        await SharedPreferencesHelper.getTokenExpiryDate();
    final token = await SharedPreferencesHelper.getToken();

    if (lastUpdatedString != null) {
      final expiryTime = DateTime.parse(lastUpdatedString);
      final now = DateTime.now();

      if (now.isAfter(expiryTime)) {
        var response = await BaseClient()
            .postWithToken('users/refresh', jsonEncode({}), token!);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          SharedPreferencesHelper.saveToken(data['data']['access_token']);
          SharedPreferencesHelper.saveTokenExpiryDate();
          userProfile();
          getLaporan();
          print(data['data']['access_token']);
        } else {
          SharedPreferencesHelper.clearToken();
          SharedPreferencesHelper.clearRole();
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        }
      } else {
        userProfile();
        getLaporan();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Image.asset(
              "assets/images/logo_sumberrejeki.png",
              scale: 5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            laba,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Laba',
            style: TextStyle(fontSize: 14),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      pemasukan,
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Pemasukan',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                  child: VerticalDivider(
                    color: Colors.black,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      pengeluaran,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
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
                  onTap: () async {
                    final token = await SharedPreferencesHelper.getToken();
                    var response = await BaseClient()
                        .postWithToken("users/logout", jsonEncode({}), token!);
                    var data = jsonDecode(response.body);

                    if (response.statusCode == 200) {
                      SharedPreferencesHelper.clearToken();
                      SharedPreferencesHelper.clearRole();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(data['message']),
                      ));
                    }
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
          ),
          const SizedBox(
            height: 60,
          ),
        ]),
      ),
    ));
  }
}
