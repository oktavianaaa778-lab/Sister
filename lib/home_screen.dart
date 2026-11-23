import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'jadwal_screen.dart';
import 'izin_screen.dart';
import 'riwayat_screen.dart';
import 'profil_screen.dart';

class HomeScreen extends StatefulWidget {
  final String studentName;
  const HomeScreen({super.key, required this.studentName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String? masukTime;
  String? pulangTime;
  final picker = ImagePicker();

  Future<void> takeAttendance(bool isMasuk) async {
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (!mounted) return;
    if (photo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengambilan foto dibatalkan')),
      );
      return;
    }
    final now = TimeOfDay.now().format(context);
    setState(() {
      if (isMasuk) {
        masukTime = now;
      } else {
        pulangTime = now;
      }
    });
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 54),
        title: const Text('Presensi Berhasil!'),
        content: Text(
          isMasuk
              ? 'Presensi masuk tercatat pukul $now.'
              : 'Presensi pulang tercatat pukul $now.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kembali'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      const RiwayatScreen(),
      const JadwalScreen(),
      const ProfilScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) => setState(() => selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    final name = widget.studentName.toUpperCase();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 29,
              backgroundColor: Color(0xFFE3EEF8),
              child: Icon(Icons.person, color: Color(0xFF598BC0), size: 34),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hi,', style: TextStyle(color: Colors.blueGrey)),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    '9240 | XI RPL | SMK N 1 Bukateja',
                    style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF598BC0),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summary('05/11', 'Tanggal'),
              _summary(masukTime ?? '06.00', 'Masuk'),
              _summary(pulangTime ?? '14.30', 'Pulang'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Presensi Hari Ini',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _attendanceTile(
          'Presensi Masuk',
          masukTime ?? '--:--',
          masukTime == null ? 'Belum Presensi' : 'Tercatat',
        ),
        const SizedBox(height: 10),
        _attendanceTile(
          'Presensi Pulang',
          pulangTime ?? '--:--',
          pulangTime == null ? 'Belum Presensi' : 'Tercatat',
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Menu Utama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => setState(() => selectedIndex = 2),
              child: const Text('Lihat jadwal'),
            ),
          ],
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: [
            _menu(
              Icons.face_retouching_natural,
              'Presensi Wajah',
              () => takeAttendance(true),
            ),
            _menu(
              Icons.assignment_outlined,
              'Pengajuan Izin',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IzinScreen()),
              ),
            ),
            _menu(
              Icons.history,
              'Riwayat',
              () => setState(() => selectedIndex = 1),
            ),
            _menu(
              Icons.person_outline,
              'Data Diri',
              () => setState(() => selectedIndex = 3),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Sejarah Presensi',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.check, color: Colors.green),
            ),
            title: const Text('Presensi Masuk'),
            subtitle: Text(masukTime ?? 'Belum ada presensi masuk'),
            trailing: const Text(
              'Hari ini',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _summary(String value, String label) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      );

  Widget _attendanceTile(String title, String time, String status) => Card(
        elevation: 0,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFE3EEF8),
            child: Icon(Icons.fingerprint, color: Color(0xFF598BC0)),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(time),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F3E8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: const TextStyle(fontSize: 10, color: Colors.green),
            ),
          ),
        ),
      );

  Widget _menu(IconData icon, String title, VoidCallback onTap) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8EDF3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: const Color(0xFF598BC0)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
}
