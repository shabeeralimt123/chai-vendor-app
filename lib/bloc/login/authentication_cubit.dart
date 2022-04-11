
import 'package:bloc/bloc.dart';
import 'package:chai/models/LoginesponseModel.dart';
import 'package:chai/models/registerResponseModel.dart';
import 'package:chai/repositaries/loginRepositary.dart';
import 'package:chai/resources/prefResources.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';



part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> { 
  AuthenticationCubit()
      : super(AuthenticationInitial());
    

    login(String phone) async {
      final AuthenticationRepository authentication = AuthenticationRepository();
      print(authentication.login(phone));
    emit(Authenticating());
    try {
      final LoginResponsemodel response =
         await authentication.login(phone);
      emit(Authenticated(response));
    } catch (ex) {
      emit(AuthenticationError("Sorry! We Couldn't authenticate your account"));
    }
  }


  //  resendOtp(String phone) async {
  //   emit(OtpResending());
  //   try {
  //     LoginResponsemodel response =
  //         (await AuthenticationRepository().login(phone));
  //     emit(OtpResended(response));
  //   } catch (ex) {

  //     emit(OtpResendError("Sorry! We Couldn't authenticate your account"));
  //   }
  // }

  verifyOtp(LoginResponsemodel loginResponseModel, String otp) async {
    emit(VerifyOtp());
    try {
      print(loginResponseModel.otp);
      print(otp);
      if(loginResponseModel.user!.status!= 0){

      print("otp is status is 1");
      }else{
      print("error");}
      if (loginResponseModel.otp == otp) {
        if (loginResponseModel.user!.status!= 0 || loginResponseModel.user!.status!= 1) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString(PrefResources.JWT, loginResponseModel.accessToken!);
          pref.setString(

              PrefResources.USER, loginResponseModel.user.toString());
          pref.setBool(PrefResources.IS_LOGGEDIN, true);
       
        }
        emit(OtpVerified(loginResponseModel));
      } else {
        emit(VerifyOtpError("Sorry! Invalid Otp Provided"));
      }
    } catch (ex) {

      emit(VerifyOtpError("Sorry! We Couldn't authenticate your account"));
    }
  }

  logout() async {
    emit(LoggingOut());
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove(PrefResources.JWT);
      pref.remove(PrefResources.USER);
      pref.remove(PrefResources.IS_LOGGEDIN);

      emit(LoggedOut());
    } catch (ex) {

      emit(VerifyOtpError("Sorry! We Couldn't authenticate your account"));
    }
  }
  //  register(LoginResponsemodel model,int status,String phone,String address,) async {
  //     final AuthenticationRepository authentication = AuthenticationRepository();
  //   emit(Registering());
  //   try {
    
     
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString("token", model.accessToken!);
  //       pref.setString("id", model.user!.id.toString());
  //       pref.setBool("isLogged", true);

  //         final RegisterResponseModel response =
  //        await authentication.register(status,phone,address);
        
      
  //     emit(Registered(response));
  //   } catch (ex) {

  //     emit(RegistrationError("Sorry! We Couldn't update your account"));
  //   }
  // }
 register(LoginResponsemodel login,String shopname,String phone,String address,int status ) async {
    final AuthenticationRepository authentication = AuthenticationRepository();
      print(authentication.register(shopname,phone,address,status));
    emit(Registering());
    try {
      // SharedPreferences pref = await SharedPreferences.getInstance();
      //       pref.setString(

      //          PrefResources.USER, login.user.toString());
         
      //     pref.setBool(PrefResources.IS_LOGGEDIN, true);
         
            final response=
         await authentication.register(shopname,phone,address,status);
         
      emit(Registered(response));
    } catch (ex) {
      emit(AuthenticationError("cannot update the data"));
    }
  }
 

 
 

}

