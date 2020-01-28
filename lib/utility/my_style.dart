import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyle {

  Color textColor = Color.fromARGB(0xff, 0xbc, 0x51, 0x00);
  Color mainColor = Color.fromARGB(0xff, 0xf5, 0x7f, 0x17);

  TextStyle h1Main = GoogleFonts.pacifico(
        textStyle: TextStyle(
          fontSize: 30.0,
          color: Color.fromARGB(0xff, 0xbc, 0x51, 0x00),
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );


  MyStyle();
  
}