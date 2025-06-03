class Mahasiswa {
  final String? key;
  final String npm;
  final String nama;
  final String visi;

  Mahasiswa({
    this.key,
    required this.npm,
    required this.nama,
    required this.visi,
  });

// Untuk memaping npm, nama, visi
  Map<String, dynamic> toJson() => {
    'npm' : npm,
    'nama' : nama,
    'visi' : visi,
  };
  
  factory Mahasiswa.fromJson(Map<String, dynamic> json, String key) => Mahasiswa(
    key : key,
    npm : json['npm'] ?? '',
    nama : json['nama'] ?? '',
    visi : json['visi'] ?? '',
  );
}
