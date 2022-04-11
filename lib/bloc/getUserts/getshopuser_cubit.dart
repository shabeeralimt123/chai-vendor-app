import 'package:bloc/bloc.dart';
import 'package:chai/models/shopUser.dart';
import 'package:chai/repositaries/loginRepositary.dart';
import 'package:meta/meta.dart';

part 'getshopuser_state.dart';

class GetshopuserCubit extends Cubit<GetshopuserState> {
  GetshopuserCubit() : super(GetshopuserInitial());
    getShopUser() async {
  
    emit( GetshopuserInitial());
    try{
    
      final  data = await  AuthenticationRepository().getShopUser();
      emit( GetshopuserLoaded(data));
    }catch(ex){
      print(ex.toString());
      emit( GetshopuserError());
    }
    
  }



}
