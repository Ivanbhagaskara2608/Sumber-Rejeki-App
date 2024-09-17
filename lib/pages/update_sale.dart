// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_calendar_textfield.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class UpdateSalePage extends StatefulWidget {
  const UpdateSalePage({super.key});

  @override
  State<UpdateSalePage> createState() => _UpdateSalePageState();
}

class _UpdateSalePageState extends State<UpdateSalePage> {
  late TextEditingController tanggalController;
  late TextEditingController jumlahController;
  late TextEditingController hargaController;
  late TextEditingController keteranganController;
  late String transaksiId;
  late String barangId;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sale =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    tanggalController =
        TextEditingController(text: sale['tanggal'].split(' ')[0]);
    jumlahController =
        TextEditingController(text: sale['jumlah_barang'].toString());
    hargaController =
        TextEditingController(text: sale['harga_satuan'].toString());
    keteranganController =
        TextEditingController(text: sale['keterangan'] ?? '');
    transaksiId = sale['id'].toString();
    barangId = sale['barang_id'].toString();
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content:
              const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () async {
                final token = await SharedPreferencesHelper.getToken();
                var response = await BaseClient().postWithToken(
                    'penjualan/delete',
                    jsonEncode({"id": transaksiId}),
                    token!);

                if (response.statusCode == 200) {
                  var data = jsonDecode(response.body);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(data['message']),
                    ),
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, '/sale');
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
          },
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          transaksiId,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomCalendarTextField(
                controller: tanggalController,
                hintText: "Tanggal",
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  controller: TextEditingController(text: barangId),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                ),
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
                },
              ),
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
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: keteranganController,
                hintText: "Keterangan",
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final token = await SharedPreferencesHelper.getToken();
                        var response = await BaseClient().postWithToken(
                            'penjualan/update',
                            jsonEncode({
                              "id": transaksiId,
                              'barang_id': 'BRJ-00001',
                              "tanggal": tanggalController.text,
                              "jumlah": jumlahController.text,
                              "harga": hargaController.text,
                              "keterangan": keteranganController.text,
                            }),
                            token!);
                        if (response.statusCode == 200) {
                          var data = jsonDecode(response.body);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(data['message']),
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, '/sale');
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
