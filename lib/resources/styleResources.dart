import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StyleResources {
  static final primarycolor = Color(0xff7905B0);
  static final secondarycolor = Color(0xffEF7F1A);
  static final textcolor = Color(0xff4B4C4B);
  static final green = Color(0xff089D49);
  static final grey = Colors.grey[300];
  static final appbarTextstyle = TextStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(.6));
  static bottomNavigationButton(context, String title) => Container(
        height: 65,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                color: StyleResources.primarycolor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
       static  InputDecoration textFieldDecoration(String label,{padding,suffixIcon}) => InputDecoration(
      contentPadding: padding??EdgeInsets.symmetric(horizontal: 8,vertical: 0),
      labelText: label,floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: suffixIcon,

      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1
          )
      )
  );
  static InputBorder inputBorderDarkMode = OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.white,
          width: 1
      )
  );
  static  InputDecoration textFieldDecorationDarkMode(String label,{padding,suffixIcon}) => InputDecoration(
      contentPadding: padding??EdgeInsets.symmetric(horizontal: 8,vertical: 0),
      labelText: label,floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: suffixIcon,
      
      border: inputBorderDarkMode,
    disabledBorder: inputBorderDarkMode,
    enabledBorder: inputBorderDarkMode,
    errorBorder: inputBorderDarkMode,
    focusedBorder: inputBorderDarkMode,
    focusedErrorBorder: inputBorderDarkMode
  );

   static const TextStyle textFieldStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12
  );

     
  static const TextStyle buttonPrimaryTextStyle =
      TextStyle(color: StyleResources.primaryColorText);
  static const Color primaryColorText = Colors.white;
  static const Color bgColor = Colors.white;
  static const TextStyle subText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  static textFeildDecoration(
    context,
  ) =>
      InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // contentPadding: EdgeInsets.symmetric(horizontal: 10),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      );
}
