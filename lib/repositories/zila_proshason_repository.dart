import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/official_model.dart';

class ZilaProshasonRepository {
  final FirebaseFirestore firestore;

  ZilaProshasonRepository({required this.firestore});

  Future<List<Official>> fetchOfficials() async {
    final doc = await firestore
        .collection('NarailDistrict')
        .doc('ZilaProshason')
        .get();

    if (!doc.exists) return [];

    final List officialsRaw = doc.get('officials') as List;
    return officialsRaw.map((e) => Official.fromMap(e)).toList();
  }
}
