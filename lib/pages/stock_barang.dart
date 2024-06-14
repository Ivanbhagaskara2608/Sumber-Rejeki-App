import 'package:flutter/material.dart';
import 'package:sumber_rezeki/pages/barang_jadi.dart';
import 'package:sumber_rezeki/pages/barang_mentah.dart';

class StockBarangPage extends StatelessWidget {
  const StockBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text(
            'Stock Barang',
            style: TextStyle(color: Colors.white),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0), // Height of the TabBar
            child: Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: Colors.blueAccent, // Active tab text color
                unselectedLabelColor: Colors.grey, // Inactive tab text color
                tabs: [
                  Tab(
                    text: 'Barang Mentah',
                  ),
                  Tab(
                    text: 'Barang Jadi',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [BarangMentahPage(), BarangJadiPage()],
        ),
      ),
    );
  }
}
