import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'update_profile_screen.dart';
import 'watchlist_screen.dart';
import 'history_screen.dart';
import 'favorites_screen.dart';
import 'avatar_picker.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const Color background = Color(0xFF0B0B0F);
  static const Color purple = Color(0xFF8B5CF6);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedAvatar = 0;
  bool isLoadingAvatar = true;

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  Future<void> loadAvatar() async {
    final User? user =
        FirebaseAuth.instance.currentUser;

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
    } finally {
      if (mounted) {
        setState(() {
          isLoadingAvatar = false;
        });
      }
    }
  }

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

      if (mounted) {
        setState(() {});
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully.'),
            backgroundColor: ProfileScreen.purple,
          ),
        );
      }
    }
  }

  Widget buildProfileAvatar() {
    if (isLoadingAvatar) {
      return Container(
        width: 104,
        height: 104,
        color: const Color(0xFF202027),
        child: const Center(
          child: CircularProgressIndicator(
            color: ProfileScreen.purple,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (selectedAvatar >=
        AvatarPicker.allAvatars.length) {
      return Container(
        width: 104,
        height: 104,
        color: const Color(0xFF202027),
        child: const Icon(
          Icons.person,
          color: Colors.white70,
          size: 55,
        ),
      );
    }

    final avatar =
    AvatarPicker.allAvatars[selectedAvatar];

    return FutureBuilder<String?>(
      future: AvatarPicker.getWikipediaImage(
        avatar.person,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Container(
            width: 104,
            height: 104,
            color: const Color(0xFF202027),
            child: const Center(
              child: CircularProgressIndicator(
                color: ProfileScreen.purple,
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data == null) {
          return Container(
            width: 104,
            height: 104,
            color: const Color(0xFF202027),
            child: const Icon(
              Icons.person,
              color: Colors.white70,
              size: 55,
            ),
          );
        }

        return Image.network(
          snapshot.data!,
          width: 104,
          height: 104,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) {
            return Container(
              width: 104,
              height: 104,
              color: const Color(0xFF202027),
              child: const Icon(
                Icons.person,
                color: Colors.white70,
                size: 55,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: ProfileScreen.background,
        appBar: AppBar(
          backgroundColor: ProfileScreen.background,
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: ProfileScreen.purple,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: Color(0xFF202027),
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
                  height: 50,
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
                      backgroundColor: ProfileScreen.purple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
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
                  height: 50,
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
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: ProfileScreen.purple,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
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
      );
    }

    final String name =
    user.displayName?.isNotEmpty == true
        ? user.displayName!
        : 'User';

    final String email = user.email ?? '';

    return Scaffold(
      backgroundColor: ProfileScreen.background,
      appBar: AppBar(
        backgroundColor: ProfileScreen.background,
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
            onPressed: openUpdateProfile,
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

            Container(
              width: 110,
              height: 110,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ProfileScreen.purple,
              ),
              child: ClipOval(
                child: buildProfileAvatar(),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              email,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(
                    color: Colors.white24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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