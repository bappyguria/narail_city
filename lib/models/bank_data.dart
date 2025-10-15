class BankData {
  final String name;
  final String designation;
  final String mobile;
  final String address;

  BankData({
    required this.name,
    required this.designation,
    required this.mobile,
    required this.address,
  });

  factory BankData.fromMap(Map<String, dynamic> map) {
    return BankData(
      name: map['name'] ?? '',
      designation: map['description'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
