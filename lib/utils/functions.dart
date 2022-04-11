
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showLoaderDialog(BuildContext context,{bool isRootNav:false}) {
  showDialog(
      context: context,
      useRootNavigator: isRootNav,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()));
}

showSuccessMessage(BuildContext context,
    {@required String? message, VoidCallback? onCompleted}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text(
              "Success",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            content: Text(
              message!,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  if (onCompleted != null) {
                    onCompleted();
                  }
                },
              )
            ],
          ));
}

showErrorMessage(BuildContext context,
    {String? title,
    @required String? message,
    VoidCallback? onCompleted,
      bool useRootNavigator:false,
      bool showCancelButton:false,
    String? button1,
    String? button2,
    VoidCallback? onCancelled}) {
  showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text(
              title ?? "Oops!",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text(
              message!,
            ),
            actions: <Widget>[
              Visibility(
                visible: showCancelButton,
                child: FlatButton(
                  child: Text(button2 ?? "Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancelled != null) {
                      onCancelled();
                    }
                  },
                ),
              ),
              FlatButton(
                child: Text(button1 ?? "OK"),
                onPressed: () {
                  Navigator.pop(context);
                  if (onCompleted != null) {
                    onCompleted();
                  }
                },
              )
            ],
          ));
}



double convertToDouble(value){
  return double.parse((value??0).toString());
}

String convertToTimezone(datetime){
  return DateFormat('dd MMM yyy hh:mm a',).format(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parseUTC(datetime,).toLocal());
}