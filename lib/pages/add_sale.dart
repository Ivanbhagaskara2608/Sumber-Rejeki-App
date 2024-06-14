import 'package:flutter/material.dart';
import 'package:sumber_rezeki/widgets/custom_calendar_textfield.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

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
  final List<String> barangs = [
    'BJ-1',
    'BJ-2',
  ];
  String? selectedBarang;
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
          child: Column(
            children: [
              CustomCalendarTextField(
                  controller: tanggalController, hintText: "Tanggal"),
              const SizedBox(height: 15),
              CustomDropdown(
                  items: barangs,
                  onChanged: (value) {
                    selectedBarang = value;
                  },
                  selectedValue: selectedBarang,
                  hintText: "Barang Jadi"),
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
          )),
    );
  }
}
