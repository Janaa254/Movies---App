import 'package:flutter/material.dart';
import 'update_profile_screen.dart';
import 'watchlist_screen.dart';
import 'history_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color background = Color(0xFF0B0B0F);
  static const Color purple = Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UpdateProfileScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            const CircleAvatar(
              radius: 55,
              backgroundColor: purple,
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Color(0xFF202027),
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                  size: 55,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'User Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'user@email.com',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _Stat(
                  number: '0',
                  title: 'Watchlist',
                ),
                _Stat(
                  number: '0',
                  title: 'Favorites',
                ),
                _Stat(
                  number: '0',
                  title: 'Watched',
                ),
              ],
            ),

            const SizedBox(height: 40),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Library',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _MenuItem(
              icon: Icons.bookmark_outline,
              title: 'Watchlist',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WatchlistScreen(),
                  ),
                );
              },
            ),

            _MenuItem(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FavoritesScreen(),
                  ),
                );
              },
            ),

            _MenuItem(
              icon: Icons.history,
              title: 'History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String number;
  final String title;

  const _Stat({
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      leading: Icon(
        icon,
        color: ProfileScreen.purple,
        size: 25,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white38,
      ),
    );
  }
}