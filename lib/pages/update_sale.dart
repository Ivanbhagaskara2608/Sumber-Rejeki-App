import 'package:flutter/material.dart';
import 'package:sumber_rezeki/widgets/custom_calendar_textfield.dart';
import 'package:sumber_rezeki/widgets/custom_dropdown.dart';
import 'package:sumber_rezeki/widgets/custom_textfield.dart';

class UpdateSalePage extends StatefulWidget {
  const UpdateSalePage({super.key});

  @override
  State<UpdateSalePage> createState() => _UpdateSalePageState();
}

class _UpdateSalePageState extends State<UpdateSalePage> {
  final TextEditingController tanggalController =
      TextEditingController(text: "2022-10-10");
  final TextEditingController jumlahController =
      TextEditingController(text: "10");
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController keteranganController =
      TextEditingController(text: "Terjual");

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
          'Update Transaksi Penjualan',
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Background color
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5), // Padding inside the container
                child: TextFormField(
                  controller: TextEditingController(text: "BJ-1"),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Removes the outline
                  ),
                  readOnly: true, // Makes the field non-editable
                ),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Do something
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
                  ElevatedButton(
                    onPressed: () {
                      // Do something
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
          )),
    );
  }
}
