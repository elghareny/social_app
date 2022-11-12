import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigatTo(context, widget) => 
Navigator.push(context, 
MaterialPageRoute(builder: (context) => widget,));

void navigatToAndFinish(context , widgit)=> 
Navigator.pushAndRemoveUntil(context, 
MaterialPageRoute(builder: (context)=> widgit), 
(Route<dynamic> route) => false);

void navigateAndFinis(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),
    (Route<dynamic> route)=>false,
);



Widget textField
({
  @required TextEditingController? controller,
  TextInputType? type,
  Function(String)? onSubmit,
  @required String? Function(String?)? validate,
  bool isPassword = false,
  @required String? text,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
})
{
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    validator: validate,
    textAlign: TextAlign.start,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon !=null ? IconButton(icon: Icon(suffixIcon),
      onPressed: suffixPressed,
      ) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
      )
    ),
  );
}







Widget defaultButton
({
  double width= double.infinity,
  double height= 60,
  Color? backcolor,
  double radius= 0.0,
  @required String? text,
  @required VoidCallback? function,
})
{
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      child: Text(text!,style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 25
    ),),
      onPressed: function,
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backcolor,
      ),
  );
}





void showToast
(
  @required String? text,
  @required ToastStates? state,
)
{
   Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state!),
    textColor: Colors.white,
    fontSize: 16.0

    );
}


enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor (ToastStates state)
{
  Color? color;
  switch (state)
  {
    case ToastStates.SUCCESS :
    color = Colors.green;
    break;

    case ToastStates.WARNING :
    color = Colors.yellow;
    break;

    case ToastStates.ERROR :
    color = Colors.red;
    break;
  }
  return color;
}