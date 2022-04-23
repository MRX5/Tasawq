import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultTextFormFiled({
  required TextEditingController controller,
  required IconData prefixIcon,
  required String label,
  required String? Function(String?) validator,
  Function(String)? onSubmit,
  Function()? onTap,
  IconData? suffixIcon,
  Function()? onSuffixIconTap,
  TextInputType textInputType=TextInputType.text,
  bool obscureType=false,
  double borderRadius=5
}){
  return TextFormField(
    controller: controller,
    validator: validator,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    obscureText: obscureType,
    keyboardType: textInputType,
    decoration: InputDecoration(
        border:  OutlineInputBorder(
            borderRadius:BorderRadius.circular(borderRadius)
        )
        ,
        prefixIcon: Icon(prefixIcon),
        hintText: label,
        suffixIcon: IconButton(
          icon: suffixIcon!=null?Icon(suffixIcon):const Icon(null),
          onPressed: onSuffixIconTap,
        )
    ),
  );
}

Widget defaultButton({
  required onPressed,
  required String text,
  double width=double.infinity,
  Color backgroundColor=Colors.green,
  List<Color>? gradientColors,
  double borderRadius=0
}){
  return Container(
    width: width,
    height: 50.0,
    decoration: BoxDecoration(
      color: backgroundColor,
      gradient: (gradientColors!=null)?LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: gradientColors,
      ):null,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      child: Text(
        text.toUpperCase(),
      ),
      textColor: Colors.white,
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required Function() function
}){
  return TextButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      )
  );
}

void navigateTo({
  required BuildContext context,
  required Widget screen
}){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}

void navigateAndFinish({
  required BuildContext context,
required Widget screen
}){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=>screen),
    (Route<dynamic> route) {
      return false;
    },
  );
}