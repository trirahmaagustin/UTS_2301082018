import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hasil.dart'; // Import hasil.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP Peminjaman',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(
          secondary: Colors.orange,
        ),
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0),
          labelLarge: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const FormEntryScreen(),
    );
  }
}

class FormEntryScreen extends StatefulWidget {
  const FormEntryScreen({Key? key}) : super(key: key);

  @override
  _FormEntryScreenState createState() => _FormEntryScreenState();
}

class _FormEntryScreenState extends State<FormEntryScreen> {
  DateTime? selectedDate;

  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaPeminjamController = TextEditingController();
  final TextEditingController _kodePeminjamanController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _kodeNasabahController = TextEditingController();
  final TextEditingController _namaNasabahController = TextEditingController();
  final TextEditingController _jumlahPinjamanController = TextEditingController();
  final TextEditingController _lamaPinjamanController = TextEditingController();

  @override
  void dispose() {
    _kodeController.dispose();
    _namaPeminjamController.dispose();
    _kodePeminjamanController.dispose();
    _tanggalController.dispose();
    _kodeNasabahController.dispose();
    _namaNasabahController.dispose();
    _jumlahPinjamanController.dispose();
    _lamaPinjamanController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), 
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _tanggalController.text = "${picked.toLocal()}".split(' ')[0]; 
      });
    }
  }

  void _submitForm() {
    if (_kodeController.text.isEmpty || 
        _namaPeminjamController.text.isEmpty || 
        _kodePeminjamanController.text.isEmpty || 
        _kodeNasabahController.text.isEmpty || 
        _namaNasabahController.text.isEmpty || 
        _jumlahPinjamanController.text.isEmpty ||  
        _lamaPinjamanController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan semua data yang diperlukan')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          kode: _kodeController.text,
          namaPeminjam: _namaPeminjamController.text,
          kodePeminjaman: _kodePeminjamanController.text,
          kodeNasabah: _kodeNasabahController.text,
          namaNasabah: _namaNasabahController.text,
          jumlahPinjaman: _jumlahPinjamanController.text,
          lamaPinjaman: _lamaPinjamanController.text,
          tanggal: _tanggalController.text,
        ),
      ),
    );
  }

  void _onDrawerItemTapped(BuildContext context, String item) {
    Navigator.pop(context);
    if (item == 'Home') {
      
    } else if (item == 'About') {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'Form Peminjaman',
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: 60.0,
      ),
      drawer: Drawer( 
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('APP Peminjaman', style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: const Text('Form Peminjaman'),
              onTap: () => _onDrawerItemTapped(context, 'Form Peminjaman'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _kodeController,
                decoration: const InputDecoration(labelText: 'Kode'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _namaPeminjamController,
                decoration: const InputDecoration(labelText: 'Nama Peminjam'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _kodePeminjamanController,
                decoration: const InputDecoration(labelText: 'Kode Peminjaman'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _kodeNasabahController,
                decoration: const InputDecoration(labelText: 'Kode Nasabah'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _namaNasabahController,
                decoration: const InputDecoration(labelText: 'Nama Nasabah'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _jumlahPinjamanController,
                decoration: const InputDecoration(labelText: 'Jumlah Pinjaman'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _lamaPinjamanController,
                decoration: const InputDecoration(labelText: 'Lama Pinjaman'),
              ),
              const SizedBox(height: 12), 
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal ',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 24), 
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Hitung Pinjaman',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
