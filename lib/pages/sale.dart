import 'package:flutter/material.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

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
            'Transaksi Penjualan',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text("Barang Jadi xxx"),
                subtitle: const Text("10 Kg"),
                trailing: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        shape: BoxShape.rectangle,
                        color: Colors.blueAccent),
                    child: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/update-sale');
                  },
                ),
                tileColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-sale');
          },
          backgroundColor: Colors.blueAccent,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }
}
