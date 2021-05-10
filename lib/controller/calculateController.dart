import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/globals.dart';

class calculateController{

  int pvMax;
  int atk;
  int def;
  int me;
  double tc;
  double dc;
  double dPyro;
  double dHydro;
  double dDendro;
  double dElectro;
  double  dAnemo;
  double dCryo;
  double dGeo;
  double dPhys;

  calculateController(Firstval){
    pvMax = Firstval;
    atk = Firstval;
    def = Firstval;
    me = Firstval;
    tc = double.parse(Firstval);
    dc = double.parse(Firstval);
    dPyro = double.parse(Firstval);
    dHydro = double.parse(Firstval);
    dDendro = double.parse(Firstval);
    dElectro = double.parse(Firstval);
    dAnemo = double.parse(Firstval);
    dCryo = double.parse(Firstval);
    dGeo = double.parse(Firstval);
    dPhys = double.parse(Firstval);
  }


  double Calculstat(){

    //Fourthval as double;
    double result = 0.0;

    //result = Firstval + Secondval + Thirdtval + Fourthval;
    if (result != 0){
      log("RESULTAT :" + result.toString());
      return result;

    }
    else {
      return null;
    }
  }
}