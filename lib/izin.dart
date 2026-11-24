import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'widgets.dart';

class PermitScreen extends StatefulWidget {
  const PermitScreen({super.key});
  @override
  State<PermitScreen> createState() => _PermitScreenState();
}

class _PermitScreenState extends State<PermitScreen> {
  final type = TextEditingController(),
      start = TextEditingController(),
      end = TextEditingController(),
      reason = TextEditingController(),
      attachment = TextEditingController();
  @override
  void dispose() {
    type.dispose();
    start.dispose();
    end.dispose();
    reason.dispose();
    attachment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Buat Izin')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        CardPanel(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          formField('Jenis izin', type, 'Masukkan jenis izin'),
          formField('Mulai izin', start, 'Masukkan tanggal / jam'),
          formField('Selesai izin', end, 'Masukkan tanggal / jam'),
          formField('Alasan', reason, 'Tuliskan alasan izin secara detail',
              lines: 3),
          formField(
              'Lampiran izin', attachment, 'Nama file lampiran (opsional)'),
          const PlaceholderImage('lampiran_izin.png', height: 90),
          const SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (type.text.trim().isEmpty ||
                        reason.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Jenis izin dan alasan wajib diisi.')));
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: const Icon(Icons.check_circle,
                                    color: Colors.green, size: 55),
                                content: const Text('Izin Berhasil Terkirim',
                                    textAlign: TextAlign.center),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Kembali'))
                                ],
                              ));
                    }
                  },
                  child: const Text('Submit'))),
        ]))
      ]));
}
