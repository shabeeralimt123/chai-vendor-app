part of 'acceptreject_cubit.dart';

@immutable
abstract class AcceptrejectState {}

class AcceptrejectInitial extends AcceptrejectState {}
class AcceptrejectLoaded extends AcceptrejectState{
  final AcceptRejectModel acceptreject;
  AcceptrejectLoaded(this.acceptreject);

}
class AcceptrejectError extends AcceptrejectState {

}
