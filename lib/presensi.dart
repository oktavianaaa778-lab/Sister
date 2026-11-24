import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_pkg;
import 'widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'izin.dart';

class FaceRegistrationScreen extends StatelessWidget {
  const FaceRegistrationScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Registrasi Wajah')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        CardPanel(
            child: Column(children: [
          const PlaceholderImage('foto_presensi.png', height: 240),
          const Text('Registrasi Wajah',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Text('Kamera belum diaktifkan.', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () => showFaceStatus(context, true),
              child: const Text('Gambar')),
          OutlinedButton(
              onPressed: () => showFaceStatus(context, false),
              child: const Text('Simulasi Gagal')),
        ]))
      ]));
}

void showFaceStatus(BuildContext context, bool ok) => showDialog(
    context: context,
    builder: (_) => AlertDialog(
          title: Icon(ok ? Icons.check_circle : Icons.cancel,
              color: ok ? Colors.green : Colors.red, size: 54),
          content: Text(
              ok
                  ? 'Berhasil reset wajah\\nGambar terdaftar .'
                  : 'Wajah sudah terdaftar\\nSilakan reset wajah terlebih dahulu untuk registrasi ulang.',
              textAlign: TextAlign.center),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'))
          ],
        ));

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});
  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  String gps = 'Lokasi belum diperiksa';
  bool loading = false;
  Future<void> fetchLocation() async {
    setState(() => loading = true);
    try {
      final p = await Permission.locationWhenInUse.request();
      if (!p.isGranted) {
        setState(() => gps = 'Izin lokasi ditolak.');
        if (p.isPermanentlyDenied) await openAppSettings();
        return;
      }
      final loc = location_pkg.Location();
      var enabled = await loc.serviceEnabled();
      if (!enabled) enabled = await loc.requestService();
      if (!enabled) {
        setState(() => gps = 'GPS belum aktif.');
        return;
      }
      var lp = await loc.hasPermission();
      if (lp == location_pkg.PermissionStatus.denied)
        lp = await loc.requestPermission();
      if (lp != location_pkg.PermissionStatus.granted &&
          lp != location_pkg.PermissionStatus.grantedLimited) {
        setState(() => gps = 'Izin lokasi belum diberikan.');
        return;
      }
      final position = await loc.getLocation();
      setState(() =>
          gps = 'Lat: ${position.latitude}\\nLong: ${position.longitude}');
    } catch (_) {
      setState(() => gps = 'Tidak bisa mendapatkan lokasi. Coba lagi.');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF17222C),
        appBar: AppBar(
            backgroundColor: const Color(0xFF263541),
            title: const Text('Presensi Wajah'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context))),
        body: Stack(children: [
          Positioned.fill(
              child: PlaceholderImage('pp.png', height: double.infinity)),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .72),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(22))),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                      'Pastikan wajah terlihat jelas tidak menggunakan masker/topeng',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 12),
                  Text(gps,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FacePreviewScreen())),
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white)),
                            child: const Text('Ambil Gambar'))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: FilledButton(
                            onPressed: loading ? null : fetchLocation,
                            style: FilledButton.styleFrom(
                                backgroundColor: primary),
                            child: Text(loading
                                ? 'Mencari lokasi...'
                                : 'Deteksi Lokasi'))),
                  ]),
                ]),
              )),
        ]),
      );
}

class FacePreviewScreen extends StatelessWidget {
  const FacePreviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Presensi Wajah')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CardPanel(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const PlaceholderImage('foto_presensi.png', height: 260),
              const SizedBox(height: 10),
              const Text('Foto contoh',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Pastikan gambar sesuai. Kamera belum digunakan.'),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ambil Ulang'))),
                const SizedBox(width: 8),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AttendanceDetailScreen())),
                  child: const Text('Gunakan Foto'),
                )),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}

class AttendanceDetailScreen extends StatelessWidget {
  const AttendanceDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Presensi')),
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: CardPanel(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Detail Presensi',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const PlaceholderImage('foto_presensi.png', height: 160, width: 160),
          profile('Nama', 'Oktaviana Syifa’ul Aula'),
          profile('Tanggal', 'Kamis, 05 November'),
          profile('Waktu', '06.16 WIB'),
          profile('Status', 'Tepat Waktu'),
          profile('Sekolah', 'SMK N 1 Bukateja'),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ulang'))),
            const SizedBox(width: 8),
            Expanded(
                child: ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AttendanceSuccessScreen())),
              child: const Text('Gunakan'),
            )),
          ]),
        ])),
      )),
    );
  }
}

class AttendanceSuccessScreen extends StatelessWidget {
  const AttendanceSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Presensi Berhasil!')),
      body: Center(
          child: CardPanel(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.verified, color: primary, size: 70),
        const Text('Presensi Berhasil!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 10),
        const PlaceholderImage('foto_presensi.png', height: 200, width: 180),
        const Text('Oktaviana Syifa’ul Aula'),
        const Text('Kamis, 05 November • 06.16 WIB'),
        const SizedBox(height: 12),
        ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('Tutup')),
      ]))));
}
