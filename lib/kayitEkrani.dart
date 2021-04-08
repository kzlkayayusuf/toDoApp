import 'package:firebasetodo/kayitFormu.dart';
import 'package:flutter/material.dart';

class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ekranı"),
        centerTitle: true,
      ),
      body: KayitFormu(),
    );
  }
}
