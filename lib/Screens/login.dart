import 'package:chai/Screens/homescreen.dart';
import 'package:chai/Screens/otpScreen.dart';
import 'package:chai/bloc/login/authentication_cubit.dart';
import 'package:chai/componants/gradientbutton.dart';
import 'package:chai/repositaries/loginRepositary.dart';
import 'package:chai/resources/styleResources.dart';
import 'package:chai/utils/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class LoginScreen extends StatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:true,
       backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthenticationCubit,AuthenticationState>(
          listener: (context,state){
            if(state is Authenticating){
              showLoaderDialog(context);
            }
            if(state is AuthenticationError){
              Navigator.pop(context);
              showErrorMessage(context, message: state.message );
            }

            if(state is Authenticated){

            
              (state.loginResponseModel.user!.id);

              Navigator.pushAndRemoveUntil(
                  context, OtpScreen.route(state.loginResponseModel), (route) => false);
                  
            }
          },
          child: Material(
            elevation: 0,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                 
                
                  children: [
                          Padding(
                padding: const EdgeInsets.only(top:160),
                child: Container(
                  height :150,
                  width :150,
                  decoration: new BoxDecoration(color: Colors.white60,
                        image: new DecorationImage(
                  image: new AssetImage("assets/logo.png"),
                  fit: BoxFit.fill,
                        )
                  )
                          ),
                          ),
                          SizedBox(height:70),
                    Align(
                     
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            Center(
                              child: TextFormField(
                                controller: phoneController,
                                style: StyleResources.textFieldStyle,
                                keyboardType: TextInputType.number,
                                  decoration:
                                      StyleResources.textFieldDecoration("Phone No.")),
                            ),
                           const SizedBox(
                              height: 10,
                            ),
                             InkWell(
                        onTap: () {
                          print("194.233.65.81/chai_admin/api/loginvendor?mobile=${phoneController.text}");
                        //                           Navigator.of(context).push(
                        //    MaterialPageRoute(fullscreenDialog: true,
                        //    builder: (context) => OtpScreen(),                                                                                                                                                                                                                                                                                             
                        //    ),
                        // );
                           BlocProvider.of<AuthenticationCubit>(context).login(phoneController.text);
                          
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
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        
                        ),
                            // GradientButton(
                            //   title: "Get Started",
                            //   icon: Icons.arrow_forward,
                            //   onPressed: (){
                            //     BlocProvider.of<AuthenticationCubit>(context).login(phoneController.text);
                
                            //   },
                            // ),
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
      ),
    );
  }
}
