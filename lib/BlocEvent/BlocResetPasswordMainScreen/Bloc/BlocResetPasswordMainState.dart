abstract class BlocResetPasswordMainState {}

class BlocResetPasswordEmailInitialState extends BlocResetPasswordMainState {}

class BlocResetPasswordEmailLoadingState extends BlocResetPasswordMainState {}

class BlocResetPasswordEmailSentSuccessfullyState
    extends BlocResetPasswordMainState {}

class BlocResetPasswordEmailSentFailState extends BlocResetPasswordMainState {}

class BlocResetPasswordLoadingState extends BlocResetPasswordMainState {}

class BlocResetPasswordVerifiedSuccessfullyState
    extends BlocResetPasswordMainState {}

class BlocResetPasswordVerifiedFailState extends BlocResetPasswordMainState {}

class BlocResetPasswordResendOTPLoadingState
    extends BlocResetPasswordMainState {}

class BlocResetPasswordResendOTPSuccessfullyState
    extends BlocResetPasswordMainState {}

class BlocResetPasswordResendOTPFailState extends BlocResetPasswordMainState {}
