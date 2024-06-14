import 'package:flutter/material.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class AddBarangJadiPage extends StatefulWidget {
  const AddBarangJadiPage({super.key});

  @override
  State<AddBarangJadiPage> createState() => _AddBarangJadiPageState();
}

class _AddBarangJadiPageState extends State<AddBarangJadiPage> {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final List<String> barangMentah = [
    'BM-1',
    'BM-2',
  ];
  final List<String> ukuran = ['SP', 'LB', 'TP', 'TG'];
  String? selectedBarang;
  String? selectedUkuran;
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
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomDropdown(
                  items: barangMentah,
                  onChanged: (value) {
                    selectedBarang = value;
                  },
                  selectedValue: selectedBarang,
                  hintText: "Barang Mentah"),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: jumlahController,
                  hintText: "Nama",
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              CustomDropdown(
                  items: ukuran,
                  onChanged: (value) {
                    selectedUkuran = value;
                  },
                  selectedValue: selectedUkuran,
                  hintText: "Ukuran"),
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
