import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocSignUpPage/Bloc/signUpEvent.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';

import '../../BlocRegisterOTPScreen/RegisterOTPScreen.dart';
import '../Bloc/signUpBloc.dart';
import '../signUpPage.dart';
import '../Bloc/signUpState.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpBloc blocSignupController = BlocProvider.of<SignUpBloc>(context);

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (BuildContext context, state) {
        if (state is SignUpUserState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.loginStateMessage)));
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return  BlocOTPScreen(
              signUpEmail: Repo.blocSignupModelClass.data.emailId, signUpId: Repo.blocSignupModelClass.data.id, signUpPassword: signupPasswordController.text,
            );
          }));
        } else if (state is SignUpUserFailState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.loginFailStateError)));
        }
      },
      builder: (BuildContext context, state) {
        if (state is SignUpUserLoadingState) {
          return const CircularProgressIndicator();
        }
        return InkWell(
          onTap: () {
            try {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<SignUpBloc>(context).add(SignUpButtonPressEvent(signupEmailController.text,
                    signupPasswordController.text,
                    signupNameController.text,
                    signupMobileController.text)
                    );
              }
            } catch (e) {
              print(e);
            }
          },
          child: Container(
            height: 50,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: const Text(
              "SignUp",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}