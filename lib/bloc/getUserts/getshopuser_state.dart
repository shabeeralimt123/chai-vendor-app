part of 'getshopuser_cubit.dart';

@immutable
abstract class GetshopuserState {}

class GetshopuserInitial extends GetshopuserState {}
class GetshopuserLoaded extends GetshopuserState{
  final ShopUser shopUser;
  GetshopuserLoaded(this.shopUser);

}
class GetshopuserError extends GetshopuserState {

}

