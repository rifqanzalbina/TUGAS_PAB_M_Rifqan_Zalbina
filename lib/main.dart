import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'models/mahasiswa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 2,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('mahasiswa');
  final List<Mahasiswa> _mahasiswaList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _database.onValue.listen((event) {
      setState(() {
        _isLoading = false;
        _mahasiswaList.clear();
        final dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          final data = dataSnapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            final mahasiswaData = Map<String, dynamic>.from(value as Map);
            _mahasiswaList.add(Mahasiswa.fromJson(mahasiswaData, key));
          });
        }
      });
    }, onError: (error) {
      debugPrint('Error: $error');
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _addMahasiswa(String npm, String nama, String visi) {
    final newMahasiswa = Mahasiswa(npm: npm, nama: nama, visi: visi);
    _database.push().set(newMahasiswa.toJson());
  }

  void _deleteMahasiswa(String key) {
    _database.child(key).remove();
  }

  void _showInputDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final npmController = TextEditingController();
    final namaController = TextEditingController();
    final visiController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Mahasiswa'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: npmController,
                    decoration: InputDecoration(
                      labelText: 'NPM',
                      prefixIcon: const Icon(Icons.confirmation_number),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) => value!.isEmpty ? 'NPM tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: visiController,
                    decoration: InputDecoration(
                      labelText: 'Visi (5 tahun)',
                      prefixIcon: const Icon(Icons.visibility),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Visi tidak boleh kosong' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BATAL'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _addMahasiswa(npmController.text, namaController.text, visiController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('SIMPAN'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata Mahasiswa'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mahasiswaList.isEmpty
              ? const Center(child: Text('Belum ada data mahasiswa'))
              : ListView.separated(
                  itemCount: _mahasiswaList.length,
                  separatorBuilder: (context, index) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final mahasiswa = _mahasiswaList[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        title: Text(
                          mahasiswa.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('NPM: ${mahasiswa.npm}', style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 2),
                            Text('Visi: ${mahasiswa.visi}', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteMahasiswa(mahasiswa.key!),
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInputDialog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
