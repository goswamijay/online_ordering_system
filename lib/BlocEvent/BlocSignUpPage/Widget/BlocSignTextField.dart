import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/signUpBloc.dart';
import '../Bloc/signUpEvent.dart';
import '../signUpPage.dart';
import '../Bloc/signUpState.dart';
import 'CustomSignUpField.dart';

class BlocSignUpTextFiled extends StatelessWidget {
  const BlocSignUpTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSignUpField(
          key: const Key('Sign_up_user_name'),
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
          key: const Key('Sign_up_email_id'),
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
          key: const Key('Sign_up_mobile_number'),
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
          key: const Key('Sign_up_password'),
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
        BlocConsumer<SignUpBloc, SignUpState>(
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
                key: const Key('Sign_up_Re_password'),
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SignUpBloc>().add(SignUpPasswordShowEvent(passwordVisible));
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