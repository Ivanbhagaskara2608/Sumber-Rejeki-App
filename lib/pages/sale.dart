import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<dynamic> sales = [];
  String? userRole;

  Future<void> salesData() async {
    final token = await SharedPreferencesHelper.getToken();
    userRole = await SharedPreferencesHelper.getRole();
    var response = await BaseClient()
        .getWithToken('penjualan/data', token!)
        .catchError((err) {});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        sales = data['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    salesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Transaksi Penjualan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: RefreshIndicator(
          onRefresh: salesData,
          child: ListView.builder(
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final sale = sales[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sale['id']),
                      Text(
                        "Rp${sale['total_harga']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${sale['jumlah_barang']} Kg",
                          style: const TextStyle(fontSize: 12)),
                      Text(sale['tanggal'].split(' ')[0],
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: (userRole == "penjualan" ||
                          userRole == "superadmin")
                      ? InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              shape: BoxShape.rectangle,
                              color: Colors.blueAccent,
                            ),
                            child: const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/update-sale',
                                arguments: sale);
                          },
                        )
                      : null,
                  tileColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton:
          (userRole == "penjualan" || userRole == "superadmin")
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-sale');
                  },
                  backgroundColor: Colors.blueAccent,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
    );
  }
}
