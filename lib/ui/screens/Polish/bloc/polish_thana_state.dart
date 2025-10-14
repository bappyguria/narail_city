import 'package:narail_city/models/polish_data.dart';

abstract class PolishThanaState{}
class PolishThanaInitial extends PolishThanaState{}
class PolishThanaLoading extends PolishThanaState{}
class PolishThanaLoaded extends PolishThanaState{
final List<PolishData> polishData;
PolishThanaLoaded(this.polishData);
}
class PolishThanaError extends PolishThanaState{
  String errorMessage;

  PolishThanaError(this.errorMessage);
}