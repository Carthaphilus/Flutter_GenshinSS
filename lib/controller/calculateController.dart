import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/ArmeNiveau.dart';
import 'package:genshin_android_app/models/Competences.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';
import 'package:genshin_android_app/models/Niveau.dart';
import 'package:genshin_android_app/models/PersonnageNiveau.dart';

class calculateController{

  Personnage _selectedPersonnage;
  Niveau _pNiveau;
  PersonnageNiveau _personnageNiveau;
  Armes _selectedArme;
  String _selectedRaffinement;
  Niveau _aNiveau;
  ArmeNiveau _armeNiveau;
  String _ascensionCompetence;
  String _pvMax;
  String _atkP;
  String _atk;
  String _def;
  String _me;
  String _tc;
  String _dc;
  String _dPyro;
  String _dHydro;
  String _dDendro;
  String _dElectro;
  String _dAnemo;
  String _dCryo;
  String _dGeo;
  String _dPhys;
  double _totAtk;
  double _totAtkCrit;

  calculateController();


  int Calculstat(Competences uneCompetence){
    RegExp regExp = new RegExp(r'\d+\.?\d?');
    double secondStatArme = 0;
    int ab;
    double attaque;

    if(armeNiveau.stat_secondaire.contains("ATK")) {
      secondStatArme =  double.parse(regExp.stringMatch(armeNiveau.stat_secondaire));
    }

    ab = personnageNiveau.atk + armeNiveau.atk;
    attaque = ab * (1+((secondStatArme + double.parse(atkP)) / 100)) + int.parse(atk);
    totAtk = attaque * ((double.parse(dPhys) / 100) + 1) + ((uneCompetence.pourcentage_degats / 100) + 1);
    totAtkCrit = totAtk *((double.parse(dc) / 100) + 1);
  }

  String resumeData(){
    return selectedPersonnage.nom + " ("+ pNiveau.nb_niveau.toString()+")"+ " | "+ selectedArme.nomArme + " ("+selectedRaffinement+":"+aNiveau.nb_niveau.toString()+")";
  }

  Personnage get selectedPersonnage => _selectedPersonnage;

  set selectedPersonnage(Personnage value) {
    _selectedPersonnage = value;
  }

  Armes get selectedArme => _selectedArme;

  set selectedArme(Armes value) {
    _selectedArme = value;
  }


  Niveau get pNiveau => _pNiveau;

  set pNiveau(Niveau value) {
    _pNiveau = value;
  }


  Niveau get aNiveau => _aNiveau;

  set aNiveau(Niveau value) {
    _aNiveau = value;
  }

  String get selectedRaffinement => _selectedRaffinement;

  set selectedRaffinement(String value) {
    _selectedRaffinement = value;
  }


  String get ascensionCompetence => _ascensionCompetence;

  set ascensionCompetence(String value) {
    _ascensionCompetence = value;
  }

  String get pvMax => _pvMax;

  set pvMax(String value) {
    _pvMax = value;
  }

  String get atkP => _atkP;

  set atkP(String value) {
    _atkP = value;
  }

  String get atk => _atk;

  set atk(String value) {
    _atk = value;
  }

  String get def => _def;

  set def(String value) {
    _def = value;
  }

  String get me => _me;

  set me(String value) {
    _me = value;
  }

  String get tc => _tc;

  set tc(String value) {
    _tc = value;
  }

  String get dc => _dc;

  set dc(String value) {
    _dc = value;
  }

  String get dPyro => _dPyro;

  set dPyro(String value) {
    _dPyro = value;
  }

  String get dHydro => _dHydro;

  set dHydro(String value) {
    _dHydro = value;
  }

  String get dDendro => _dDendro;

  set dDendro(String value) {
    _dDendro = value;
  }

  String get dElectro => _dElectro;

  set dElectro(String value) {
    _dElectro = value;
  }

  String get dAnemo => _dAnemo;

  set dAnemo(String value) {
    _dAnemo = value;
  }

  String get dCryo => _dCryo;

  set dCryo(String value) {
    _dCryo = value;
  }

  String get dGeo => _dGeo;

  set dGeo(String value) {
    _dGeo = value;
  }

  String get dPhys => _dPhys;

  set dPhys(String value) {
    _dPhys = value;
  }

  PersonnageNiveau get personnageNiveau => _personnageNiveau;

  set personnageNiveau(PersonnageNiveau value) {
    _personnageNiveau = value;
  }

  ArmeNiveau get armeNiveau => _armeNiveau;

  set armeNiveau(ArmeNiveau value) {
    _armeNiveau = value;
  }

  double get totAtkCrit => _totAtkCrit;

  set totAtkCrit(double value) {
    _totAtkCrit = value;
  }

  double get totAtk => _totAtk;

  set totAtk(double value) {
    _totAtk = value;
  }
}