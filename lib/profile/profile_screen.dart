import 'package:flutter/material.dart';
import 'update_profile_screen.dart';
import 'watchlist_screen.dart';
import 'history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFF080B10);
  static const Color cardColor = Color(0xFF11161D);
  static const Color accentColor = Color(0xFF19E6D2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Column(
                children: [
                  const SizedBox(height: 75),

                  const Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'user@email.com',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 25),

                  _buildStatistics(),

                  const SizedBox(height: 28),

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

                  _buildLibraryGrid(context),

                  const SizedBox(height: 20),

                  _buildUpdateProfileButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 155,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF111C25),
                Color(0xFF0A1017),
                Color(0xFF152B2D),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 25,
                right: 25,
                child: Icon(
                  Icons.movie_creation_outlined,
                  size: 75,
                  color: accentColor.withOpacity(0.10),
                ),
              ),

              Positioned(
                left: -15,
                bottom: -20,
                child: Icon(
                  Icons.movie_filter_outlined,
                  size: 110,
                  color: Colors.white.withOpacity(0.035),
                ),
              ),

              Positioned(
                right: 90,
                top: 40,
                child: Container(
                  width: 100,
                  height: 2,
                  color: accentColor.withOpacity(0.20),
                ),
              ),

              Positioned(
                right: 45,
                top: 75,
                child: Container(
                  width: 55,
                  height: 2,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),

              Positioned(
                left: 30,
                top: 35,
                child: Container(
                  width: 130,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        accentColor.withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 45,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -58,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accentColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.18),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 54,
                  backgroundColor: Color(0xFF171E26),
                  child: Icon(
                    Icons.person,
                    size: 58,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.bookmark_rounded,
            number: '0',
            label: 'Watchlist',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _StatCard(
            icon: Icons.favorite_rounded,
            number: '0',
            label: 'Favorites',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _StatCard(
            icon: Icons.history_rounded,
            number: '0',
            label: 'History',
          ),
        ),
      ],
    );
  }

  Widget _buildLibraryGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _LibraryCard(
                icon: Icons.bookmark_rounded,
                title: 'Watchlist',
                subtitle: 'Saved movies',
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF102B30),
                    Color(0xFF0D171D),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WatchlistScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _LibraryCard(
                icon: Icons.favorite_rounded,
                title: 'Favorites',
                subtitle: 'Loved movies',
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF241820),
                    Color(0xFF121317),
                  ],
                ),
                onTap: () {
                  // Favorites screen will be connected later.
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _LibraryCard(
          icon: Icons.history_rounded,
          title: 'History',
          subtitle: 'Recently watched',
          gradient: const LinearGradient(
            colors: [
              Color(0xFF182331),
              Color(0xFF101419),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUpdateProfileButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ),
          );
        },
        icon: const Icon(
          Icons.edit_outlined,
          color: accentColor,
        ),
        label: const Text(
          'Update Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: accentColor.withOpacity(0.45),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String label;

  const _StatCard({
    required this.icon,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: ProfileScreen.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: ProfileScreen.accentColor,
            size: 22,
          ),

          const SizedBox(height: 7),

          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  const _LibraryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 125,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.06),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -15,
                bottom: -20,
                child: Icon(
                  icon,
                  size: 95,
                  color: Colors.white.withOpacity(0.035),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: ProfileScreen.accentColor,
                      size: 27,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}