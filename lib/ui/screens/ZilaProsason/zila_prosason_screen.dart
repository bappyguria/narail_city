import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/zila_proshasan_event.dart';
import 'bloc/zila_proshason_bloc.dart';
import '../../../models/official_model.dart';
import '../../../repositories/zila_proshason_repository.dart';
import 'bloc/zila_proshason_state.dart';

class ZilaProshasonScreen extends StatelessWidget {
  const ZilaProshasonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ZilaProshasonBloc(
          repository: Repository(
              firestore: FirebaseFirestore.instance))
        ..add(LoadOfficialsEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            'জেলা প্রশাসন',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ZilaProshasonBloc, ZilaProshasonState>(
          builder: (context, state) {
            if (state is ZilaProshasonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ZilaProshasonLoaded) {
              final officials = state.officials;
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: officials.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 8),
                itemBuilder: (context, index) =>
                    OfficialCard(official: officials[index]),
              );
            } else if (state is ZilaProshasonError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),

        // ✅ Floating Button to Add New Official
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddOfficialDialog(),
            );
          },
        ),
      ),
    );
  }
}

class OfficialCard extends StatelessWidget {
  final ZilaProsasonModel official;
  const OfficialCard({super.key, required this.official});

  // Function to call number
  void _callNumber(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                official.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    official.designation,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text('${official.address}',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _callNumber(official.phone),
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  official.phone,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddOfficialDialog extends StatefulWidget {
  const AddOfficialDialog({super.key});

  @override
  State<AddOfficialDialog> createState() => _AddOfficialDialogState();
}

class _AddOfficialDialogState extends State<AddOfficialDialog> {
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addOfficial() async {
    if (_nameController.text.isEmpty ||
        _designationController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("সব ঘর পূরণ করুন")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final docRef = FirebaseFirestore.instance
          .collection('NarailDistrict')
          .doc('ZilaProshason');

      await docRef.update({
        "officials": FieldValue.arrayUnion([
          {
            "name": _nameController.text,
            "designation": _designationController.text,
            "phone": _phoneController.text,
            "address": _addressController.text,
            "imageUrl": _imageUrlController.text.isEmpty
                ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                : _imageUrlController.text,
          }
        ])
      });

      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("সফলভাবে যুক্ত হয়েছে ✅")),
      );
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("নতুন কর্মকর্তা যোগ করুন"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'নাম')),
            TextField(controller: _designationController, decoration: const InputDecoration(labelText: 'পদবি')),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'ফোন')),
            TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'ঠিকানা')),
            TextField(controller: _imageUrlController, decoration: const InputDecoration(labelText: 'ছবির লিংক (ঐচ্ছিক)')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("বাতিল")),
        ElevatedButton(
          onPressed: _isLoading ? null : _addOfficial,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          )
              : const Text("সংরক্ষণ করুন", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
