import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/email_draft.dart';
import '../../../../data/repositories/email_repository.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final EmailRepository repository;

  EmailBloc(this.repository) : super(EmailInitial()) {
    on<LoadEmails>(_onLoadEmails);
    on<AddEmail>(_onAddEmail);
    on<DeleteEmail>(_onDeleteEmail);
    
   
    add(LoadEmails());
  }

  Future<void> _onLoadEmails(LoadEmails event, Emitter<EmailState> emit) async {
    emit(EmailLoading());
    try {
      final emails = await repository.getAllEmails();
      emit(EmailLoaded(emails));
    } catch (e) {
      emit(EmailError(e.toString()));
    }
  }

  Future<void> _onAddEmail(AddEmail event, Emitter<EmailState> emit) async {
    try {
      await repository.saveEmail(event.email);
      add(LoadEmails());
    } catch (e) {
      emit(EmailError("Failed to save: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteEmail(DeleteEmail event, Emitter<EmailState> emit) async {
    try {
      await repository.deleteEmail(event.id);
      add(LoadEmails());
    } catch (e) {
      emit(EmailError("Failed to delete: ${e.toString()}"));
    }
  }
}