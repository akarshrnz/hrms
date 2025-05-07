part of 'email_bloc.dart';

abstract class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}

class LoadEmails extends EmailEvent {}

class AddEmail extends EmailEvent {
  final EmailDraft email;

  const AddEmail(this.email);

  @override
  List<Object> get props => [email];
}

class DeleteEmail extends EmailEvent {
  final int id;

  const DeleteEmail(this.id);

  @override
  List<Object> get props => [id];
}