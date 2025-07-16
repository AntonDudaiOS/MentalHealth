import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop()
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final UserModel? user = state.user;

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              if (user != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Signed in as: ${user.displayName ?? "User"}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              _buildListTile(
                title: 'Profile',
                icon: Icons.person,
                onTap: () => context.push('/settings/profile'),
              ),
              _buildListTile(
                title: 'Notifications',
                icon: Icons.notifications,
                onTap: () => context.push('/settings/notifications'),
              ),
              _buildListTile(
                title: 'Privacy',
                icon: Icons.privacy_tip,
                onTap: () => context.push('/settings/privacy'),
              ),
              _buildListTile(
                title: 'Info',
                icon: Icons.info,
                onTap: () => context.push('/settings/info'),
              ),
              _buildListTile(
                title: 'Logout',
                icon: Icons.logout,
                textColor: Colors.red,
                onTap: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1A1B1C), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: textColor),
          title: Text(title, style: TextStyle(color: textColor)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}
