import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/ArmeNiveau.dart';
import 'package:genshin_android_app/models/ArtefactStatEffet.dart';
import 'package:genshin_android_app/models/Competences.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/models/Armes.dart';
import 'package:genshin_android_app/models/Niveau.dart';
import 'package:genshin_android_app/models/PersonnageNiveau.dart';
import 'package:genshin_android_app/models/Artefact.dart';

class calculateController{

  String _NomProfil;
  Personnage _selectedPersonnage;
  Niveau _pNiveau;
  PersonnageNiveau _personnageNiveau;
  Armes _selectedArme;
  String _selectedRaffinement;
  Niveau _aNiveau;
  ArmeNiveau _armeNiveau;
  Artefact _artefactSet1;
  Artefact _artefactSet2;
  List<ArtefactStatEffet> _artefactStatEffet1 = [];
  List<ArtefactStatEffet> _artefactStatEffet2 = [];
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

  factory calculateController.fromJson(Map<String, dynamic> json){
    calculateController operation =  new calculateController();
    operation.NomProfil = json['NomProfil'];
    operation.selectedPersonnage = Personnage.fromJson(json['selectedPersonnage']);
    operation.pNiveau = Niveau.fromJson(json['pNiveau']);
    operation.personnageNiveau = PersonnageNiveau.fromJson(json['personnageNiveau']);
    operation.selectedArme = Armes.fromJson(json['selectedArme']);
    operation.selectedRaffinement = json['selectedRaffinement'];
    operation.aNiveau = Niveau.fromJson(json['aNiveau']);
    operation.armeNiveau = ArmeNiveau.fromJson(json['armeNiveau']);
    operation.artefactSet1 = Artefact.fromJson(json['artefactSet1']);
    operation.artefactSet2 = Artefact.fromJson(json['artefactSet2']);
    operation.artefactStatEffet1 = ArtefactStatEffet.fromJsonTab(json['artefactStatEffet1']) ?? [];
    operation.artefactStatEffet2 = ArtefactStatEffet.fromJsonTab(json['artefactStatEffet2']) ?? [];
    operation.ascensionCompetence = json['ascensionCompetence'] ?? '1';
    operation.pvMax = json['pvMax'] ?? '0';
    operation.atkP = json['atkP'] ?? '0';
    operation.atk = json['atk'] ?? '0';
    operation.def = json['def'] ?? '0';
    operation.me = json['me'] ?? '0';
    operation.tc = json['tc'] ?? '0';
    operation.dc = json['dc'] ?? '0';
    operation.dPyro = json['dPyro'] ?? '0';
    operation.dHydro = json['dHydro'] ?? '0';
    operation.dDendro = json['dDendro'] ?? '0';
    operation.dElectro = json['dElectro'] ?? '0';
    operation.dAnemo = json['dAnemo'] ?? '0';
    operation.dCryo = json['dCryo'] ?? '0';
    operation.dGeo = json['dGeo'] ?? '0';
    operation.dPhys = json['dPhys'] ?? '0';
    operation.totAtk = json['totAtk'];
    operation.totAtkCrit = json['totAtkCrit'];
    return operation;
  }

  Map<String, dynamic> toJson() => {
    'NomProfil' : _NomProfil,
    'selectedPersonnage' : selectedPersonnage,
    'pNiveau': pNiveau,
    'personnageNiveau': personnageNiveau,
    'selectedArme': selectedArme,
    'selectedRaffinement': selectedRaffinement,
    'aNiveau': aNiveau,
    'armeNiveau': armeNiveau,
    'artefactSet1' : artefactSet1,
    'artefactSet2' : artefactSet2,
    'artefactStatEffet1' : artefactStatEffet1,
    'artefactStatEffet2' : artefactStatEffet2,
    'ascensionCompetence': ascensionCompetence,
    'pvMax': pvMax,
    'atkP': atkP,
    'atk': atk,
    'def': def,
    'me': me,
    'tc': tc,
    'dc': dc,
    'dPyro': dPyro,
    'dHydro': dHydro,
    'dDendro': dDendro,
    'dElectro': dElectro,
    'dAnemo': dAnemo,
    'dCryo': dCryo,
    'dGeo': dGeo,
    'dPhys': dPhys,
    'totAtk': totAtk,
    'totAtkCrit': totAtkCrit
  };


  int Calculstat(Competences uneCompetence){
    RegExp regExp = new RegExp(r'\d+\.?\d?');
    double secondStatArme = 0;
    int ab;
    double attaque;

    if(armeNiveau.stat_secondaire.contains("ATK")) {
      secondStatArme =  double.parse(regExp.stringMatch(armeNiveau.stat_secondaire));
    }

    ab = personnageNiveau.atk + armeNiveau.atk;
    bonusSet(uneCompetence);
    attaque = ab * (1+((secondStatArme + double.parse(atkP)) / 100)) + int.parse(atk);
    calculeElementCompetence(uneCompetence, attaque);
    totAtkCrit = totAtk *((double.parse(dc) / 100) + 1);
  }

