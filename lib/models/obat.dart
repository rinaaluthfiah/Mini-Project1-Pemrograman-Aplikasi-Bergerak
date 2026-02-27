class Obat {
  String nama;
  String dosis;
  String frekuensi;
  String tanggal;
  String golongan;
  String jam;bool sudahDiminum;

  Obat({
    required this.nama,
    required this.dosis,
    required this.frekuensi,
    required this.tanggal,
    required this.golongan,
    required this.jam,
    this.sudahDiminum = false,
  });
}
