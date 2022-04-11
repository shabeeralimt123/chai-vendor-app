import 'package:bloc/bloc.dart';
import 'package:chai/models/NewOrders.dart';
import 'package:chai/repositaries/getDashboardData.dart';
import 'package:meta/meta.dart';

part 'neworder_state.dart';

class NeworderCubit extends Cubit<NeworderState> {
  NeworderCubit() : super(NeworderInitial());
    getNewOrders(String status) async {
  
    emit( NeworderInitial());
    try{
    
      final  data = await  DashboardData().getNewOrder(status);
      
      emit( NeworderLoaded(data));
    }catch(ex){
      print(ex.toString());
      emit( NeworderError());
    }
    
  }

}
