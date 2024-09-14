class Sender {
  final String name;
  final String key;

  Sender({required this.name, required this.key});

  factory Sender.fromMap(Map<String, dynamic> map) {
    return Sender(
      name: map['sender'],
      key: map['sender_key'],
    );
  }
}