import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/globals.dart';

class secondtStepController{


  static double Calculstat(Firstval,Secondval,Thirdtval,Fourthval){


    Firstval = double.parse(Firstval);
    Secondval = double.parse(Firstval);
    Thirdtval = double.parse(Firstval);
    Fourthval as double;
    double result = 0.0;

    result = Firstval + Secondval + Thirdtval + Fourthval;
    if (result != 0){
      log("RESULTAT :" + result.toString());
      return result;

    }
    else {
      return null;
    }
  }
}