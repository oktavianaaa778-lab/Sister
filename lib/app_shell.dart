import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'widgets.dart';
import 'home.dart';
import 'jadwal.dart';
import 'izin.dart';
import 'profil.dart';
import 'login.dart';
import 'presensi.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selected = 0;
  late final List<Widget> pages = [
    const HomeScreen(),
    const ScheduleScreen(),
    const PermitScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: selected, children: pages),
        bottomNavigationBar: NavigationBar(
          height: 68,
          backgroundColor: Colors.white,
          indicatorColor: lightBlue,
          selectedIndex: selected,
          onDestinationSelected: (i) => setState(() => selected = i),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.school_outlined), label: 'Jadwal'),
            NavigationDestination(
                icon: Icon(Icons.edit_note_outlined), label: 'Izin'),
            NavigationDestination(
                icon: Icon(Icons.person_outline), label: 'Profil'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FaceAttendanceScreen())),
          child: const Icon(Icons.face_retouching_natural, size: 27),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
