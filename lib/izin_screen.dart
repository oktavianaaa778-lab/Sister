import 'package:flutter/material.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});

  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  String jenis = 'Sakit';
  DateTime? mulai;
  DateTime? selesai;
  final alasan = TextEditingController();

  Future<void> pilihTanggal(bool isMulai) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (date != null)
      setState(() {
        if (isMulai) {
          mulai = date;
        } else {
          selesai = date;
        }
      });
  }

  @override
  void dispose() {
    alasan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Buat Izin'),
          leading: BackButton(onPressed: () => Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Jenis izin', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: jenis,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Masukan jenis izin'),
          items: ['Sakit', 'Izin Keluarga', 'Keperluan Lain']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => jenis = v ?? 'Sakit'),
        ),
        const SizedBox(height: 18),
        const Text('Mulai izin', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => pilihTanggal(true),
          icon: const Icon(Icons.calendar_today),
          label: Text(mulai == null
              ? 'Masukan Tanggal'
              : '${mulai!.day}/${mulai!.month}/${mulai!.year}'),
        ),
        const SizedBox(height: 18),
        const Text('Selesai izin',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => pilihTanggal(false),
          icon: const Icon(Icons.calendar_today),
          label: Text(selesai == null
              ? 'Masukan Tanggal'
              : '${selesai!.day}/${selesai!.month}/${selesai!.year}'),
        ),
        const SizedBox(height: 18),
        const Text('Alasan', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: alasan,
          maxLines: 4,
          decoration: InputDecoration(
              hintText: 'Tuliskan alasan izin secara detail',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        const SizedBox(height: 28),
        SizedBox(
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF598BC0)),
              onPressed: () {
                if (mulai == null ||
                    selesai == null ||
                    alasan.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Lengkapi tanggal dan alasan izin')));
                  return;
                }
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green, size: 52),
                          title: const Text('Izin Berhasil Terkirim'),
                          content: const Text(
                              'Pengajuan izin berhasil dibuat pada demo aplikasi.'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Kembali'))
                          ],
                        ));
              },
              child: const Text('Submit'),
            )),
      ]),
    );
  }
}
