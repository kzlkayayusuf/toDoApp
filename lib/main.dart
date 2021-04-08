import 'package:firebasetodo/kayitEkrani.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Yapilacaklar());
}

class Yapilacaklar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4A148C),
      ),
      home: KayitEkrani(),
    );
  }
}
