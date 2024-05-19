import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../widgets/uk_text_button.dart';
import '../../widgets/uk_text_field.dart';
import 'login_vm.dart';

class LoginVU extends StackedView<LoginVM> {
  const LoginVU({super.key});

  @override
  Widget builder(BuildContext context, LoginVM viewModel, Widget? child) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          40.spaceY,
          UkTextField(
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.mail,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              ),
              keyBordType: TextInputType.emailAddress,
              onSaved: viewModel.onEmailSaved,
              validator: viewModel.emailValidator),
          12.spaceY,
          UkTextField(
              hintText: 'password',
              obsecureText: viewModel.obsecurePassword,
              suffixIcon: IconButton(
                  onPressed: () => viewModel.obsecureToggle(),
                  icon: Icon(
                    viewModel.iconPassword,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                  )),
              prefixIcon: Icon(
                Icons.password,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              ),
              onSaved: viewModel.onPasswordSaved,
              validator: viewModel.passwordValidator),
          12.spaceY,
          UkTextButton(
            text: viewModel.isBusy
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
            // label: 'Sign In',
            onPressed: () {
              viewModel.login(context);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }

  @override
  LoginVM viewModelBuilder(BuildContext context) => LoginVM();
}
