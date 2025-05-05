import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/core/data/repositories/employee_repository.dart';
import 'package:hrms/core/navigation/app_router.dart';
import 'package:hrms/core/theme/app_theme.dart';
import 'package:hrms/features/employee/bloc/employee_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeBloc(
            employeeRepository: EmployeeRepository(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'HRMS',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
