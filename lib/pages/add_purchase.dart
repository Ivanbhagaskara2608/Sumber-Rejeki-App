// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sumber_rezeki/services/base_client.dart';
import 'package:sumber_rezeki/services/shared_preferences.dart';
import 'package:sumber_rezeki/widgets/custom_calendar_textfield.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class AddPurchasePage extends StatefulWidget {
  const AddPurchasePage({super.key});

  @override
  State<AddPurchasePage> createState() => _AddPurchasePageState();
}

class _AddPurchasePageState extends State<AddPurchasePage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController supplierController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          'Tambah Transaksi Pembelian',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomCalendarTextField(
                  controller: tanggalController, hintText: "Tanggal"),
              const SizedBox(height: 15),
              CustomTextField(
                controller: namaController,
                hintText: "Nama",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: supplierController,
                hintText: "Supplier",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Supplier tidak boleh kosong';
                  }
                  return null;
                },
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
                    return 'Harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: keteranganController, hintText: "Keterangan"),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final token = await SharedPreferencesHelper.getToken();
                    var response = await BaseClient().postWithToken(
                        "barang-mentah/store",
                        jsonEncode({
                          "nama": namaController.text,
                          "supplier": supplierController.text,
                          "jumlah": jumlahController.text,
                          "harga": hargaController.text,
                          "keterangan": keteranganController.text
                        }),
                        token!);
                    var data = jsonDecode(response.body);
                    if (response.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(data['message']),
                      ));
                      Navigator.of(context).pop();
                      Navigator.popAndPushNamed(context, '/purchase');
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ),
      ),
    );
  }
}
