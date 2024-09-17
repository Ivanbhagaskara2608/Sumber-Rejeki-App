// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class UpdateBarangJadiPage extends StatefulWidget {
  const UpdateBarangJadiPage({super.key});

  @override
  State<UpdateBarangJadiPage> createState() => _UpdateBarangJadiPageState();
}

class _UpdateBarangJadiPageState extends State<UpdateBarangJadiPage> {
  late TextEditingController barangMentahController = TextEditingController();
  late TextEditingController namaController = TextEditingController();
  late TextEditingController tanggalController = TextEditingController();
  late TextEditingController jumlahController = TextEditingController();
  late TextEditingController hargaController = TextEditingController();
  late TextEditingController keteranganController = TextEditingController();
  late String id;
  late String barangMentahId;

  final List<String> ukuran = ['SP', 'LB', 'TP', 'TG'];
  String? selectedUkuran;
  String? initialUkuran;
  final _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final barangJadi =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    namaController = TextEditingController(text: barangJadi['nama']);
    tanggalController = TextEditingController(text: barangJadi['tanggal']);
    jumlahController =
        TextEditingController(text: barangJadi['jumlah'].toString());
    hargaController =
        TextEditingController(text: barangJadi['harga'].toString());
    keteranganController =
        TextEditingController(text: barangJadi['keterangan'] ?? '');
    id = barangJadi['id'];
    barangMentahId = barangJadi['barang_mentah_id'];
    barangMentahController = TextEditingController(text: barangMentahId);
    initialUkuran = barangJadi['ukuran'].toString().toUpperCase();
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus barang ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () async {
                final token = await SharedPreferencesHelper.getToken();
                var response = await BaseClient().postWithToken(
                    'barang-jadi/delete',
                    jsonEncode({
                      'barang_mentah_id': barangMentahId,
                      'barang_jadi_id': id,
                    }),
                    token!);

                var data = jsonDecode(response.body);
                if (response != null && response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(data['message']),
                  ));
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/stock-barang');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(data['message']),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          ],
        );
      },
    );
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
          'Update Barang Jadi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Background color
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5), // Padding inside the container
                  child: TextFormField(
                    controller: barangMentahController,
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Removes the outline
                    ),
                    readOnly: true, // Makes the field non-editable
                  ),
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
                    initialValue: initialUkuran,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final token =
                              await SharedPreferencesHelper.getToken();
                          var response = await BaseClient().postWithToken(
                              'barang-jadi/update',
                              jsonEncode({
                                'id': id,
                                'barang_mentah_id': barangMentahId,
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
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/stock-barang');
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
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Hapus',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
