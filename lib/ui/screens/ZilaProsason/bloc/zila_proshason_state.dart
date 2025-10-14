// States
import '../../../../models/official_model.dart';

abstract class ZilaProshasonState {}
class ZilaProshasonInitial extends ZilaProshasonState {}
class ZilaProshasonLoading extends ZilaProshasonState {}
class ZilaProshasonLoaded extends ZilaProshasonState {
  final List<ZilaProsasonModel> officials;
  ZilaProshasonLoaded(this.officials);
}
class ZilaProshasonError extends ZilaProshasonState {
  final String message;
  ZilaProshasonError(this.message);
}