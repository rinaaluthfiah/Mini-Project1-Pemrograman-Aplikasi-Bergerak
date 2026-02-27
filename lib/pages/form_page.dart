import 'package:flutter/material.dart';
import '../models/obat.dart';
import '../models/data_obat.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final String golongan;
  final Obat? obat; 

  const FormPage({super.key, required this.golongan, this.obat});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final dosisController = TextEditingController();
  final frekuensiController = TextEditingController();
  final tanggalController = TextEditingController();
  final jamController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.obat != null) {
      namaController.text = widget.obat!.nama;
      dosisController.text = widget.obat!.dosis;
      frekuensiController.text = widget.obat!.frekuensi;
      tanggalController.text = widget.obat!.tanggal;
      jamController.text = widget.obat!.jam;
    }
  }

  void simpanData() {
    if (_formKey.currentState!.validate()) {
      final obatBaru = Obat(
        nama: namaController.text,
        dosis: dosisController.text,
        frekuensi: frekuensiController.text,
        tanggal: tanggalController.text,
        golongan: widget.golongan,
        jam: jamController.text,
      );

      final dataObat = Provider.of<DataObat>(context, listen: false);
      if (widget.obat == null) {
        dataObat.tambah(obatBaru);
      } else {
        dataObat.edit(widget.obat!, obatBaru);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 201, 136, 158),
        title: Text(widget.obat == null ? "Tambah Obat" : "Edit Obat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Obat",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: dosisController,
                decoration: const InputDecoration(
                  labelText: "Dosis",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: frekuensiController,
                decoration: const InputDecoration(
                  labelText: "Frekuensi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: tanggalController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Konsumsi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: jamController,
                decoration: const InputDecoration(
                  labelText: "Jam Konsumsi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: simpanData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 113, 157),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(widget.obat == null ? "Simpan" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
