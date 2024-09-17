import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  List<dynamic> purchases = [];
  String? userRole;

  @override
  void initState() {
    super.initState();
    purchaseData();
    _getUserRole();
  }

  Future<void> purchaseData() async {
    final token = await SharedPreferencesHelper.getToken();
    userRole = await SharedPreferencesHelper.getRole();
    var response = await BaseClient()
        .getWithToken('barang-mentah/data-pembelian', token!)
        .catchError((err) {});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        purchases = (data['data'] as List)
            .where((purchase) =>
                purchase['nama_barang'] != null &&
                purchase['nama_supplier'] != null)
            .toList();
      });
    }
  }

  Future<void> _getUserRole() async {
    final role = await SharedPreferencesHelper.getRole();
    setState(() {
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Transaksi Pembelian',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: RefreshIndicator(
          onRefresh: purchaseData,
          child: ListView.builder(
              itemCount: purchases.length,
              itemBuilder: (context, index) {
                final purchase = purchases[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(purchase['nama_barang'].toString()),
                    subtitle: Text(purchase['nama_supplier'].toString()),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(purchase['tanggal'].split(' ')[0]),
                        Text("Rp${purchase['total_harga']}"),
                      ],
                    ),
                    tileColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton:
          (userRole == 'pembelian' || userRole == 'superadmin')
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-purchase');
                  },
                  backgroundColor: Colors.blueAccent,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
    );
  }
}
