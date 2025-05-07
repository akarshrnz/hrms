import 'package:flutter/material.dart';
import 'package:hrms/core/constants/Image_contsants.dart';
import '../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> profile = {
      'name': 'Akarsh Kk',
      'position': 'Senior Flutter Developer',
      'department': 'Mobile Development',
      'email': 'akarshkk510@gmail.com',
      'phone': '+91 9562565517',
      'joinDate': '2022-06-15',
      'imageUrl': ImageConstants.dummyImage,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(profile, context),
            const SizedBox(height: 24),
            _buildDetailsCard(profile, context),
            const SizedBox(height: 24),
            _buildSkillsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, String> profile, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.2), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              backgroundImage: NetworkImage(profile['imageUrl']!),
            ),
            const SizedBox(height: 16),
            Text(
              profile['name']!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              profile['position']!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(Map<String, String> profile, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileRow(context, icon: Icons.apartment, label: 'Department', value: profile['department']!),
            _divider(),
            _buildProfileRow(context, icon: Icons.email, label: 'Email', value: profile['email']!),
            _divider(),
            _buildProfileRow(context, icon: Icons.phone, label: 'Phone', value: profile['phone']!),
            _divider(),
            _buildProfileRow(context, icon: Icons.date_range, label: 'Join Date', value: profile['joinDate']!),
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 28, thickness: 1.2);

  Widget _buildSkillsCard(BuildContext context) {
    final skills = ['Flutter', 'Dart', 'Firebase', 'UI/UX Design', 'Bloc Pattern', 'REST APIs'];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: skills.map(_buildSkillChip).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: AppColors.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColors.primary.withOpacity(0.12),
      side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
