import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/leave_repository.dart';
import '../../../domain/entities/leave.dart';
import 'leave_event.dart';
import 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LeaveRepository _leaveRepository;

  LeaveBloc(this._leaveRepository) : super(LeaveInitial()) {
    on<GetLeaves>(_onGetLeaves);
    on<AddLeave>(_onAddLeave);
    on<UpdateLeave>(_onUpdateLeave);
    on<DeleteLeave>(_onDeleteLeave);
  }

  Future<void> _onGetLeaves(GetLeaves event, Emitter<LeaveState> emit) async {
    try {
      emit(LeaveLoading());
      final leaves = await _leaveRepository.getLeaves();
      emit(LeaveLoaded(leaves: leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> _onAddLeave(AddLeave event, Emitter<LeaveState> emit) async {
    try {
      emit(LeaveLoading());
      final leave = Leave(
        startDate: event.startDate,
        endDate: event.endDate,
        reason: event.reason,
        type: event.type,
        status: 'pending',
        createdAt: DateTime.now().toIso8601String(),
      );
      await _leaveRepository.insertLeave(leave);
      final leaves = await _leaveRepository.getLeaves();
      emit(LeaveLoaded(leaves: leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> _onUpdateLeave(UpdateLeave event, Emitter<LeaveState> emit) async {
    try {
      emit(LeaveLoading());
      final leave = Leave(
        id: event.id,
        startDate: event.startDate,
        endDate: event.endDate,
        reason: event.reason,
        type: event.type,
        status: 'pending',
      );
      await _leaveRepository.updateLeave(leave);
      final leaves = await _leaveRepository.getLeaves();
      emit(LeaveLoaded(leaves: leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> _onDeleteLeave(DeleteLeave event, Emitter<LeaveState> emit) async {
    try {
      emit(LeaveLoading());
      await _leaveRepository.deleteLeave(event.id);
      final leaves = await _leaveRepository.getLeaves();
      emit(LeaveLoaded(leaves: leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }
}