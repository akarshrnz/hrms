part of 'email_bloc.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  final List<EmailDraft> emails;

  const EmailLoaded(this.emails);

  @override
  List<Object> get props => [emails];
}

class EmailError extends EmailState {
  final String message;

  const EmailError(this.message);

  @override
  List<Object> get props => [message];
}