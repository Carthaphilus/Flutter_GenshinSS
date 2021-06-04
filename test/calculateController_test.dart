import 'package:flutter_test/flutter_test.dart';
import 'package:genshin_android_app/models/ArmeNiveau.dart';
import 'package:genshin_android_app/models/ArmeType.dart';
import 'package:genshin_android_app/models/Armes.dart';
import 'package:genshin_android_app/models/Competences.dart';
import 'package:genshin_android_app/models/Elements.dart';
import 'package:genshin_android_app/models/Niveau.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/controller/calculateController.dart';
import 'package:genshin_android_app/models/PersonnageNiveau.dart';
import 'package:genshin_android_app/models/Artefact.dart';
import 'package:genshin_android_app/models/ArtefactStatEffet.dart';

void main(){

  final calculateController operation = new calculateController();

  ArmeType unArmetype = new ArmeType(1, 'Épée à une main');
  Elements unElement = new Elements(1, 'Hydro');
  operation.selectedPersonnage = new Personnage(31, "Xingqiu", 4, 'Character_Xingqiu_Thumb.jpg', unArmetype, unElement);
  operation.pNiveau = new Niveau(7, 80);
  operation.selectedArme = new Armes(30, 'Épée de Favonius', '', 4);
  operation.aNiveau  = new Niveau(1, 1);
  operation.personnageNiveau = new PersonnageNiveau(7, '-', 179, 9060, 671);
  operation.armeNiveau = new ArmeNiveau(14, 41, "13.3% Recharge d\'énergie");
  operation.artefactSet1 = new Artefact(21,2,"Rideau du Gladiateur","Augmente l'ATQ de 18 %");
  operation.artefactSet2 =  new Artefact(22,4,"Rideau du Gladiateur","Augmente les DGT infligés par les attaques normales de 35 % lorsque ce set d'artéfacts est équipé par les personnages maniant une épée à une ou deux mains ou une arme d'hast.");
  operation.artefactStatEffet1 = [new ArtefactStatEffet(1, 18, 2)];
  operation.artefactStatEffet2 = [new ArtefactStatEffet(2, 35, 13)];

  Competences competence1 = new Competences(57, 'DGT 1er coup', 1, 46.6);
  Competences competence2 = new Competences(59, 'DGT 2e coup', 1, 47.6);
  Competences competence3 = new Competences(60, 'DGT 3e coup', 1, 58.2);
  Competences competence4 = new Competences(61, 'DGT 4e coup', 1, 56);
  Competences competence5 = new Competences(62, 'DGT 5e coup', 1, 71.8);
  Competences competence6 = new Competences(63, 'DGT Attaque chargée', 1, 103.5);
  Competences competence7 = new Competences(64, 'DGT durant la chute', 1, 63.9);
  Competences competence8 = new Competences(65, 'DGT Chute basse', 1, 128);
  Competences competence9 = new Competences(66, 'DGT Chute élevée', 1, 160);
  Competences competenceElemetnaire = new Competences(67, 'Epée Guhua : Pluie battante', 6, 503);
  Competences dechaineElementaire = new Competences(68, 'Epée Guhua : Pluie et arc-en-ciel', 10, 97.7);

  operation.pvMax = '0';
  operation.atk = '0';
  operation.atkP = '0';
  operation.def = '0';
  operation.me = '0';
  operation.tc = '0';
  operation.dc = '0';
  operation.dPyro = '0';
  operation.dHydro = '0';
  operation.dDendro = '0';
  operation.dElectro = '0';
  operation.dAnemo = '0';
  operation.dCryo = '0';
  operation.dGeo = '0';
  operation.dPhys = '0';


  test('Teste du calcule des degats', (){
    operation.Calculstat(competence1);
    expect(operation.totAtk, 261.066);
    expect(operation.totAtkCrit, 261.066);
  });
}
