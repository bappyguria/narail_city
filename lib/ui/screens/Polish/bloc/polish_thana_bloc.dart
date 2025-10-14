import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:narail_city/ui/screens/Polish/bloc/polish_thana_event.dart';
import 'package:narail_city/ui/screens/Polish/bloc/polish_thana_state.dart';

import '../../../../repositories/zila_proshason_repository.dart';


class PolishThanaBloc extends Bloc<PolishThanaEvent, PolishThanaState> {
  final Repository repository;
  PolishThanaBloc({required this.repository}) : super(PolishThanaInitial()) {
    on<LodedPolishThanaList>((event, emit) async {
        emit(PolishThanaLoading());
        try{
          final polishThanaList = await repository.fetchPolishData();
          emit(PolishThanaLoaded(polishThanaList));
          print(polishThanaList);
        }catch(e){
          emit(PolishThanaError(e.toString()));
        }
    });
  }
}
