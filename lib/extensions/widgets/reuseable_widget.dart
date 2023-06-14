import 'package:flutter/material.dart';

Image logoImage(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 219,
    height: 182,
  );
}

TextField reuseableTextField(String text, bool isPasswordType, bool isEnabled,
    TextEditingController controller) {
  // bool _obsecureText = isPasswordType;
  return TextField(
    controller: controller,
    // obscureText: _obsecureText,
    obscureText: isPasswordType,
    enabled: isEnabled,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.grey,
    style: TextStyle(color: Colors.black54.withOpacity(0.8)),
    decoration: InputDecoration(
      
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}


TextField reuseableTextField2(String text, IconData icon, bool isPasswordType, bool isEnabled,
    TextEditingController controller) {
  // bool _obsecureText = isPasswordType;
  return TextField(
    controller: controller,
    // obscureText: _obsecureText,
    obscureText: isPasswordType,
    enabled: isEnabled,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black54.withOpacity(0.8)),
    decoration: InputDecoration(
      
      suffixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}




Container signInSignOutButton(BuildContext context, bool isLogin,
    Function onTap) {
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: 55,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)))),
    ),
  );
}



Container normalButton(BuildContext context, String title,
    Function onTap) {
  return Container(

    height: 48,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        maximumSize: MaterialStatePropertyAll(Size(300,48)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return Colors.blue;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
      child: Text(
         title ,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
  );
}



Container button(BuildContext context, Function onTab, Widget icon) {

  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: 55,

    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    child: ElevatedButton(
    onPressed: () { onTab();},
    child: icon,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white70;
          }
          return Colors.black;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
  ),
  );
}