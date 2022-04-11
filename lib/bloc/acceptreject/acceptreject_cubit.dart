import 'package:bloc/bloc.dart';
import 'package:chai/models/AcceptRejectModel.dart';
import 'package:chai/repositaries/getDashboardData.dart';
import 'package:meta/meta.dart';

part 'acceptreject_state.dart';


class  AcceptrejectCubit extends Cubit< AcceptrejectState> {
   AcceptrejectCubit() : super( AcceptrejectInitial());
  getAcceptReject(String status,int id) async {
  
    emit( AcceptrejectInitial());
    try{
    
      final  data = await  DashboardData().acceptReject(status, id);
      emit( AcceptrejectLoaded(data));
    }catch(ex){
      print(ex.toString());
      emit( AcceptrejectError());
    }
    
  }
}