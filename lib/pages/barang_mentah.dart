import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class BarangMentahPage extends StatefulWidget {
  const BarangMentahPage({super.key});

  @override
  State<BarangMentahPage> createState() => _BarangMentahPageState();
}

class _BarangMentahPageState extends State<BarangMentahPage> {
  List<dynamic> barangMentahs = [];
  String? userRole;

  Future<void> getData() async {
    final token = await SharedPreferencesHelper.getToken();
    userRole = await SharedPreferencesHelper.getRole();
    var response = await BaseClient()
        .getWithToken('barang-mentah/data', token!)
        .catchError((err) {});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        barangMentahs = data['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getData,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView.builder(
              itemCount: barangMentahs.length,
              itemBuilder: (context, index) {
                final barangMentah = barangMentahs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(barangMentah['nama']),
                    subtitle: Text(barangMentah['nama_supplier']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${barangMentah['jumlah']} Kg",
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                        if (userRole == "pembelian" || userRole == "superadmin")
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                shape: BoxShape.rectangle,
                                color: Colors.blueAccent,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/update-barang-mentah',
                                  arguments: barangMentah);
                            },
                          ),
                      ],
                    ),
                    tileColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
