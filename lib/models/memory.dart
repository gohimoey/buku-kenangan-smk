// Model data untuk kenangan

class Memory {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final String qrData;

  Memory({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.qrData,
  });

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      date: DateTime.parse(map['date']),
      qrData: map['qrData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'date': date.toIso8601String(),
      'qrData': qrData,
    };
  }
}