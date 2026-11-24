import 'package:flutter/material.dart';

const Color primary = Color(0xFF5B91C6);
const Color darkBlue = Color(0xFF294866);
const Color lightBlue = Color(0xFFE5F1FB);

class CardPanel extends StatelessWidget {
  final Widget child;
  const CardPanel({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: .035), blurRadius: 8)
          ]),
      child: child);
}

class PlaceholderImage extends StatelessWidget {
  final String filename;
  final double height;
  final double? width;
  const PlaceholderImage(this.filename,
      {super.key, required this.height, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(
      height: height,
      width: width,
      child: Image.asset('assets/images/pp.png',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
              decoration: BoxDecoration(
                  color: lightBlue,
                  border: Border.all(color: primary.withValues(alpha: .35)),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.image_outlined,
                            color: primary, size: 32),
                        Text(filename,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: darkBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        const Text('Tempat gambar',
                            style: TextStyle(color: Colors.grey, fontSize: 9))
                      ]))))));
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const InfoRow(this.icon, this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, color: primary, size: 22),
        const SizedBox(width: 8),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          Text(subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 10))
        ]))
      ]);
}

class AttendanceStatusRow extends StatelessWidget {
  final IconData icon;
  final String title, time, status;
  final Color statusColor;
  const AttendanceStatusRow(
      this.icon, this.title, this.time, this.status, this.statusColor,
      {super.key});
  @override
  Widget build(BuildContext context) => Row(children: [
        CircleAvatar(
            backgroundColor: lightBlue, child: Icon(icon, color: primary)),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey))
        ])),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
                color: statusColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(20)),
            child: Text(status,
                style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)))
      ]);
}

class StudentHeader extends StatelessWidget {
  const StudentHeader({super.key});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        const PlaceholderImage('foto_profil.png', height: 58, width: 58),
        const SizedBox(width: 10),
        const Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Hi, OKTAVIANA SYIFA’UL AULA',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
          Text('9240 | XI RPL | SMK N 1 Bukateja',
              style: TextStyle(color: Colors.white, fontSize: 10))
        ]))
      ]));
}

Widget lesson(String time, String title, String teacher) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(time,
          style: const TextStyle(
              fontSize: 12, color: primary, fontWeight: FontWeight.bold)),
      const SizedBox(height: 3),
      Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      Text(teacher, style: const TextStyle(fontSize: 11, color: Colors.grey))
    ]);
Widget profile(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 118,
          child: Text(label,
              style: const TextStyle(fontSize: 11, color: Colors.grey))),
      Expanded(
          child: Text(value,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)))
    ]));
Widget formField(String title, TextEditingController c, String hint,
        {int lines = 1}) =>
    Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
              controller: c,
              maxLines: lines,
              decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10)))
        ]));

Widget quickMenu(BuildContext context, String label, String title,
    IconData icon, Widget page) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2 - 43,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: lightBlue, borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Icon(icon, color: darkBlue, size: 28),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ]),
      ),
    ),
  );
}
