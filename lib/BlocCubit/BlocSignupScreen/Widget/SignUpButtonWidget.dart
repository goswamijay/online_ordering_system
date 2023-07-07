import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocCubit/BlocOTPScreen/BlocOTPScreen.dart';

import '../../BlocSparceScreen/Bloc_Splash_Screen.dart';
import '../SignUpBloc/BlocSignUpCubit.dart';
import '../BlocSignupScreen.dart';
import '../SignUpBloc/BlocSignupState.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocSignUpCubit blocSignupController = BlocProvider.of<BlocSignUpCubit>(context);

    return BlocConsumer<BlocSignUpCubit, SignUpState>(
      listener: (BuildContext context, state) {
        if (state is SignUpUserState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.loginStateMessage)));
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return  BlocOTPScreen(
              signUpEmail: blocSignupController.blocSignupModelClass.data.emailId, signUpId: blocSignupController.blocSignupModelClass.data.id, signUpPassword: signupPasswordController.text,
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
                BlocProvider.of<BlocSignUpCubit>(context).getSignUpUser(
                    signupEmailController.text,
                    signupPasswordController.text,
                    signupNameController.text,
                    signupMobileController.text);
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
