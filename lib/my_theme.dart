import 'package:flutter/material.dart';

class Themes{
  static Color primarylight=Color(0xffDFECDB);
  static Color blue=Color(0xff5D9CEC);
  static Color red=Color(0xffEC4B4B);
  static Color green=Color(0xff61E757);
  static Color lightblackText=Color(0xff363636);
  static Color darkBlackText=Color(0xff303030);
  static Color sheetsBlack=Color(0xff141922);
  static Color primaryDark=Color(0xff060E1E);
static Color white=Color(0xffFFFFFF);
static Color paleGrey=Color(0xff707070);

static ThemeData lightTheme=ThemeData(appBarTheme: AppBarTheme(elevation: 0),
    bottomSheetTheme:BottomSheetThemeData(
    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
        side: BorderSide(width:5,color:blue )))
    ,textTheme: TextTheme(
     titleLarge: TextStyle(color:sheetsBlack,fontWeight: FontWeight.bold,fontSize: 18 )),
      scaffoldBackgroundColor: primarylight,
    primaryColor: primarylight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme:IconThemeData(color: blue),)

  );

  static  ThemeData darkTheme=ThemeData(appBarTheme: AppBarTheme(elevation: 0),
      textTheme: TextTheme(
      titleLarge: TextStyle(color:white,fontWeight: FontWeight.bold,fontSize: 18 )),
      scaffoldBackgroundColor: primaryDark,
      primaryColor: primaryDark,
      bottomSheetTheme:BottomSheetThemeData(
          backgroundColor:Themes.sheetsBlack,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Themes.blue))),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme:IconThemeData(color: blue) )

  );
}