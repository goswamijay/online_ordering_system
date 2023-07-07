import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocCubit/BlocAccountMainScreen/BlocAccountResetPasswordCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocCartMainScreen/BlocCartScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocProductMainScreen/BlocProductMainScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocSignupScreen/SignUpBloc/BlocSignUpCubit.dart';

import 'BlocFavoriteMainScreen/BlocFavoriteScreenCubit.dart';
import 'BlocLoginScreen/LoginPageCubit.dart';
import 'BlocOTPScreen/OtpScreenCubit.dart';
import 'BlocOrderPlaceMainScreen/BlocOrderPlaceScreenCubit.dart';
import 'BlocResetPasswordScreen/BlocResetPasswordCubit.dart';
import 'BlocSparseScreen.dart';

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
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BlocSignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => OtpScreenCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BlocProductMainScreenCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BlocCartScreenCubit(),
        ),
        BlocProvider(
            create: (BuildContext context) => BlocFavoriteScreenCubit()),
        BlocProvider(
            create: (BuildContext context) => BlocAccountResetPasswordCubit()),
        BlocProvider(
            create: (BuildContext context) => BlocOrderPlaceScreenCubit()),
        BlocProvider(
            create: (BuildContext context) => BlocResetPasswordCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(background: const Color.fromRGBO(246, 244, 244, 1)),
        ),
        home: const BlocSparseScreen(),
      ),
    );
  }
}
