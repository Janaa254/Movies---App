import 'package:flutter/material.dart';
import 'update_profile_screen.dart';
import 'watchlist_screen.dart';
import 'history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color bg = Color(0xFF09070F);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleDark = Color(0xFF24143D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildProfileHeader(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStats(),
                const SizedBox(height: 35),
                const Text(
                  'My Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMovieSection(
                  context,
                  title: 'Watchlist',
                  subtitle: 'Movies you want to watch',
                  icon: Icons.bookmark_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WatchlistScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),
                _buildMovieSection(
                  context,
                  title: 'Favorites',
                  subtitle: 'Your favorite movies',
                  icon: Icons.favorite_rounded,
                  onTap: () {},
                ),
                const SizedBox(height: 14),
                _buildMovieSection(
                  context,
                  title: 'History',
                  subtitle: 'Recently watched',
                  icon: Icons.history_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UpdateProfileScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: purple.withOpacity(.6),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF32165B),
                  Color(0xFF160D25),
                  bg,
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 45,
                  left: 25,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: purple.withOpacity(.12),
                    ),
                  ),
                ),
                Positioned(
                  right: -40,
                  top: 10,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: purple.withOpacity(.08),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          bg,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 8,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 155,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: purple,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: purple.withOpacity(.35),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 52,
                    backgroundColor: Color(0xFF1B1228),
                    child: Icon(
                      Icons.person,
                      size: 55,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            number: '0',
            label: 'Watchlist',
          ),
        ),
        Expanded(
          child: _StatItem(
            number: '0',
            label: 'Favorites',
          ),
        ),
        Expanded(
          child: _StatItem(
            number: '0',
            label: 'Watched',
          ),
        ),
      ],
    );
  }

  Widget _buildMovieSection(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 88,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF15111D),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: purpleDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: purple,
                size: 25,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white38,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({
    required this.number,
    required this.label,
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
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}