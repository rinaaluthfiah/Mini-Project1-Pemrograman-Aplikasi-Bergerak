import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/data_obat.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  final String golongan;
  const HomePage({super.key, required this.golongan});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dataObat = Provider.of<DataObat>(context);
    final filtered = dataObat.byKategori(widget.golongan);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.golongan),
        backgroundColor: const Color.fromARGB(255, 219, 140, 166),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 164, 194),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormPage(golongan: widget.golongan),
            ),
          );
        },
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final data = filtered[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE3F1), Color(0xFFEEDCFF)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text("${data.dosis} • ${data.frekuensi}"),
                      Text("Tanggal: ${data.tanggal}"),
                      Text("Jam: ${data.jam}"),
                      const SizedBox(height: 6),
                      Text(
                        data.sudahDiminum
                            ? "✅ Sudah diminum"
                            : "⏰ Belum diminum",
                        style: TextStyle(
                          color: data.sudahDiminum
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        data.sudahDiminum
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: data.sudahDiminum ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        dataObat.toggleMinum(data);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 153, 139, 147),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                FormPage(golongan: widget.golongan, obat: data),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        dataObat.hapus(data);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
