import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'widgets.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Jadwal Pelajaran')),
      body: ListView(padding: const EdgeInsets.all(15), children: [
        CardPanel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Kamis, 05 November',
              style: TextStyle(fontWeight: FontWeight.bold)),
          lesson('08.44 - 09.21', 'SEJARAH', 'Kurnia Panggara Putri, S.Pd'),
          const Divider(),
          lesson('09.57 - 11.00', 'PENDIDIKAN PANCASILA', 'Ismawati, S.Pd'),
          const Divider(),
          lesson('11.00 - 11.40', 'BAHASA INDONESIA', 'Nur Yuli, S.Pd'),
          const Divider(),
          lesson('11.40 - 12.20', 'MATEMATIKA', 'Guru Mata Pelajaran')
        ]))
      ]));
}
