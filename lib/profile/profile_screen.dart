import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1115),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFF252832),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // User Name
            const Text(
              'User Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Email
            const Text(
              'user@email.com',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            // Update Profile
            _ProfileOption(
              icon: Icons.edit_outlined,
              title: 'Update Profile',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            // Watchlist
            _ProfileOption(
              icon: Icons.bookmark_border,
              title: 'Watchlist',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            // History
            _ProfileOption(
              icon: Icons.history,
              title: 'History',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF1A1D24),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,

              decoration: BoxDecoration(
                color: const Color(0xFF252832),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}