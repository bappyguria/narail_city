import 'package:narail_city/models/bank_data.dart';

abstract class BankListState{}
class BankListInitial extends BankListState{}
class BankListLoading extends BankListState{}
class BankListLoaded extends BankListState{
  final List<BankData> bankList;
  BankListLoaded(this.bankList);
}
class BankListError extends BankListState{
  String errorMessage;
  BankListError(this.errorMessage);

}