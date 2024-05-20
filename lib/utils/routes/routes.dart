import 'package:flutter/material.dart';
import 'package:notes/utils/routes/routes_name.dart';
import '../../views/forgot_password_view/forgot_password_vu.dart';
import '../../views/login_view/login_vu.dart';
import '../../views/signup_view/signup_vu.dart';
import '../../views/splash_view/splash_screen_vu.dart';
import '../../views/welcome_view/welcome_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginVU());
      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpVU());
      case RouteName.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const BackgroundVU());
      case RouteName.forgotPassScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordVU());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreenVU());

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
