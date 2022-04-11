part of 'neworder_cubit.dart';

@immutable
abstract class NeworderState {}

class NeworderInitial extends NeworderState {}
class NeworderLoaded extends NeworderState{
  final NewOrders newOrders;
  NeworderLoaded(this.newOrders);

}
class NeworderError extends NeworderState {

}
