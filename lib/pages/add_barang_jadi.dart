// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown_barang.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class AddBarangJadiPage extends StatefulWidget {
  const AddBarangJadiPage({super.key});

  @override
  State<AddBarangJadiPage> createState() => _AddBarangJadiPageState();
}

class _AddBarangJadiPageState extends State<AddBarangJadiPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  List<Map<String, dynamic>> barangMentah = [];
  final List<String> ukuran = ['SP', 'LB', 'TP', 'TG'];
  String? selectedBarangId;
  String? selectedUkuran;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchBarangs();
  }

  Future<void> fetchBarangs() async {
    final token = await SharedPreferencesHelper.getToken();
    var response = await BaseClient()
        .getWithToken('barang-mentah/available', token!)
        .catchError((err) {});
    if (response != null && response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      List data = responseData['data'];
      setState(() {
        barangMentah = data.map((item) {
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
          'Tambah Barang Jadi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CustomDropdownBarang(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih barang mentah terlebih dahulu';
                    }
                    return null;
                  },
                  items: barangMentah,
                  onChanged: (value) {
                    setState(() {
                      selectedBarangId = value; // Save selected barang ID
                    });
                  },
                  selectedValue: selectedBarangId,
                  hintText: "Barang Mentah",
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    controller: namaController,
                    hintText: "Nama",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
                CustomDropdown(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ukuran tidak boleh kosong';
                      }
                      return null;
                    },
                    items: ukuran,
                    onChanged: (value) {
                      selectedUkuran = value!.toLowerCase();
                    },
                    selectedValue: selectedUkuran,
                    hintText: "Ukuran"),
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
                        return 'Harga tidak boleh kosong';
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
                          'barang-jadi/store',
                          jsonEncode({
                            'barang_mentah_id': selectedBarangId,
                            'nama': namaController.text,
                            'ukuran': selectedUkuran,
                            'jumlah': jumlahController.text,
                            'harga': hargaController.text,
                            'keterangan': keteranganController.text,
                          }),
                          token!);

                      var data = jsonDecode(response.body);
                      if (response != null && response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(data['message']),
                        ));
                        Navigator.of(context).pop();
                        Navigator.popAndPushNamed(context, '/stock-barang');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(data['message']),
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
            )),
      ),
    );
  }
}
