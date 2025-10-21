import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/auth/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid: _isFormValid(event.email, state.password),
    ));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      isFormValid: _isFormValid(state.email, event.password),
    ));
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: LoginStatus.loading));

    final result = await _loginUseCase(email: state.email, password: state.password);

    result.fold(
      (error) => emit(state.copyWith(status: LoginStatus.failure, errorMessage: error)),
      (user) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }

  bool _isFormValid(String email, String password) {
    // Add your email and password validation logic here
    return email.isNotEmpty && password.isNotEmpty;
  }
}
