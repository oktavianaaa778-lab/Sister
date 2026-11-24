import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'widgets.dart';
import 'presensi.dart';
import 'jadwal.dart';
import 'profil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('BROTHER'), actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen())),
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () => showDateDialog(context),
              icon: const Icon(Icons.calendar_month))
        ]),
        body: ListView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 26),
            children: [
              StudentHeader(),
              const SizedBox(height: 12),
              CardPanel(
                  child: Row(children: [
                const Icon(Icons.calendar_month, color: primary, size: 28),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text('Kamis, 05 November',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                const Icon(Icons.keyboard_arrow_down, color: primary),
              ])),
              const SizedBox(height: 10),
              CardPanel(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Informasi Umum',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: darkBlue)),
                    const SizedBox(height: 7),
                    const InfoRow(Icons.campaign, '05 November 2026',
                        'Hari ini kegiatan pembelajaran berlangsung'),
                    const SizedBox(height: 8),
                    const InfoRow(
                        Icons.info_outline,
                        'Informasi Agenda Hari ini',
                        'Cek jadwal pembelajaran dan presensi'),
                  ])),
              const SizedBox(height: 10),
              CardPanel(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Presensi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: darkBlue)),
                    const SizedBox(height: 9),
                    const AttendanceStatusRow(Icons.login, 'Presensi Masuk',
                        '06.16', 'Tepat Waktu', Colors.green),
                    const Divider(height: 18),
                    const AttendanceStatusRow(Icons.logout, 'Presensi Pulang',
                        '--:--', 'Belum Presensi', Colors.red),
                    const SizedBox(height: 8),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const FaceAttendanceScreen())),
                            child: const Text('Presensi Wajah'))),
                  ])),
              const SizedBox(height: 10),
              CardPanel(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Jadwal Pelajaran',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: darkBlue)),
                    const SizedBox(height: 8),
                    lesson('08.44 - 09.21', 'SEJARAH',
                        'KURNIA PANGGARA PUTRI, S.Pd'),
                    const Divider(),
                    lesson('09.57 - 11.00', 'PENDIDIKAN PANCASILA',
                        'ISMAWATI, S.Pd'),
                    const Divider(),
                    lesson(
                        '11.00 - 11.40', 'BAHASA INDONESIA', 'NUR YULI, S.Pd'),
                  ])),
            ]),
      );
}

void showDateDialog(BuildContext context) => showDialog(
    context: context,
    builder: (_) => AlertDialog(
            title: const Text('Tanggal'),
            content: const Text('Kamis, 05 November 2026'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'))
            ]));
