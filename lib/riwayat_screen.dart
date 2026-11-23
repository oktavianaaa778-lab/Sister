import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ['Kamis, 05 November 2026', '06.16 WIB', 'Hadir'],
      ['Rabu, 04 November 2026', '06.45 WIB', 'Hadir'],
      ['Selasa, 03 November 2026', '—', 'Izin'],
      ['Senin, 02 November 2026', '06.32 WIB', 'Hadir'],
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Presensi')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        const Text('Riwayat Kehadiran',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ...data.map((item) => Card(
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE3EEF8),
                    child:
                        Icon(Icons.calendar_month, color: Color(0xFF598BC0))),
                title: Text(item[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                subtitle: Text(item[1]),
                trailing: Text(item[2],
                    style: TextStyle(
                        color:
                            item[2] == 'Hadir' ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold)),
              ),
            )),
      ]),
    );
  }
}
