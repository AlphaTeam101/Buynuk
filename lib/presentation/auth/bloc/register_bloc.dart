import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onNameChanged(RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    // Mocking a network call
    await Future.delayed(const Duration(seconds: 2));
    if (state.name.isNotEmpty && state.email.contains('@') && state.password.length > 6) {
      emit(state.copyWith(status: RegisterStatus.success));
    } else {
      emit(state.copyWith(status: RegisterStatus.failure, errorMessage: 'Registration failed. Please check your details.'));
    }
  }
}
