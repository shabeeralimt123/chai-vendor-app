part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}
class Authenticating extends AuthenticationState{
 

}
class Registering extends AuthenticationState{}
class Registered extends AuthenticationState{
  
 final RegisterResponseModel register;


  Registered(this.register);
}
class RegistrationError extends AuthenticationState{
  final String message;

  RegistrationError(this.message);
}


class AuthenticationInitial extends AuthenticationState {}
class OtpResending extends AuthenticationState {}
class OtpResended extends AuthenticationState {
  final LoginResponsemodel loginResponseModel;

  OtpResended(this.loginResponseModel);
}
class OtpResendError extends AuthenticationState {
  final String message;

  OtpResendError(this.message);

}
class Authenticated extends AuthenticationState {
  final LoginResponsemodel loginResponseModel;

  Authenticated(this.loginResponseModel);
}
class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}
class VerifyOtp extends AuthenticationState {}
class OtpVerified extends AuthenticationState {
  final LoginResponsemodel loginResponseModel;

  OtpVerified(this.loginResponseModel);
}
class VerifyOtpError extends AuthenticationState {
  final String message;

  VerifyOtpError(this.message);

}
class LoggingOut extends AuthenticationState {}
class LoggedOut extends AuthenticationState {

}
class LogoutError extends AuthenticationState {
  final String message;

  LogoutError(this.message);

}






