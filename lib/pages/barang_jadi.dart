import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';

class BarangJadiPage extends StatefulWidget {
  const BarangJadiPage({super.key});

  @override
  State<BarangJadiPage> createState() => _BarangJadiPageState();
}

class _BarangJadiPageState extends State<BarangJadiPage> {
  List<dynamic> barangJadis = [];
  String? userRole;

  Future<void> getData() async {
    final token = await SharedPreferencesHelper.getToken();
    userRole = await SharedPreferencesHelper.getRole();
    var response = await BaseClient()
        .getWithToken('barang-jadi/data', token!)
        .catchError((err) {});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        barangJadis = data['data'];
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
                itemCount: barangJadis.length,
                itemBuilder: (context, index) {
                  final barangJadi = barangJadis[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(barangJadi['nama']),
                      subtitle:
                          Text(barangJadi['ukuran'].toString().toUpperCase()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${barangJadi['jumlah']} Kg",
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          if (userRole == "produksi" ||
                              userRole == "superadmin")
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
                                    context, '/update-barang-jadi',
                                    arguments: barangJadi);
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
        floatingActionButton:
            (userRole == "produksi" || userRole == "superadmin")
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-barang-jadi');
                    },
                    backgroundColor: Colors.blueAccent,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null);
  }
}
