import 'package:flutter/material.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      ['07.30 - 08.14', 'Matematika Umum', 'Setya Rahayu, S.Pd.'],
      ['08.14 - 08.58', 'Pendidikan Agama Islam', 'Eko Saputro, S.Pd.I, M.Pd.'],
      ['08.58 - 09.42', 'Sejarah', 'Kurnia Panggara Putri, S.Pd.'],
      ['09.57 - 11.03', 'Pendidikan Pancasila', 'Ismawati, S.Pd.'],
      ['11.03 - 11.47', 'Bahasa Indonesia', 'Nur Yuliandrianingtyas, S.Pd.'],
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Pelajaran')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: const Color(0xFF598BC0),
              borderRadius: BorderRadius.circular(16)),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SMK N 1 Bukateja',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 5),
                Text('XI RPL | Semester Gasal 2026/2027',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 12),
                Text('Kamis, 05 November',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ]),
        ),
        const SizedBox(height: 18),
        ...lessons.map((lesson) => Card(
              elevation: 0,
              child: ListTile(
                leading:
                    const Icon(Icons.access_time, color: Color(0xFF598BC0)),
                title: Text(lesson[1],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${lesson[0]}\n${lesson[2]}'),
                isThreeLine: true,
              ),
            )),
      ]),
    );
  }
}
