import 'package:flutter/material.dart';
import '../../services/splash_services.dart';

class SplashScreenVU extends StatefulWidget {
  const SplashScreenVU({super.key});

  @override
  State<SplashScreenVU> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenVU> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      child: SafeArea(
          child: Container(
        height: MediaQuery.sizeOf(context).height / 2,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'Notes App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      )),
    );
  }
}
