// lib/models/contact.dart
class Contact {
  int? id; // O ID pode ser nulo antes de ser salvo no banco
  String name;
  String phone;
  String email;

  // Construtor com parâmetros nomeados
  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  // Método para converter o objeto Contact em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,       // O ID pode ser null antes de ser salvo
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // Método de fábrica para criar um Contact a partir de um mapa (do banco de dados)
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int?,  // Garantindo que o 'id' seja tratado como int? (nullable)
      name: map['name'] ?? '', // Garantir que 'name' nunca seja null
      phone: map['phone'] ?? '', // Garantir que 'phone' nunca seja null
      email: map['email'] ?? '', // Garantir que 'email' nunca seja null
    );
  }
}
