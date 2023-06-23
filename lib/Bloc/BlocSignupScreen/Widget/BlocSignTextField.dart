import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SignUpBloc/BlocSignUpCubit.dart';
import '../BlocSignupScreen.dart';
import '../SignUpBloc/BlocSignupState.dart';
import 'CustomSignUpField.dart';

class BlocSignUpTextFiled extends StatelessWidget {
  const BlocSignUpTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSignUpField(
          hintText: "User Name",
          labelText: "User Name",
          controller: signupNameController,
          textInputType: TextInputType.text,
          onChanged: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return "User Name can't empty";
            }
            return null;
          },
        ),
        CustomSignUpField(
          hintText: "Email Id",
          labelText: "Email Id",
          controller: signupEmailController,
          textInputType: TextInputType.text,
          onChanged: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return "Email Id can't empty";
            } else {
              String emailExp =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              RegExp regExp = RegExp(emailExp);
              if (regExp.hasMatch(value)) {
              } else {
                return "Please Enter Valid Email";
              }
            }
            return null;
          },
        ),
        CustomSignUpField(
          hintText: "Mobile Number",
          labelText: "Mobile Number",
          controller: signupMobileController,
          textInputType: TextInputType.number,
          onChanged: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return "Mobile Number can't empty";
            } else if (value.length < 10 || value.length > 10) {
              return "Mobile number is not valid";
            }
            return null;
          },
        ),
        CustomSignUpField(
          hintText: "Enter Password",
          labelText: "Password",
          controller: signupPasswordController,
          textInputType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password can't empty";
            } else if (value.length < 6) {
              return "Password is less than 6 letter";
            }
            return null;
          },
          onChanged: (value) {
            value = password1;
          },
        ),
        BlocConsumer<BlocSignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is PasswordShowSignUpState) {
              passwordVisible = state.passwordVisible;
              print(passwordVisible);
            } else if (state is PasswordHideSignUpState) {
              passwordVisible = state.passwordHide;
              print(passwordVisible);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: TextFormField(
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (state is PasswordShowSignUpState) {
                        BlocProvider.of<BlocSignUpCubit>(context)
                            .passwordHide(passwordVisible);
                      } else if (state is PasswordHideSignUpState) {
                        BlocProvider.of<BlocSignUpCubit>(context)
                            .passwordShowing(passwordVisible);
                      }
                    },
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can't be empty";
                  } else if (value.length < 6) {
                    return "Password is less than 6 characters";
                  } else if (value != signupPasswordController.text) {
                    return "Both Password Does not Matched";
                  }
                  return null;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
