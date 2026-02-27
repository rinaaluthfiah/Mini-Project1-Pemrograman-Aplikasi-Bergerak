import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/data_obat.dart';
import '../models/obat.dart';
import 'home_page.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataObat = Provider.of<DataObat>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE3F1), Color(0xFFEEDCFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(240, 172, 201, 1),
                    Color.fromARGB(255, 241, 134, 202),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HealthTracker 💊",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Catatan Konsumsi Obatmu",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _infoBox(
                          "Total Obat",
                          dataObat.totalObat().toString(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _infoBox(
                          "Kategori",
                          dataObat.totalKategori().toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  pengingatObat(dataObat),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Riwayat Terakhir",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 10),
                  ...dataObat.terbaru().map((e) => _riwayat(e)),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  _kategoriBox(context, "Obat Bebas", const Color(0xFF92CCA0)),
                  _kategoriBox(
                    context,
                    "Obat Bebas Terbatas",
                    const Color(0xFF75ADE2),
                  ),
                  _kategoriBox(context, "Obat Keras", const Color(0xFFCE5555)),
                  _kategoriBox(context, "Obat Herbal", const Color(0xFF839F8D)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pengingatObat(DataObat dataObat) {
    final belum = dataObat.semuaObat
        .where((o) => o.sudahDiminum == false)
        .toList();

    if (belum.isEmpty) return const SizedBox();
    final obat = belum.first;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFC1E3), Color(0xFFE0BBFF)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: Colors.white, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pengingat Obat",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${obat.nama} - Jam ${obat.jam}",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _riwayat(Obat obat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(obat.nama), Text(obat.tanggal)],
      ),
    );
  }

  Widget _kategoriBox(BuildContext context, String title, Color warna) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomePage(golongan: title)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: warna,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
