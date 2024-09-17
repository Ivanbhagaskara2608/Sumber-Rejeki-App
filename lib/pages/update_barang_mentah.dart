// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class UpdateBarangMentahPage extends StatefulWidget {
  const UpdateBarangMentahPage({super.key});

  @override
  State<UpdateBarangMentahPage> createState() => _UpdateBarangMentahPageState();
}

class _UpdateBarangMentahPageState extends State<UpdateBarangMentahPage> {
  late TextEditingController namaController = TextEditingController();
  late TextEditingController supplierController = TextEditingController();
  late TextEditingController jumlahController = TextEditingController();
  late TextEditingController hargaController = TextEditingController();
  late TextEditingController keteranganController = TextEditingController();
  late String id;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final barangMentah =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    namaController = TextEditingController(text: barangMentah['nama']);
    supplierController =
        TextEditingController(text: barangMentah['nama_supplier']);
    jumlahController =
        TextEditingController(text: barangMentah['jumlah'].toString());
    hargaController =
        TextEditingController(text: barangMentah['harga'].toString());
    keteranganController =
        TextEditingController(text: barangMentah['keterangan'] ?? '');
    id = barangMentah['id'].toString();
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
                    'barang-mentah/delete?id=$id', jsonEncode({}), token!);

                if (response.statusCode == 200) {
                  var data = jsonDecode(response.body);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(data['message']),
                    ),
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, '/stock-barang');
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal menghapus transaksi'),
                    ),
                  );
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
          'Update Barang Mentah',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  controller: namaController,
                  hintText: "Nama",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  }),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: supplierController,
                  hintText: "Supplier",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Supplier tidak boleh kosong';
                    }
                    return null;
                  }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final token = await SharedPreferencesHelper.getToken();
                        var response = await BaseClient().postWithToken(
                            'barang-mentah/update?id=$id',
                            jsonEncode({
                              'nama': namaController.text,
                              'supplier': supplierController.text,
                              'jumlah': jumlahController.text,
                              'harga': hargaController.text,
                              'keterangan': keteranganController.text
                            }),
                            token!);

                        if (response.statusCode == 200) {
                          var data = jsonDecode(response.body);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(data['message']),
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.popAndPushNamed(context, '/stock-barang');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Gagal mengupdate transaksi'),
                            ),
                          );
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
        ),
      ),
    );
  }
}
