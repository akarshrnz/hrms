import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/presentation/screens/profile/profile_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/attendance_repository.dart';
import '../../bloc/attendance/attendance_bloc.dart';
import '../../bloc/attendance/attendance_event.dart';
import '../../bloc/attendance/attendance_state.dart';
import '../attendance/attendance_history_screen.dart';
import '../leave/leave_screen.dart';
import '../notification/notification_screen.dart';
import '../mail/email_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(
        RepositoryProvider.of<AttendanceRepository>(context),
      )..add(GetTodayAttendance()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HRMS Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeCard(context),
                const SizedBox(height: 24),
                _buildAttendanceCard(context),
                const SizedBox(height: 24),
                _buildGridMenu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good ${_getTimeOfDay()}!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back to your HRMS portal',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Today\'s Attendance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                if (state is AttendanceLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: CircularProgressIndicator(),
                  )
                else if (state is AttendanceLoaded)
                  Column(
                    children: [
                      _buildAttendanceStatus(context, state.todayAttendance),
                      const SizedBox(height: 24),
                      _buildAttendanceButton(context, state.todayAttendance),
                    ],
                  )
                else if (state is AttendanceError)
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceStatus(BuildContext context, todayAttendance) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Check In:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              todayAttendance?.checkIn ?? '--:--',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Check Out:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              todayAttendance?.checkOut ?? '--:--',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          DateTime.now().toString().split('.')[0],
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildAttendanceButton(BuildContext context, todayAttendance) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final now = DateTime.now();
          final date = now.toString().split(' ')[0];
          final time = now.toString().split(' ')[1].split('.')[0];
          if (todayAttendance?.checkIn == null) {
            context.read<AttendanceBloc>().add(
                  CheckIn(date: date, time: time),
                );
          } else if (todayAttendance?.checkOut == null) {
            context.read<AttendanceBloc>().add(
                  CheckOut(date: date, time: time),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:(todayAttendance?.checkIn!=null && todayAttendance?.checkOut!=null)?AppColors.onPrimary.withOpacity(.2):      todayAttendance?.checkIn == null ? AppColors.onPrimary:AppColors.red
,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          todayAttendance?.checkIn == null ? 'Check In' : 'Check Out',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.onPrimary,
              ),
        ),
      ),
    );
  }

  Widget _buildGridMenu(BuildContext context) {
    final menuItems = [
      {
        'title': 'Leave Tracker',
        'icon': Icons.calendar_month_outlined,
        'color': Colors.blue,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LeaveScreen()),
            ),
      },
      {
        'title': 'Email',
        'icon': Icons.email_outlined,
        'color': Colors.green,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmailScreen()),
            ),
      },
      {
        'title': 'Attendance History',
        'icon': Icons.history_outlined,
        'color': Colors.orange,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AttendanceHistoryScreen()),
            ),
      },
      {
        'title': 'Profile',
        'icon': Icons.person_outline,
        'color': Colors.purple,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: menuItems.map((item) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: item['onTap'] as void Function(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      size: 28,
                      color: item['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['title'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}