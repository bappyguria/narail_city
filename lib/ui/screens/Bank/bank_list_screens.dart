import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narail_city/repositories/zila_proshason_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/bank_data.dart';
import 'bloc/bank_list_bloc.dart';
import 'bloc/bank_list_event.dart';
import 'bloc/bank_list_state.dart';


class BankListScreens extends StatelessWidget {
  const BankListScreens({super.key});

  // ফোন কল করার ফাংশন
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
    return BlocProvider(
      create: (_) => BankListBloc(
        repository: Repository(firestore: FirebaseFirestore.instance),
      )..add(onBankList()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            'ব্যাংক তালিকা',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BankListBloc, BankListState>(
          builder: (context, state) {
            if (state is BankListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BankListLoaded) {
              final banks = state.bankList;
              if (banks.isEmpty) {
                return const Center(child: Text('কোনো তথ্য পাওয়া যায়নি'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: banks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final bank = banks[index];
                  return BankCard(bank: bank, onCall: () => _callNumber(bank.mobile));
                },
              );
            } else if (state is BankListError) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class BankCard extends StatelessWidget {
  final BankData bank;
  final VoidCallback onCall;

  const BankCard({super.key, required this.bank, required this.onCall});

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
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.teal.shade100,
                child: const Icon(Icons.account_balance, color: Colors.teal, size: 28),
              ),
              title: Text(
                bank.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(bank.designation, style: const TextStyle(color: Colors.black87)),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.black54),
SizedBox(width: 10,),
                      Text(bank.address, style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                  Text(bank.mobile, style: const TextStyle(color: Colors.black87)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: onCall,
              ),
            ),
            const Divider(height: 1, color: Colors.grey),

          ],
        ),
      ),
    );
  }
}
