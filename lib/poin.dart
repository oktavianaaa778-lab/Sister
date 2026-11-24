import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_pkg;
import 'widgets.dart';

class ViolationScreen extends StatelessWidget {
  const ViolationScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Poin Pelanggaran')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        CardPanel(
            child: Column(children: [
          const Text('POIN PELANGGARAN',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 14),
          Container(
              width: 120,
              height: 95,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: lightBlue, borderRadius: BorderRadius.circular(12)),
              child: const Text('0',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: darkBlue))),
          const Text('Total poin tahun ajaran 2026/2027',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          const PlaceholderImage('ilustrasi_pelanggaran.png', height: 230),
          const SizedBox(height: 8),
          const Text('RIWAYAT POIN',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Belum ada catatan pelanggaran',
              style: TextStyle(color: Colors.grey)),
        ]))
      ]));
}
