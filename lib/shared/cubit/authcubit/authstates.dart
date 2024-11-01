abstract class AuthStates {}

class LoginInitialState extends AuthStates {}

class ChangeEyePassword extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  dynamic error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  dynamic error;

  RegisterErrorState(this.error);
}

class UserCreateLoadingState extends AuthStates {}

class UserCreateErrorState extends AuthStates {}

class UserCreateSuccessState extends AuthStates {}

class SwitchToggleState extends AuthStates {}
