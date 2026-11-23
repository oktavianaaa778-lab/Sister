import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Siswa')),
      body: ListView(padding: const EdgeInsets.all(22), children: [
        const SizedBox(height: 12),
        const CircleAvatar(
            radius: 58,
            backgroundColor: Color(0xFFE3EEF8),
            child: Icon(Icons.person, size: 70, color: Color(0xFF598BC0))),
        const SizedBox(height: 16),
        const Text('OKTAVIANA SYIFA’UL AULA',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 5),
        const Text('9240 | XI RPL | SMK N 1 Bukateja',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey)),
        const SizedBox(height: 28),
        _info('NIS', '9240'),
        _info('Kelas', 'XI RPL'),
        _info('Sekolah', 'SMK N 1 Bukateja'),
        _info('Tahun Ajaran', '2026/2027'),
        const SizedBox(height: 22),
        OutlinedButton.icon(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false),
          icon: const Icon(Icons.logout),
          label: const Text('Log Out'),
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red, padding: const EdgeInsets.all(14)),
        ),
      ]),
    );
  }

  Widget _info(String label, String value) => Card(
        elevation: 0,
        child: ListTile(
            title: Text(label,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
            subtitle: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15))),
      );
}
