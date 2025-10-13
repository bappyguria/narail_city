import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/official_model.dart';
import '../repositories/zila_proshason_repository.dart';

// Events
abstract class ZilaProshasonEvent {}
class LoadOfficialsEvent extends ZilaProshasonEvent {}

// States
abstract class ZilaProshasonState {}
class ZilaProshasonInitial extends ZilaProshasonState {}
class ZilaProshasonLoading extends ZilaProshasonState {}
class ZilaProshasonLoaded extends ZilaProshasonState {
  final List<Official> officials;
  ZilaProshasonLoaded(this.officials);
}
class ZilaProshasonError extends ZilaProshasonState {
  final String message;
  ZilaProshasonError(this.message);
}

// BLoC
class ZilaProshasonBloc extends Bloc<ZilaProshasonEvent, ZilaProshasonState> {
  final ZilaProshasonRepository repository;

  ZilaProshasonBloc({required this.repository}) : super(ZilaProshasonInitial()) {
    on<LoadOfficialsEvent>((event, emit) async {
      emit(ZilaProshasonLoading());
      try {
        final officials = await repository.fetchOfficials();
        emit(ZilaProshasonLoaded(officials));
      } catch (e) {
        emit(ZilaProshasonError('ডেটা লোড করতে সমস্যা হয়েছে'));
      }
    });
  }
}
