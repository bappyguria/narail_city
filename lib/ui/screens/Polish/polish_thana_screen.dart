import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narail_city/ui/screens/Polish/bloc/polish_thana_bloc.dart';
import 'package:narail_city/ui/screens/Polish/bloc/polish_thana_state.dart';

import '../../../repositories/zila_proshason_repository.dart';
import 'bloc/polish_thana_event.dart';

class PolishThanaScreen extends StatefulWidget {
  const PolishThanaScreen({super.key});

  @override
  State<PolishThanaScreen> createState() => _PolishThanaScreenState();
}

class _PolishThanaScreenState extends State<PolishThanaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => PolishThanaBloc(repository: Repository(
        firestore: FirebaseFirestore.instance))..add(LodedPolishThanaList()),child: Scaffold(
      body: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            'জেলা প্রশাসন',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PolishThanaBloc, PolishThanaState>(
          builder: (context, state) {
            if (state is PolishThanaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PolishThanaLoaded) {
              final officials = state.polishData;
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: officials.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 8),
                itemBuilder: (context, index){
                  final polishData = officials[index];
                  return ListTile(
                    title: Text(polishData.JobTitle),
                    subtitle: Text(polishData.address),
                    trailing: Text(polishData.mobile),
                  );
                }
              );
            } else if (state is PolishThanaError) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
    )));
  }
}
