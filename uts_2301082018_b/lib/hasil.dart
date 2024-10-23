import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String kode;
  final String namaPeminjam;
  final String kodePeminjaman;
  final String kodeNasabah;
  final String namaNasabah;
  final String jumlahPinjaman;
  final String lamaPinjaman;
  final String tanggal;

  const ResultScreen({
    Key? key,
    required this.kode,
    required this.namaPeminjam,
    required this.kodePeminjaman,
    required this.kodeNasabah,
    required this.namaNasabah,
    required this.jumlahPinjaman,
    required this.lamaPinjaman,
    required this.tanggal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double jumlahPinjamanParsed = double.parse(jumlahPinjaman);
    final int lamaPinjamanParsed = int.parse(lamaPinjaman);

    final double angsuranPokok = jumlahPinjamanParsed / lamaPinjamanParsed;
    final double bunga = jumlahPinjamanParsed * 0.12;
    final double angsuranBulan = bunga + angsuranPokok;
    final double totalHutang = jumlahPinjamanParsed + bunga;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Perhitungan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInfoRow('Kode', kode),
          _buildInfoRow('Nama Peminjam', namaPeminjam),
          _buildInfoRow('Kode Peminjaman', kodePeminjaman),
          _buildInfoRow('Tanggal', tanggal),
          _buildInfoRow('Kode Nasabah', kodeNasabah),
          _buildInfoRow('Nama Nasabah', namaNasabah),
          _buildInfoRow('Jumlah Pinjaman', 'Rp $jumlahPinjaman'),
          _buildInfoRow('Lama Pinjaman', '$lamaPinjamanParsed bulan'),
          _buildInfoRow('Angsuran Pokok', 'Rp ${angsuranPokok.toStringAsFixed(0)}'),
          _buildInfoRow('Bunga', 'Rp ${bunga.toStringAsFixed(0)}'),
          const SizedBox(height: 16),
          _buildInfoRow('Angsuran Bulan', 'Rp ${angsuranBulan.toStringAsFixed(0)}'),
          _buildInfoRow('Total Hutang', 'Rp ${totalHutang.toStringAsFixed(0)}', isBold: true),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Kembali',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
