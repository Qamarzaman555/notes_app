import 'package:notes/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../widgets/uk_text_button.dart';
import '../../widgets/uk_text_field.dart';
import 'signup_vm.dart';

class SignUpVU extends StackedView<SignUpVM> {
  const SignUpVU({super.key});

  @override
  Widget builder(BuildContext context, SignUpVM viewModel, Widget? child) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            40.spaceY,
            UkTextField(
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.mail,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
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
              validator: viewModel.passwordValidator,
              onChanged: viewModel.onChangedValue,
            ),
            12.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⚈  1 uppercase",
                      style: TextStyle(
                          color: viewModel.containsUpperCase
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5)),
                    ),
                    Text(
                      "⚈  1 lowercase",
                      style: TextStyle(
                          color: viewModel.containsLowerCase
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5)),
                    ),
                    Text(
                      "⚈  1 number",
                      style: TextStyle(
                          color: viewModel.containsNumber
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⚈  1 special character",
                      style: TextStyle(
                          color: viewModel.containsSpecialChar
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5)),
                    ),
                    Text(
                      "⚈  8 minimum character",
                      style: TextStyle(
                          color: viewModel.contains8Length
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5)),
                    ),
                  ],
                ),
              ],
            ),
            12.spaceY,
            UkTextField(
                hintText: 'Name',
                prefixIcon: Icon(
                  Icons.mail,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ),
                keyBordType: TextInputType.text,
                onSaved: viewModel.onNameSaved,
                validator: viewModel.nameValidator),
            12.spaceY,
            UkTextButton(
              label: 'Sign Up',
              onPressed: () {
                viewModel.signUp(context);
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }

  @override
  SignUpVM viewModelBuilder(BuildContext context) => SignUpVM();
}
