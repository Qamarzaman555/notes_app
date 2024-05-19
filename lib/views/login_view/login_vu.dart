import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/routes_name.dart';
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
          4.spaceY,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.forgotPassScreen);
                },
                child: Text(
                  'forgot password? Click here  ',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.black.withOpacity(0.7)),
                )),
          ),
          12.spaceY,
          UkTextButton(
            text: const Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
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
