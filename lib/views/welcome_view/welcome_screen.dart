import 'dart:ui';

import 'package:flutter/material.dart';

import '../login_view/login_vu.dart';
import '../signup_view/signup_vu.dart';

class BackgroundVU extends StatefulWidget {
  const BackgroundVU({super.key});

  @override
  State<BackgroundVU> createState() => _BackgroundVUState();
}

class _BackgroundVUState extends State<BackgroundVU>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              children: [
                orangeContainer(context),
                pinkContainer(context),
                purpleContainer(context),
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container()),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 1.8,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: tabBar(context),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: const [
                                  LoginVU(),
                                  SignUpVU(),
                                ],
                              ),
                            )
                          ],
                        )))
              ],
            )),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      controller: tabController,
      unselectedLabelColor:
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      labelColor: Theme.of(context).colorScheme.onPrimary,
      labelStyle: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontWeight: FontWeight.w700),
      tabs: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Sign In',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget purpleContainer(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(2.7, -1.2),
      child: Container(
        height: MediaQuery.sizeOf(context).width / 1.3,
        width: MediaQuery.sizeOf(context).width / 1.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget pinkContainer(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-2.7, -1.2),
      child: Container(
        height: MediaQuery.sizeOf(context).width / 1.3,
        width: MediaQuery.sizeOf(context).width / 1.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget orangeContainer(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(20, -1.2),
      child: Container(
        height: MediaQuery.sizeOf(context).width,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
