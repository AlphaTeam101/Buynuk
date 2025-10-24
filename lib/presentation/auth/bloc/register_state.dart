part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String name;
  final String email;
  final String password;
  final String errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.errorMessage = '',
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? name,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, name, email, password, errorMessage];
}
