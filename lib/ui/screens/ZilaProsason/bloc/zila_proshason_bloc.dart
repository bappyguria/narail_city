import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narail_city/ui/screens/ZilaProsason/bloc/zila_proshasan_event.dart';
import 'package:narail_city/ui/screens/ZilaProsason/bloc/zila_proshason_state.dart';

import '../../../../repositories/zila_proshason_repository.dart';

class ZilaProshasonBloc extends Bloc<ZilaProshasonEvent, ZilaProshasonState> {
  final Repository repository;

  ZilaProshasonBloc({required this.repository}) : super(ZilaProshasonInitial()) {
    on<LoadOfficialsEvent>((event, emit) async {
      emit(ZilaProshasonLoading());
      try {
        print('ButtonClicked');
        final officials = await repository.fetchOfficials();
        emit(ZilaProshasonLoaded(officials));
        print(officials);
      } catch (e) {
        emit(ZilaProshasonError('ডেটা লোড করতে সমস্যা হয়েছে'));
      }
    });
  }
}
