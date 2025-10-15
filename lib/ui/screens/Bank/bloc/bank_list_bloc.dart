import 'package:bloc/bloc.dart';

import '../../../../repositories/zila_proshason_repository.dart';
import 'bank_list_event.dart';
import 'bank_list_state.dart';

class BankListBloc extends Bloc<BankListEvent, BankListState> {
  final Repository repository;
  BankListBloc({required this.repository}) : super(BankListInitial()) {
    on<onBankList>((event, emit) async {
      emit(BankListLoading());
      try{
        final bankList = await repository.fetchBankData();
        emit(BankListLoaded(bankList));
      }catch(e){
        emit(BankListError(e.toString()));
      }
    });
  }
}