  bonusSet(Competences uneCompetence) {
    for (ArtefactStatEffet uneStat in artefactStatEffet1) {
      switch (uneStat.type_statistiques_id) {
        case 2:
          double dbAtkP = double.parse(atkP) + uneStat.valeur.toDouble();
          atkP = dbAtkP.toString();
          break;
        case 7:
          double dbTc = double.parse(tc) + uneStat.valeur.toDouble();
          tc = dbTc.toString();
          break;
        case 8:
          double dbDc = double.parse(dc) + uneStat.valeur.toDouble();
          dc = dbDc.toString();
          break;
        case 11:
          double dbPhys = double.parse(dPhys) + uneStat.valeur.toDouble();
          dPhys = dbPhys.toString();
          break;
        case 12:
          dPyro = (double.parse(dPyro) + uneStat.valeur.toDouble()).toString();
          dHydro = (double.parse(dHydro) + uneStat.valeur.toDouble()).toString();
          dDendro = (double.parse(dDendro) + uneStat.valeur.toDouble()).toString();
          dElectro = (double.parse(dElectro) + uneStat.valeur.toDouble()).toString();
          dAnemo = (double.parse(dAnemo) + uneStat.valeur.toDouble()).toString();
          dCryo = (double.parse(dCryo) + uneStat.valeur.toDouble()).toString();
          dGeo = (double.parse(dGeo) + uneStat.valeur.toDouble()).toString();
          break;
        case 13:
          if(uneCompetence.typeCompetence == 1 && uneCompetence.personnage_competence_label.contains(RegExp(r'(DGT \der? coup)'))) {
            double dbComp = uneCompetence.pourcentage_degats + uneStat.valeur.toDouble();
            uneCompetence.pourcentage_degats = dbComp;
          }
          break;
        case 14:
          if(uneCompetence.typeCompetence == 1 && (uneCompetence.personnage_competence_label.contains('DGT Tir visé') || uneCompetence.personnage_competence_label.contains('DGT Attaque chargée'))) {
            double dbComp = uneCompetence.pourcentage_degats + uneStat.valeur.toDouble();
            uneCompetence.pourcentage_degats = dbComp;
          }
          break;
        case 17:
          dPyro = (double.parse(dPyro) + uneStat.valeur.toDouble()).toString();
          break;
      }
    }

    for (ArtefactStatEffet uneStat in artefactStatEffet2) {
      switch (uneStat.type_statistiques_id) {
        case 2:
          double dbAtkP = double.parse(atkP) + uneStat.valeur.toDouble();
          atkP = dbAtkP.toString();
          break;
        case 7:
          double dbTc = double.parse(tc) + uneStat.valeur.toDouble();
          tc = dbTc.toString();
          break;
        case 8:
          double dbDc = double.parse(dc) + uneStat.valeur.toDouble();
          dc = dbDc.toString();
          break;
        case 11:
          double dbPhys = double.parse(dPhys) + uneStat.valeur.toDouble();
          dPhys = dbPhys.toString();
          break;
        case 12:
          dPyro = (double.parse(dPyro) + uneStat.valeur.toDouble()).toString();
          dHydro = (double.parse(dHydro) + uneStat.valeur.toDouble()).toString();
          dDendro = (double.parse(dDendro) + uneStat.valeur.toDouble()).toString();
          dElectro = (double.parse(dElectro) + uneStat.valeur.toDouble()).toString();
          dAnemo = (double.parse(dAnemo) + uneStat.valeur.toDouble()).toString();
          dCryo = (double.parse(dCryo) + uneStat.valeur.toDouble()).toString();
          dGeo = (double.parse(dGeo) + uneStat.valeur.toDouble()).toString();
          break;
        case 13:
          if(uneCompetence.typeCompetence == 1 && uneCompetence.personnage_competence_label.contains(RegExp(r'(DGT \der? coup)'))) {
            double dbComp = uneCompetence.pourcentage_degats + uneStat.valeur.toDouble();
            uneCompetence.pourcentage_degats = dbComp;
          }
          break;
        case 14:
          if(uneCompetence.typeCompetence == 1 && (uneCompetence.personnage_competence_label.contains('DGT Tir visé') || uneCompetence.personnage_competence_label.contains('DGT Attaque chargée'))) {
            double dbComp = uneCompetence.pourcentage_degats + uneStat.valeur.toDouble();
            uneCompetence.pourcentage_degats = dbComp;
          }
          break;
        case 17:
          dPyro = (double.parse(dPyro) + uneStat.valeur.toDouble()).toString();
          break;
      }
    }
  }

  calculeElementCompetence(Competences uneCompetence, double attaque){
    String elementComp;
    switch (selectedPersonnage.element.elementId) {
      case 1:
        elementComp = dHydro;
        break;
      case 2:
        elementComp = dHydro;
        break;
      case 3:
        elementComp = dHydro;
        break;
      case 4:
        elementComp = dHydro;
        break;
      case 5:
        elementComp = dHydro;
        break;
      case 6:
        elementComp = dHydro;
        break;
      case 7:
        elementComp = dHydro;
        break;
    }

    if(uneCompetence.typeCompetence == 1){
      totAtk = attaque * ((double.parse(dPhys) / 100) + 1) + ((uneCompetence.pourcentage_degats / 100) + 1);
    }else {
      totAtk = attaque * ((double.parse(elementComp) / 100) + 1) + ((uneCompetence.pourcentage_degats / 100) + 1);
    }
  }

  String resumeData(){
    return selectedPersonnage.nom + " ("+ pNiveau.nb_niveau.toString()+")"+ " | "+ selectedArme.nomArme + " ("+selectedRaffinement+":"+aNiveau.nb_niveau.toString()+")";
  }


  String get NomProfil => _NomProfil;

  set NomProfil(String value) {
    _NomProfil = value;
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


  Artefact get artefactSet1 => _artefactSet1;

  set artefactSet1(Artefact value) {
    _artefactSet1 = value;
  }


  List<ArtefactStatEffet> get artefactStatEffet1 => _artefactStatEffet1;

  set artefactStatEffet1(List<ArtefactStatEffet> value) {
    _artefactStatEffet1 = value;
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

  Artefact get artefactSet2 => _artefactSet2;

  set artefactSet2(Artefact value) {
    _artefactSet2 = value;
  }

  List<ArtefactStatEffet> get artefactStatEffet2 => _artefactStatEffet2;

  set artefactStatEffet2(List<ArtefactStatEffet> value) {
    _artefactStatEffet2 = value;
  }
}