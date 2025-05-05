import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms/core/data/models/employee_model.dart';
import 'package:hrms/features/employee/presentation/screens/employee_form_screen.dart';
import 'package:hrms/features/employee/presentation/screens/employee_list_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'employees',
        builder: (context, state) => const EmployeeListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'add_employee',
            builder: (context, state) => const EmployeeFormScreen(),
          ),
        GoRoute(
  path: 'edit',
  name: 'edit_employee',
  builder: (context, state) {
    final employee = state.extra as Employee;
    return EmployeeFormScreen(employee: employee);
  },
)
        ],
      ),
    ],
  );
}