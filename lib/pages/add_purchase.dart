import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            CustomCalendarTextField(
                controller: tanggalController, hintText: "Tanggal"),
            const SizedBox(height: 15),
            CustomTextField(controller: namaController, hintText: "Nama"),
            const SizedBox(height: 15),
            CustomTextField(
                controller: supplierController, hintText: "Supplier"),
            const SizedBox(height: 15),
            CustomTextField(
                controller: jumlahController,
                hintText: "Jumlah Barang (KG)",
                keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            CustomTextField(
                controller: hargaController,
                hintText: "Harga Satuan (Rp)",
                keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            CustomTextField(
                controller: keteranganController, hintText: "Keterangan"),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Do something
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
    );
  }
}
