import 'package:flutter/material.dart';
import '../models/obat.dart';

class DataObat extends ChangeNotifier {
  List<Obat> semuaObat = [
    Obat(
      nama: "Paracetamol",
      dosis: "500 mg",
      frekuensi: "2x sehari",
      tanggal: "06-01-2026",
      golongan: "Obat Bebas",
      jam: "08:00",
      sudahDiminum: false,
    ),
    Obat(
      nama: "Antimo",
      dosis: "50 mg",
      frekuensi: "1x sehari",
      tanggal: "07-01-2026",
      golongan: "Obat Bebas Terbatas",
      jam: "10:00",
    ),
    Obat(
      nama: "Omeprazole",
      dosis: "20 mg",
      frekuensi: "1x sehari",
      tanggal: "08-01-2026",
      golongan: "Obat Keras",
      jam: "06:30",
    ),
  ];

  void tambah(Obat obat) {
    semuaObat.add(obat);
    notifyListeners();
  }
  void hapus(Obat obat) {
    semuaObat.remove(obat);
    notifyListeners();
  }
  void toggleMinum(Obat obat) {
    obat.sudahDiminum = !obat.sudahDiminum;
    notifyListeners();
  }
  void edit(Obat lama, Obat baru) {
    int index = semuaObat.indexOf(lama);
    if (index != -1) {
      semuaObat[index] = baru;
      notifyListeners();
    }
  }
  List<Obat> byKategori(String kategori) {
    return semuaObat.where((o) => o.golongan == kategori).toList();
  }

  int totalObat() => semuaObat.length;
  int totalKategori() {
    return semuaObat.map((e) => e.golongan).toSet().length;
  }
  List<Obat> terbaru() {
    return semuaObat.reversed.take(2).toList();
  }
}
