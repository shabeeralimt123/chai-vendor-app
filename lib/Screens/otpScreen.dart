import 'dart:async';


import 'package:chai/Screens/homescreen.dart';
import 'package:chai/bloc/login/authentication_cubit.dart';
import 'package:chai/models/LoginesponseModel.dart';
import 'package:chai/resources/styleResources.dart';
import 'package:chai/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpScreen extends StatefulWidget {
  final LoginResponsemodel? loginResponseModel;
  static route(LoginResponsemodel loginResponseModel) => MaterialPageRoute(
      builder: (context) => OtpScreen(
            loginResponseModel: loginResponseModel,
          ));

  const OtpScreen({Key? key,this.loginResponseModel}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _otpTimer;
  LoginResponsemodel loginResponseModel = LoginResponsemodel();
  int timeLeft = 180;
  final TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loginResponseModel = widget.loginResponseModel!;
    // _otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (timeLeft >= 1) {
    //     timeLeft -= 1;
    //     setState(() {});
    //   } else {
    //     if (_otpTimer!.isActive) {
    //       _otpTimer!.cancel();
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleResources.bgColor,
      body: SafeArea(
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
          
            if (state is VerifyOtp) {
              showLoaderDialog(context);
            }
            if (state is VerifyOtpError) {
              Navigator.pop(context);
              showErrorMessage(context, message: state.message);
            }
            if (state is OtpVerified) {
              Navigator.pop(context);
              if (state.loginResponseModel.user!.status == 0 || state.loginResponseModel.user!.status == 1) {
                 Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
        
              } 
            }
          },
          child: SingleChildScrollView(
            child : Container(

              height: MediaQuery.of(context).size.height-48,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
              
                children: [
                  SizedBox(height:200),
                 
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         
                          Text(
                            "We have sent verification pin to your phone.\nPlease verify to continue.",
                            textAlign: TextAlign.center,
                            style: StyleResources.subText,
                          ),
                          PinCodeTextField(
                            appContext: context,
                            length: 4,
                            controller: otpController,
                            onChanged: (val) {},
                            backgroundColor: StyleResources.bgColor,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            pinTheme: PinTheme(),
                            textStyle: StyleResources.subText,
                          ),
                         
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                             onTap:(){
                                     
                              BlocProvider.of<AuthenticationCubit>(context)
                                  .verifyOtp(
                                    loginResponseModel, otpController.text);
                            

                             },
                             child: Container(
                                                   height: 45,
                                                   child: Material(
                                                     elevation: 10,
                                                     borderRadius: BorderRadius.circular(10),
                                                     child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child:const  Center(
                                child: Text(
                                  "Verify",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                                                     ),
                                                   ),
                                                 ),
                           )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _otpTimer!.cancel();
  //   super.dispose();
  // }
}

