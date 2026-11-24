import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'widgets.dart';
import 'login.dart';
import 'poin.dart';
import 'presensi.dart';
import 'izin.dart';

// ===== Halaman Profil: menu 2 x 2 + Log Out =====
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profil')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 90),
          children: [
            CardPanel(
              child: Column(children: [
                Row(children: [
                  Expanded(
                      child: _menuTile(context, 'Poin', Icons.shield,
                          const ViolationScreen())),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _menuTile(context, 'Registrasi Wajah', Icons.face,
                          const FaceRegistrationScreen())),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: _menuTile(context, 'Buat Izin', Icons.edit_note,
                          const PermitScreen())),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _menuTile(context, 'Data Diri', Icons.person,
                          const PersonalDataScreen())),
                ]),
              ]),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen())),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
              ),
            ),
          ],
        ),
      );
}

Widget _menuTile(
    BuildContext context, String label, IconData icon, Widget page) {
  return Material(
    color: lightBlue,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: darkBlue, size: 30),
            const SizedBox(height: 6),
            Text(label,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );
}

// ===== Halaman Data Diri: muncul saat tombol Data Diri ditekan =====
class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Data Diri')),
        body: ListView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 90),
            children: [
              CardPanel(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Data Personal',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const PlaceholderImage('foto_profil.png',
                        height: 100, width: 100),
                    const SizedBox(height: 10),
                    profile('Nama', 'Oktaviana Syifa’ul Aula'),
                    profile('Tempat Lahir', 'Banjarnegara'),
                    profile('Tanggal Lahir', '29 Oktober 2008'),
                    profile('Jenis Kelamin', 'Perempuan'),
                    profile('Telepon', '-'),
                    profile('NIK', '-'),
                    profile('NIS', '87654'),
                    profile('NISN', '0094'),
                    profile('Agama', 'Islam'),
                    profile('Alamat', 'Susukan, Banjarnegara'),
                    profile('Tahun Ajaran', '2026/2027'),
                    const Divider(),
                    const Text('Data Orang Tua',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    profile('Nama Ayah', '-'),
                    profile('Pekerjaan Ayah', '-'),
                    profile('Nama Ibu', '-'),
                    profile('Pekerjaan Ibu', '-'),
                    profile('Alamat Orang Tua', '-'),
                    profile('Telepon Orang Tua', '-'),
                    const Divider(),
                    const Text('Data Wali Murid',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    profile('Nama Wali', '-'),
                    profile('Pekerjaan Wali', '-'),
                    profile('Telepon Wali', '-'),
                    profile('Alamat Wali', '-'),
                  ])),
            ]),
      );
}
