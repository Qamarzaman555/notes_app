import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/uk_text_button.dart';
import '../../widgets/uk_text_field.dart';
import 'forgot_password_vm.dart';

class ForgotPasswordVU extends StackedView<ForgotPasswordVM> {
  const ForgotPasswordVU({super.key});

  @override
  Widget builder(
      BuildContext context, ForgotPasswordVM viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
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
                      height: MediaQuery.sizeOf(context).height / 2.1,
                      child: Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Enter your email \nto recover your password',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          60.spaceY,
                          UkTextField(
                              hintText: 'Enter your email',
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                              ),
                              keyBordType: TextInputType.emailAddress,
                              onSaved: viewModel.onEmailSaved,
                              validator: viewModel.emailValidator),
                          20.spaceY,
                          UkTextButton(
                            text: const Text(
                              'Send',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: viewModel.isBusy
                                ? null
                                : () {
                                    viewModel.forgotPassword(context);
                                  },
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
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

  @override
  ForgotPasswordVM viewModelBuilder(BuildContext context) => ForgotPasswordVM();
}
