import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/database_helper.dart';
import 'data/repositories/attendance_repository.dart';
import 'data/repositories/leave_repository.dart';
import 'data/repositories/email_repository.dart';
import 'presentation/bloc/attendance/attendance_bloc.dart';
import 'presentation/bloc/leave/leave_bloc.dart';
import 'presentation/bloc/profile/email_bloc.dart';
import 'presentation/screens/dashbord/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();
  
  runApp(MyApp(databaseHelper: databaseHelper));
}

class MyApp extends StatelessWidget {
  final DatabaseHelper databaseHelper;
  
  const MyApp({super.key, required this.databaseHelper});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AttendanceRepository(databaseHelper),
        ),
        RepositoryProvider(
          create: (context) => LeaveRepository(databaseHelper),
        ),
        RepositoryProvider(
          create: (context) => EmailRepository(databaseHelper),
        ),
        // RepositoryProvider(
        //   create: (context) => NotificationRepository(databaseHelper),
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AttendanceBloc(
              RepositoryProvider.of<AttendanceRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => LeaveBloc(
              RepositoryProvider.of<LeaveRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => EmailBloc(EmailRepository(databaseHelper)),
          ),
        ],
        child: MaterialApp(
          title: 'HRMS',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const DashboardScreen(),
        ),
      ),
    );
  }
}
