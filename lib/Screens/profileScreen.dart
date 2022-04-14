import 'dart:convert';
import 'dart:developer';

import 'package:chai/Screens/homescreen.dart';
import 'package:chai/Screens/login.dart';
import 'package:chai/bloc/getUserts/getshopuser_cubit.dart';
import 'package:chai/bloc/login/authentication_cubit.dart';
import 'package:chai/models/LoginesponseModel.dart';
import 'package:chai/models/registerResponseModel.dart';
import 'package:chai/models/shopUser.dart';
import 'package:chai/models/user.dart';
import 'package:chai/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSwitched = true;
  bool isEdited = false;
  LoginResponsemodel login = LoginResponsemodel();
  bool switchControl = false;
  var textHolder = 'Inactive';
  int? newstatus;
  late SharedPreferences sharedPreferences;
  ShopUser user = ShopUser();

  RegisterResponseModel response = RegisterResponseModel();

  void storeData() {
    Users users = Users(
        name: nameController.text,
        phone: mobileController.text,
        address: addressController.text,
        swichControll: switchControl,
        textHolder: textHolder);
    String userData = jsonEncode(users);
    log('the userData is ...............$userData');
    sharedPreferences.setString('userData', userData);
  }

  void initialGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsondetails =
        jsonDecode(sharedPreferences.getString('userData')!);
    Users users = Users.fromJson(jsondetails);
    if (jsondetails.isNotEmpty) {
      nameController.value = TextEditingValue(text: users.name);
      mobileController.value = TextEditingValue(text: users.phone);
      addressController.value = TextEditingValue(text: users.address);
      switchControl = users.swichControll;
      textHolder = users.textHolder;
    }
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetshopuserCubit>(context).getShopUser();
    // initialGetSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  _showDialog();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          title: Text(
            "Profile Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is Registering) {
              showLoaderDialog(context);
            }
            if (state is RegistrationError) {
              Navigator.pop(context);
              showErrorMessage(context, message: state.message);
            }

            if (state is Registered) {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              // );

              showSuccessMessage(context, message: "profile updated");
            }
          },
          child: Column(
            children: <Widget>[
              Container(height: 44, width: 44),
              BlocBuilder<GetshopuserCubit, GetshopuserState>(
                builder: (context, state) {
                  if (state is GetshopuserLoaded) {
                    return Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          child: ClipRect(),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, bottom: 100, top: 12),
                child: BlocBuilder<GetshopuserCubit, GetshopuserState>(
                    builder: (context, state) {
                  if (state is GetshopuserInitial) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is GetshopuserLoaded) {
                    if (isEdited == true) {
                      addressController.text = addressController.text;
                      mobileController.text = mobileController.text;
                      nameController.text = nameController.text;
                     
                     
                    
                    } else {
                      addressController.text = state.shopUser.address!;
                      mobileController.text = state.shopUser.mobile!;
                      nameController.text = state.shopUser.shopname!;
                      if (state.shopUser.status == 1) {
                        switchControl = true;
                        textHolder = 'Active';
                        newstatus= 1;
                      } else {
                        switchControl = false;
                        textHolder = 'Inactive';
                        newstatus=0;
                      }
                    }

                    return Column(
                      children: <Widget>[
                        Text("${state.shopUser.shopname}"),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Name",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              )),
                        ),
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.black.withOpacity(.6))),
                            child: Center(
                              child: TextFormField(
                                // initialValue: state.shopUser.shopname!,

                                cursorHeight: 16.0,
                                controller: nameController,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.left,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  // errorText: profileController.name.error,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 10, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("phone number",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.black.withOpacity(.6))),
                            child: Center(
                              child: TextFormField(
                                // initialValue: state.shopUser.mobile!,
                                controller: mobileController,
                                cursorHeight: 16,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                onChanged: (value) {},
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  // errorText: profileController.oldPassword.error,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Address",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.black.withOpacity(.6))),
                            child: Center(
                              child: TextFormField(
                                  // initialValue: state.shopUser.address!,
                                  controller: addressController,
                                  cursorHeight: 16,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  textAlign: TextAlign.left,
                                  onChanged: (value) async {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                  )),
                            ),
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                  scale: 1.5,
                                  child: Switch(
                                    onChanged: (value) {
                                      toggleSwitch(value);
                                    },
                                    value: switchControl,
                                    activeColor: Colors.black,
                                    activeTrackColor: Colors.grey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.grey,
                                  )),
                              Text(
                                '$textHolder',
                                style: TextStyle(fontSize: 18),
                              )
                            ]),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () async {
                                  // storeData();
                                  print(
                                      "the shop is active or inactive ......?   $textHolder");

                                  log("status is...................... $newstatus");

                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .register(
                                    login,
                                    nameController.text,
                                    mobileController.text,
                                    addressController.text,
                                    newstatus!,
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Update Profile",
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                      ],
                    );
                  }
                  return Container();
                }),
              ),
            ],
          ),
        ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        newstatus = 1;
        switchControl = true;
        textHolder = 'Active';

        isEdited = true;
      });
      print('Active');
      // Put your code here which you want to execute on Switch ON event.
      print(newstatus);
      print(switchControl);
    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Inactive';
        newstatus = 0;

        isEdited = true;
      });
      print('Inactive');
      print(newstatus);
      print(switchControl);
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "logout",
            style: TextStyle(color: Colors.black),
          ),
          content: new Text(
            "Are you sure want to logout from  this account?",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Cancell",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ],
        );
      },
    );
  }

  // void getId()async{
  //      final SharedPreferences prefs  = await SharedPreferences.getInstance();
  //      int? id= prefs.getInt('ID');
  //   if(id != null){
  //      print(id);
  //   }else{
  //     print("not an id");
  //   }
  // }

  // void showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       pickupImages(ImageSource.gallery);
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     pickupImages(ImageSource.camera);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // pickupImages(ImageSource sources) async {
  //   final pickedFile = await picker.getImage(source: sources);
  //   setState(() {
  //     imgFile = pickedFile;
  //   });
  // }
}
