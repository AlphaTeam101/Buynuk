import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/profile/widgets/profile_header.dart';
import 'package:e_commerce/presentation/profile/widgets/settings_list_item.dart';
import 'package:e_commerce/presentation/profile/widgets/settings_section.dart';
import 'package:e_commerce/presentation/profile/widgets/settings_toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: const ProfileHeader()
                    .animate()
                    .fade(duration: 500.ms)
                    .slideY(begin: -0.2)),
            SliverToBoxAdapter(
              child: SettingsSection(
                title: "Account Settings",
                items: [
                  SettingsListItem(
                    icon: Icons.location_on_outlined,
                    label: "Addresses",
                    onTap: () {
                      // TODO: Navigate to Addresses screen
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Addresses tapped")));
                    },
                  ),
                  SettingsListItem(
                    icon: Icons.phone_outlined,
                    label: "Phone Numbers",
                    onTap: () {
                      // TODO: Navigate to Phone Numbers screen
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Phone Numbers tapped")));
                    },
                  ),
                  SettingsListItem(
                    icon: Icons.person_outline,
                    label: "Account Information",
                    onTap: () {
                      // TODO: Navigate to Account Information screen
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Account Information tapped")));
                    },
                  ),
                ],
              )
                  .animate(delay: 100.ms) // Changed from interval to delay
                  .fade(duration: 500.ms)
                  .slideX(begin: 0.3, curve: Curves.easeOutCubic),
            ),
            SliverToBoxAdapter(
              child: SettingsSection(
                title: "App Settings",
                items: [
                  SettingsToggleItem(
                    icon: Icons.notifications_none,
                    label: "Notifications",
                    value: true, // Example value
                    onChanged: (value) {
                      // TODO: Handle notification toggle
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Notifications toggled to $value")));
                    },
                  ),
                  // Removed Language option as per request
                ],
              )
                  .animate(delay: 200.ms) // Changed from interval to delay
                  .fade(duration: 500.ms)
                  .slideX(begin: 0.3, curve: Curves.easeOutCubic),
            ),
            SliverToBoxAdapter(
              child: SettingsSection(
                title: "Support",
                items: [
                  SettingsListItem(
                    icon: Icons.contact_support_outlined,
                    label: "Contact Us",
                    onTap: () {
                      // TODO: Navigate to Contact Us screen
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact Us tapped")));
                    },
                  ),
                  SettingsListItem(
                    icon: Icons.help_outline,
                    label: "FAQ",
                    onTap: () {
                      // TODO: Navigate to FAQ screen
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("FAQ tapped")));
                    },
                  ),
                ],
              )
                  .animate(delay: 300.ms) // Changed from interval to delay
                  .fade(duration: 500.ms)
                  .slideX(begin: 0.3, curve: Curves.easeOutCubic),
            ),
            SliverToBoxAdapter(
                child: const _LogoutButton()
                    .animate(delay: 400.ms) // Changed from interval to delay
                    .fade(duration: 500.ms)
                    .slideX(begin: 0.3, curve: Curves.easeOutCubic)),
            const SliverToBoxAdapter(child: SizedBox(height: 32.0)), // Add some bottom padding
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Use colorScheme

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface, // Use colorScheme.surface
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SettingsListItem(
          icon: Icons.logout,
          label: "Log Out",
          onTap: () {
            // TODO: Implement logout logic
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Log Out tapped")));
          },
          labelColor: colorScheme.error, // Use colorScheme.error
          iconColor: colorScheme.error, // Use colorScheme.error
        ),
      ),
    );
  }
}
