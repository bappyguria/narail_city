import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/zila_proshason_bloc.dart';
import '../../models/official_model.dart';
import '../../repositories/zila_proshason_repository.dart';

class ZilaProshasonScreen extends StatelessWidget {
  const ZilaProshasonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ZilaProshasonBloc(
          repository: ZilaProshasonRepository(
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
      ),
    );
  }
}

class OfficialCard extends StatelessWidget {
  final Official official;
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
              leading: Image.network(
                'https://png.pngtree.com/png-vector/20240628/ourmid/pngtree-man-silhouette-in-black-and-white-icon-vector-png-image_7061098.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 40),
                ),
              ),
              title: Text(
                official.name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,color: Colors.teal),
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
