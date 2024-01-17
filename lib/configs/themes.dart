
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/configs/constants.dart';

final appTheme = ThemeData(
  primaryColor: kYellow,
  
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal, // Use an appropriate FontWeight enum value here
      fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 55,
      fontWeight: FontWeight.bold, // Use an appropriate FontWeight enum value here
      fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
  ),

  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold, // Use an appropriate FontWeight enum value here
      fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    color: kBlue,
  ),
  scaffoldBackgroundColor: kGrey,

  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCircularBorderRadius),
    ),
    backgroundColor: kGrey,
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold, // Use an appropriate FontWeight enum value here
      fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold, // Use an appropriate FontWeight enum value here
      fontFamily: GoogleFonts.notoSans().fontFamily,
    )
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCircularBorderRadius),
        side: const BorderSide( color: Colors.white, )
      ),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold, // Use an appropriate FontWeight enum value here
        fontFamily: GoogleFonts.notoSans().fontFamily,
      )
    )),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: kBlue,
    linearTrackColor: Colors.white,
  ),


  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(kBlue),
    trackColor: MaterialStateProperty.all<Color>(Colors.grey), // Set the background color when the switch is toggled off
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent), // Set the color when the switch is being dragged
    // You can customize other properties here
  ),

  listTileTheme: ListTileThemeData(
    tileColor: kYellow,
    textColor: Colors.black,
    iconColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCircularBorderRadius),
      side: BorderSide(color: Colors.white,
      width: 2,
      )
      )
  ),
      
);
