class ZilaProsasonModel {
  final String name;
  final String designation;
  final String phone;
  final String address;
  final String image;

  ZilaProsasonModel({
    required this.name,
    required this.designation,
    required this.phone,
    required this.address,
    required this.image,
  });

  factory ZilaProsasonModel.fromMap(Map<String, dynamic> map) {
    return ZilaProsasonModel(
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
