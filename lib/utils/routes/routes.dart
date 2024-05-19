import 'package:flutter/material.dart';
import 'package:notes/utils/routes/routes_name.dart';
import '../../views/login_view/login_vu.dart';
import '../../views/signup_view/signup_vu.dart';
import '../../widgets/background_vu.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginVU());
      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpVU());
      case RouteName.backgroundScreen:
        return MaterialPageRoute(builder: (_) => const BackgroundVU());
      // case RouteName.homeScreen:
      //   return MaterialPageRoute(builder: (_) => const HomeVU());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
