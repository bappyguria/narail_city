class Official {
  final String name;
  final String designation;
  final String phone;
  final String address;
  final String image;

  Official({
    required this.name,
    required this.designation,
    required this.phone,
    required this.address,
    required this.image,
  });

  factory Official.fromMap(Map<String, dynamic> map) {
    return Official(
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
