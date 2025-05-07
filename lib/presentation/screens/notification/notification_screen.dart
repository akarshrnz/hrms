import 'package:flutter/material.dart';
import 'package:hrms/core/constants/app_colors.dart';
import 'package:hrms/domain/entities/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy notifications data
     List<NotificationModel> notifications = [
       NotificationModel(
        id: 1,
        title: 'New Message',
        message: 'You have received a new message from John',
        date: '10:30 AM',
        isRead: false,
      ),
      NotificationModel(
        id: 2,
        title: 'Meeting Reminder',
        message: 'Team meeting at 2:00 PM today',
        date: 'Yesterday',
        isRead: true,
      ),
      NotificationModel(
        id: 3,
        title: 'System Update',
        message: 'New system update available',
        date: 'May 10',
        isRead: false,
      ),
      NotificationModel(
        id: 4,
        title: 'Payment Received',
        message: 'Your payment of \$250 has been processed',
        date: 'May 8',
        isRead: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              // Dummy mark all as read functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read')),
              );
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Dummy delete functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notification ${notification.id} deleted')),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notification.isRead
                          ? Colors.grey[200]
                          : AppColors.primary,
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      notification.title ?? '',
                      style: TextStyle(
                        fontWeight: notification.isRead 
                            ? FontWeight.normal 
                            : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.message ?? ''),
                        const SizedBox(height: 4),
                        Text(
                          notification.date ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Dummy mark as read functionality
                      if (!notification.isRead) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Notification ${notification.id} marked as read')),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}