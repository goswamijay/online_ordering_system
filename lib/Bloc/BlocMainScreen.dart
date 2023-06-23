import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocSignupScreen/SignUpBloc/BlocSignUpCubit.dart';

import 'BlocLoginScreen/LoginPageCubit.dart';
import 'BlocLoginScreen/BlocLoginScreen.dart';
import 'BlocOTPScreen/OtpScreenCubit.dart';

class BlocMainScreen extends StatefulWidget {
  const BlocMainScreen({super.key});

  @override
  State<BlocMainScreen> createState() => _BlocMainScreenState();
}

class _BlocMainScreenState extends State<BlocMainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider (
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider (
          create: (BuildContext context) => BlocSignUpCubit(),
        ),
        BlocProvider (
          create: (BuildContext context) => OtpScreenCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(background: const Color.fromRGBO(246, 244, 244, 1)),
        ),
        home: const BlocLoginScreen(),
      ),
    );
  }
}
