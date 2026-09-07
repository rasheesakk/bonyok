class Contact {
  Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.kategori,
    this.isFavorite = false,
  });

  String name;
  String email;
  String phone;
  String? kategori;
  bool isFavorite;
}