// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_calendar_textfield.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown_barang.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';
import 'dart:convert';

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  List<Map<String, dynamic>> barangs = [];
  String? selectedBarangId;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchBarangs(); // Fetch data from API
  }

  Future<void> fetchBarangs() async {
    final token = await SharedPreferencesHelper.getToken();
    var response = await BaseClient()
        .getWithToken('barang-jadi/available', token!)
        .catchError((err) {});
    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      List data = responseData['data'];
      setState(() {
        barangs = data.map((item) {
          return {
            'id': item['id'],
            'nama': item['nama'],
          };
        }).toList();
      });
    }
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
          'Tambah Transaksi Penjualan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomCalendarTextField(
                    controller: tanggalController, hintText: "Tanggal"),
                const SizedBox(height: 15),
                CustomDropdownBarang(
                  validator: (value) {
                    if (value == null) {
                      return 'Barang Jadi tidak boleh kosong';
                    }
                    return null;
                  },
                  items: barangs,
                  onChanged: (value) {
                    setState(() {
                      selectedBarangId = value; // Save selected barang ID
                    });
                  },
                  selectedValue: selectedBarangId,
                  hintText: "Barang Jadi",
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: jumlahController,
                    hintText: "Jumlah Barang (KG)",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah Barang tidak boleh kosong';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: hargaController,
                    hintText: "Harga Satuan (Rp)",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga Satuan tidak boleh kosong';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: keteranganController, hintText: "Keterangan"),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final token = await SharedPreferencesHelper.getToken();
                      var response = await BaseClient().postWithToken(
                          'penjualan/store',
                          jsonEncode({
                            'tanggal': tanggalController.text,
                            'barang_id': selectedBarangId,
                            'jumlah': jumlahController.text,
                            'harga': hargaController.text,
                            'keterangan': keteranganController.text,
                          }),
                          token!);
                      var data = jsonDecode(response.body);

                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(data['message']),
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, '/sale');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(data['message']),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
