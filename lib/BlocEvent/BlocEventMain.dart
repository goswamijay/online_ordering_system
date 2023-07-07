import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocAccountMainScreen/Bloc/BlocAccountResetPasswordBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocOrderPlaceMainScreen/Bloc/BlocOrderPlaceMainBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocRegisterOTPScreen/Bloc/RegisterOTPBLoc.dart';
import 'package:online_ordering_system/BlocEvent/BlocResetPasswordMainScreen/Bloc/BlocResetPasswordMainBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocSparseScreen.dart';

import '../BlocEvent/BlocLogin/Bloc/loginpage_bloc.dart';
import '../BlocEvent/BlocSignUpPage/Bloc/signUpBloc.dart';

class BlocEventMain extends StatelessWidget {
  const BlocEventMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => RegisterOTPBloc()),
          BlocProvider(create: (context) => ProductMainScreenBloc()),
          BlocProvider(create: (context) => CartMainScreenBloc()),
          BlocProvider(create: (context) => FavouriteScreenBloc()),
          BlocProvider(create: (context) => BlocAccountResetPasswordBloc()),
          BlocProvider(create: (context) => BlocOrderPlaceMainBloc()),
          BlocProvider(create: (context) => BlocResetPasswordMainBloc()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const BlocSparseScreen()));
  }
}
