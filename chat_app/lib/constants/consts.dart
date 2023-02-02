import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Constants {
  static TextStyle myAppBarStyle = GoogleFonts.mPlus1(
      color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold);
      static TextStyle yadaStyle = GoogleFonts.mPlus1(
      color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle myModalSheetStyle = GoogleFonts.mPlus1(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle myWelcomeStyle = GoogleFonts.mPlus1(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle switchButtons = GoogleFonts.mPlus1(
      color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.bold);
  static final HexColor arkaPlanRengi_1 = HexColor("#061161");
  static final HexColor arkaPlanRengi_2 = HexColor("#780206");
  static const String googleUrl = "lib/images/google48.png";
  static const String twitterUrl = "lib/images/twitter48.png";
  static const String forgotPass = "lib/images/resett.gif";
}
