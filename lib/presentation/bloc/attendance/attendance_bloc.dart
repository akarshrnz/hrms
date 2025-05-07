import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/attendance_repository.dart';
import '../../../domain/entities/attendance.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _attendanceRepository;

  AttendanceBloc(this._attendanceRepository) : super(AttendanceInitial()) {
    on<GetAttendances>(_onGetAttendances);
    on<GetTodayAttendance>(_onGetTodayAttendance);
    on<CheckIn>(_onCheckIn);
    on<CheckOut>(_onCheckOut);
  }

  Future<void> _onGetAttendances(GetAttendances event, Emitter<AttendanceState> emit) async {
    try {
      emit(AttendanceLoading());
      final attendances = await _attendanceRepository.getAttendances();
      final todayAttendance = await _attendanceRepository.getTodayAttendance();
      emit(AttendanceLoaded(attendances: attendances, todayAttendance: todayAttendance));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> _onGetTodayAttendance(GetTodayAttendance event, Emitter<AttendanceState> emit) async {
    try {
      emit(AttendanceLoading());
      final todayAttendance = await _attendanceRepository.getTodayAttendance();
      final attendances = await _attendanceRepository.getAttendances();
      emit(AttendanceLoaded(attendances: attendances, todayAttendance: todayAttendance));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> _onCheckIn(CheckIn event, Emitter<AttendanceState> emit) async {
    try {
      emit(AttendanceLoading());
      final attendance = Attendance(
        date: event.date,
        checkIn: event.time,
        status: 'present',
      );
      await _attendanceRepository.insertAttendance(attendance);
      final attendances = await _attendanceRepository.getAttendances();
      final todayAttendance = await _attendanceRepository.getTodayAttendance();
      emit(AttendanceLoaded(attendances: attendances, todayAttendance: todayAttendance));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> _onCheckOut(CheckOut event, Emitter<AttendanceState> emit) async {
    try {
      emit(AttendanceLoading());
      final todayAttendance = await _attendanceRepository.getTodayAttendance();
      if (todayAttendance != null) {
        final updatedAttendance = Attendance(
          id: todayAttendance.id,
          date: event.date,
          checkIn: todayAttendance.checkIn,
          checkOut: event.time,
          status: 'completed',
        );
        await _attendanceRepository.updateAttendance(updatedAttendance);
        final attendances = await _attendanceRepository.getAttendances();
        emit(AttendanceLoaded(attendances: attendances, todayAttendance: updatedAttendance));
      } else {
        emit(AttendanceError('No check-in record found for today'));
      }
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}