import 'package:flutter/material.dart';

class BarangJadiPage extends StatelessWidget {
  const BarangJadiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: const Text("Barang Jadi xxx"),
                    subtitle: const Text("Rp13000"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "10 Kg",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              shape: BoxShape.rectangle,
                              color: Colors.blueAccent,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    tileColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-barang-jadi');
          },
          backgroundColor: Colors.blueAccent,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ));
  }
}
