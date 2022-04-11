import 'package:bloc/bloc.dart';
import 'package:chai/models/Dashboard.dart';
import 'package:chai/repositaries/getDashboardData.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  getDashBoard() async {
  
    emit( DashboardInitial());
    try{
    
      final  data = await  DashboardData().getDashboardCount();
      emit( DashboardLoaded(data));
    }catch(ex){
      print(ex.toString());
      emit( DashboardError());
    }
    
  }
}
