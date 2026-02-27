import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/kategori_page.dart';
import 'models/data_obat.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => DataObat(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const KategoriPage(),
    );
  }
}
