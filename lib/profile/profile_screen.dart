import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';

import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

import '../features/search/screens/search_screen.dart';
import '../features/browse/screens/browse_screen.dart';

import '../data/services/favorite_service.dart';
import '../data/services/watchlist_service.dart';

import 'avatar_picker.dart';
import 'profile_colors.dart';
import 'update_profile_screen.dart';

import 'tabs/watchlist_tab.dart';
import 'tabs/history_tab.dart';
import 'tabs/favorites_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedAvatar = 0;
  bool isLoadingAvatar = true;

  // 0 = Watch List
  // 1 = History
  // 2 = Favorites
  int selectedSection = 0;

  final FavoriteService favoriteService = FavoriteService();
  final WatchlistService watchlistService = WatchlistService();

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  // ============================================================
  // LOAD AVATAR
  // ============================================================

  Future<void> loadAvatar() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          isLoadingAvatar = false;
        });
      }

      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      final data = doc.data();
      final avatarIndex = data?['avatarIndex'];

      if (avatarIndex is int &&
          avatarIndex >= 0 &&
          avatarIndex < AvatarPicker.allAvatars.length) {
        setState(() {
          selectedAvatar = avatarIndex;
        });
      }
    } catch (_) {
      // Ignore avatar loading errors.
    } finally {
      if (mounted) {
        setState(() {
          isLoadingAvatar = false;
        });
      }
    }
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<void> openUpdateProfile() async {
    final bool? updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const UpdateProfileScreen(),
      ),
    );

    if (updated == true && mounted) {
      await FirebaseAuth.instance.currentUser?.reload();

      await loadAvatar();

      if (!mounted) return;

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile updated successfully.',
          ),
          backgroundColor: ProfileColors.yellow,
        ),
      );
    }
  }

  // ============================================================
  // PROFILE AVATAR
  // ============================================================

  Widget buildProfileAvatar() {
    if (isLoadingAvatar) {
      return Container(
        width: 104,
        height: 104,
        color: ProfileColors.cardColor,
        child: const Center(
          child: CircularProgressIndicator(
            color: ProfileColors.yellow,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (selectedAvatar < 0 ||
        selectedAvatar >= AvatarPicker.allAvatars.length) {
      return Container(
        width: 104,
        height: 104,
        color: ProfileColors.cardColor,
        child: const Icon(
          Icons.person,
          color: Colors.white70,
          size: 55,
        ),
      );
    }

    final avatar = AvatarPicker.allAvatars[selectedAvatar];

    return Image.asset(
      avatar.imagePath,
      width: 104,
      height: 104,
      fit: BoxFit.cover,
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return Container(
          width: 104,
          height: 104,
          color: ProfileColors.cardColor,
          child: const Icon(
            Icons.person,
            color: Colors.white70,
            size: 55,
          ),
        );
      },
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _onNavigationTap(int index) {
    if (index == 0) {
      openHome();
      return;
    }

    if (index == 1) {
      openSearch();
      return;
    }

    if (index == 2) {
      openBrowse();
      return;
    }

    if (index == 3) {
      return;
    }
  }

  void openHome() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  void openSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      ),
    );
  }

  void openBrowse() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const BrowseScreen(),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return buildGuestProfile();
    }

    final String name = user.displayName?.isNotEmpty == true
        ? user.displayName!
        : 'User';

    return Scaffold(
      backgroundColor: ProfileColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // PROFILE HEADER
            // ==================================================

            Container(
              width: double.infinity,
              color: ProfileColors.topSection,
              padding: const EdgeInsets.fromLTRB(
                16,
                20,
                16,
                0,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==========================================
                      // AVATAR + NAME
                      // ==========================================

                      Column(
                        children: [
                          Container(
                            width: 116,
                            height: 116,
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ProfileColors.yellow,
                            ),
                            child: ClipOval(
                              child: buildProfileAvatar(),
                            ),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: 125,
                            child: Text(
                              name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ==========================================
                      // STATS
                      // ==========================================

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 28,
                        ),
                        child: Row(
                          children: [
                            // WATCH LIST COUNT
                            StreamBuilder<int>(
                              stream: watchlistService
                                  .getWatchlistCountStream(),
                              builder: (context, snapshot) {
                                final count = snapshot.data ?? 0;

                                return _Stat(
                                  number: count.toString(),
                                  title: 'Watch List',
                                );
                              },
                            ),

                            const SizedBox(width: 25),

                            // HISTORY COUNT
                            const _Stat(
                              number: '0',
                              title: 'History',
                            ),

                            const SizedBox(width: 20),

                            // FAVORITES COUNT
                            StreamBuilder<int>(
                              stream: favoriteService
                                  .getFavoritesCountStream(),
                              builder: (context, snapshot) {
                                final count = snapshot.data ?? 0;

                                return _Stat(
                                  number: count.toString(),
                                  title: 'Favorites',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // ==============================================
                  // BUTTONS
                  // ==============================================

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: openUpdateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ProfileColors.yellow,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ProfileColors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Exit',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.logout,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // ==============================================
                  // PROFILE TABS
                  // ==============================================

                  Row(
                    children: [
                      Expanded(
                        child: _ProfileTab(
                          icon: Icons.format_list_bulleted_rounded,
                          title: 'Watch List',
                          isSelected: selectedSection == 0,
                          onTap: () {
                            setState(() {
                              selectedSection = 0;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: _ProfileTab(
                          icon: Icons.history,
                          title: 'History',
                          isSelected: selectedSection == 1,
                          onTap: () {
                            setState(() {
                              selectedSection = 1;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: _ProfileTab(
                          icon: Icons.favorite,
                          title: 'Favorites',
                          isSelected: selectedSection == 2,
                          onTap: () {
                            setState(() {
                              selectedSection = 2;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==================================================
            // TAB CONTENT
            // ==================================================

            Expanded(
              child: IndexedStack(
                index: selectedSection,
                children: const [
                  WatchlistTab(),
                  HistoryTab(),
                  FavoritesTab(),
                ],
              ),
            ),
          ],
        ),
      ),

      // ==========================================================
      // BOTTOM NAVIGATION
      // ==========================================================

      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: _onNavigationTap,
      ),
    );
  }

  // ============================================================
  // GUEST PROFILE
  // ============================================================

  Widget buildGuestProfile() {
    return Scaffold(
      backgroundColor: ProfileColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: ProfileColors.yellow,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: ProfileColors.cardColor,
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                      size: 55,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Welcome to Movies App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Login or create an account to access your profile, watchlist and favorites.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProfileColors.yellow,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ProfileColors.yellow,
                      side: const BorderSide(
                        color: ProfileColors.yellow,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STAT
// ============================================================

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
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PROFILE TAB
// ============================================================

class _ProfileTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProfileTab({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? ProfileColors.yellow
                      : Colors.white70,
                  size: 31,
                ),
                const SizedBox(height: 7),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white70,
                    fontSize: 15,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            width: isSelected ? 65 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: ProfileColors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}