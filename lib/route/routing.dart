import 'package:flutter/material.dart';
import 'package:genshin_android_app/models/Personnage.dart';
import 'package:genshin_android_app/views/firstStep.dart';
import 'package:genshin_android_app/views/savePage.dart';
import 'package:genshin_android_app/views/secondStep.dart';
import 'package:genshin_android_app/views/thirdStep.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => firstStepPage(
              paramOperation: args,
            ),
        );
      case '/second':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) =>
              secondStepPage(
                paramOperation: args,
              ),
        );
      case '/third':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) =>
              thirdStepPage(
                paramOperation: args,
              ),
        );
      case '/save':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) =>
              savePage(
                paramOperation: args,
              ),
        );

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erreur'),
        ),
        body: Center(
          child: Text('Erreur: la route est incorrecte'),
        ),
      );
    });
  }
}