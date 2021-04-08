import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KayitFormu extends StatefulWidget {
  @override
  _KayitFormuState createState() => _KayitFormuState();
}

class _KayitFormuState extends State<KayitFormu> {
  String kullaniciAdi, email, sifre;
  var _dogrulamaAnahtari = GlobalKey<FormState>();
  bool kayitDurumu = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dogrulamaAnahtari,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: 200,
              child: Image.asset("images/to-do.png"),
            ),
            if (!kayitDurumu)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (alinanAd) {
                    kullaniciAdi = alinanAd;
                  },
                  validator: (alinanAd) {
                    return alinanAd.isEmpty ? "Boş bırakılamaz" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Kullanıcı adı girin",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (alinanEmail) {
                  email = alinanEmail;
                },
                validator: (alinanEmail) {
                  return alinanEmail.contains('@') ? null : "Geçersiz email";
                },
                decoration: InputDecoration(
                  labelText: "Email girin",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                onChanged: (alinanSifre) {
                  sifre = alinanSifre;
                },
                validator: (alinanSifre) {
                  return alinanSifre.length > 6
                      ? null
                      : "En az 6 karakterden oluşmalı";
                },
                decoration: InputDecoration(
                  labelText: "Şifre girin",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    kayitEkle();
                  },
                  child: kayitDurumu
                      ? Text(
                          "Giriş Yap",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        )
                      : Text(
                          "Kaydol",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4A148C),
                    shadowColor: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    kayitDurumu = !kayitDurumu;
                  });
                },
                child: kayitDurumu
                    ? Text(
                        "Hesabım yok",
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(
                        "Zaten hesabım var",
                        style: TextStyle(color: Colors.black),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void kayitEkle() {
    if (_dogrulamaAnahtari.currentState.validate()) {
      formuTeslimEt(kullaniciAdi, email, sifre);
    }
  }

  formuTeslimEt(String kullaniciAdi, String email, String sifre) async {
    final yetki = FirebaseAuth.instance;
    AuthResult yetkiSonucu;

    if (kayitDurumu) {
    } else {
      yetkiSonucu = await yetki.createUserWithEmailAndPassword(
          email: email, password: sifre);

      String uidTutucu = yetkiSonucu.user.uid;

      await Firestore.instance
          .collection("Kullanicilar")
          .document(uidTutucu)
          .setData({
        "kullaniciAdi": kullaniciAdi,
        "email": email,
      });
    }
  }
}
