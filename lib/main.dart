
import 'package:chai/Screens/login.dart';
import 'package:chai/bloc/Dashboard/dashboard_cubit.dart';
import 'package:chai/bloc/NewOrder/neworder_cubit.dart';
import 'package:chai/bloc/acceptreject/acceptreject_cubit.dart';
import 'package:chai/bloc/getUserts/getshopuser_cubit.dart';
import 'package:chai/bloc/login/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: 
      
      [
         BlocProvider(
            create: (context) => AuthenticationCubit(),),

               
               BlocProvider(
            create: (context) => AcceptrejectCubit(),),
              BlocProvider(
            create: (context) => GetshopuserCubit(),),
             BlocProvider(
            create: (context) => NeworderCubit(),),
               BlocProvider(
            create: (context) =>  DashboardCubit (),),
            
      ],
      child: MaterialApp(
                    
              debugShowCheckedModeBanner: false,
              title: 'Chai Vendor',
              theme: ThemeData(
          
             
          primarySwatch: Colors.blue,
               
          visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginScreen(),
        
      ),
    );
    
  }
}



