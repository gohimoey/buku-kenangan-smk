// Model kenangan lengkap
class Memory {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final String classNumber;  // 10, 11, 12
  final String major;        // TKJ, TKR, PBS
  final String address;      // alamat kontak
  final String phoneNumber;   // nomor telepon

  Memory({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath = '',
    required this.date,
    required this.classNumber,
    required this.major,
    this.address = '',
    this.phoneNumber = '',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'imagePath': imagePath,
        'date': date.toIso8601String(),
        'classNumber': classNumber,
        'major': major,
        'address': address,
        'phoneNumber': phoneNumber,
      };

  factory Memory.fromMap(Map<String, dynamic> m) => Memory(
        id: m['id'],
        title: m['title'],
        description: m['description'],
        imagePath: m['imagePath'] ?? '',
        date: DateTime.parse(m['date']),
        classNumber: m['classNumber'] ?? '11',
        major: m['major'] ?? 'TKJ',
        address: m['address'] ?? '',
        phoneNumber: m['phoneNumber'] ?? '',
      );
}