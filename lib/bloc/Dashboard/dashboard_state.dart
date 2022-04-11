part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}
class DashboardLoaded extends DashboardState{
  final DashBoard dashboard;
DashboardLoaded(this.dashboard);

}
class DashboardError extends DashboardState {

}
