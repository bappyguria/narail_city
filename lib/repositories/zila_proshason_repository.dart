import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:narail_city/models/bank_data.dart';
import 'package:narail_city/models/polish_data.dart';
import '../models/official_model.dart';

class Repository {
  final FirebaseFirestore firestore;

  Repository({required this.firestore});

  Future<List<ZilaProsasonModel>> fetchOfficials() async {
    final doc = await firestore
        .collection('NarailDistrict')
        .doc('ZilaProshason')
        .get();

    if (!doc.exists) return [];

    final List officialsRaw = doc.get('officials') as List;
    return officialsRaw.map((e) => ZilaProsasonModel.fromMap(e)).toList();
  }

  Future<List<PolishData>> fetchPolishData() async {
    final doc = await firestore.collection('NarailDistrict').doc('PolishStashon').get();
    if (!doc.exists) return [];
    final List PolishStashonList = doc.get('PolishStashonList') as List;
    print(PolishStashonList);
    return PolishStashonList.map((e) => PolishData.fromMap(e)).toList();
  }

  Future<List<BankData>> fetchBankData()async{
    final doc = await firestore.collection('NarailDistrict').doc('Bank').get();
    if(!doc.exists) return [];
    final List bankList = doc.get('BankList') as List;
    print(bankList);
    return bankList.map((e) => BankData.fromMap(e)).toList();
  }
}
