import 'package:flutter/material.dart';

class TextWidget{
  /// textfield
  textFieldWidget(controller,hintText){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
  /// Elevated Button
  textWidget(text,fontSize,fontweight,color){
    return Text(text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontweight,
        color: color,
      ),
    );
  }
}