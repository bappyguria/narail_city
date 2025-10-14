class PolishData {

  final String JobTitle;
  final String address;
  final String mobile;

  PolishData({

    required this.JobTitle,
    required this.address,
    required this.mobile,
  });

  factory PolishData.fromMap(Map<String, dynamic> map) {
    return PolishData(
      JobTitle: map['JobTitle'],
      address: map['address'],
      mobile: map['mobile'],
    );
  }
}
