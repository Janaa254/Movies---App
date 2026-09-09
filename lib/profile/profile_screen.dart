import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

import '../widgets/app_bottom_nav.dart';
import '../widgets/compact_language_switcher.dart';

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
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedAvatar = 0;
  bool isLoadingAvatar = true;

  // 0 = Watch List
  // 1 = History
  // 2 = Favorites
  int selectedSection = 0;

  final FavoriteService favoriteService =
  FavoriteService();

  final WatchlistService watchlistService =
  WatchlistService();

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  // ============================================================
  // LOAD AVATAR
  // ============================================================

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
      final doc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      final data = doc.data();
      final avatarIndex =
      data?['avatarIndex'];

      if (avatarIndex is int &&
          avatarIndex >= 0 &&
          avatarIndex <
              AvatarPicker
                  .allAvatars.length) {
        setState(() {
          selectedAvatar =
              avatarIndex;
        });
      }
    } catch (_) {
      // Ignore avatar loading errors.
    } finally {
      if (mounted) {
        setState(() {
          isLoadingAvatar =
          false;
        });
      }
    }
  }

  // ============================================================
  // UPDATE PROFILE
  // ============================================================

  Future<void> openUpdateProfile() async {
    final bool? updated =
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const UpdateProfileScreen(),
      ),
    );

    if (updated == true && mounted) {
      await FirebaseAuth.instance
          .currentUser
          ?.reload();

      await loadAvatar();

      if (!mounted) return;

      setState(() {});

      final l10n =
      AppLocalizations.of(
        context,
      )!;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            l10n
                .profileUpdatedSuccessfully,
          ),
          backgroundColor:
          ProfileColors.yellow,
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
        color:
        ProfileColors.cardColor,
        child: const Center(
          child:
          CircularProgressIndicator(
            color:
            ProfileColors.yellow,
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (selectedAvatar < 0 ||
        selectedAvatar >=
            AvatarPicker
                .allAvatars.length) {
      return Container(
        width: 104,
        height: 104,
        color:
        ProfileColors.cardColor,
        child: const Icon(
          Icons.person,
          color: Colors.white70,
          size: 55,
        ),
      );
    }

    final avatar =
    AvatarPicker.allAvatars[
    selectedAvatar];

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
          color:
          ProfileColors.cardColor,
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
    await FirebaseAuth.instance
        .signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
          (route) => false,
    );
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _onNavigationTap(
      int index,
      ) {
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
        builder: (_) =>
        const SearchScreen(),
      ),
    );
  }

  void openBrowse() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const BrowseScreen(),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      return buildGuestProfile();
    }

    final String name =
    user.displayName?.isNotEmpty ==
        true
        ? user.displayName!
        : l10n.user;

    return Scaffold(
      backgroundColor:
      ProfileColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color:
              ProfileColors
                  .topSection,
              padding:
              const EdgeInsets
                  .fromLTRB(
                16,
                14,
                16,
                0,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment:
                    Alignment.centerLeft,
                    child:
                    CompactLanguageSwitcher(),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 116,
                            height: 116,
                            padding:
                            const EdgeInsets
                                .all(
                              3,
                            ),
                            decoration:
                            const BoxDecoration(
                              shape:
                              BoxShape
                                  .circle,
                              color:
                              ProfileColors
                                  .yellow,
                            ),
                            child:
                            ClipOval(
                              child:
                              buildProfileAvatar(),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            width: 125,
                            child: Text(
                              name,
                              textAlign:
                              TextAlign
                                  .center,
                              maxLines: 1,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                              style:
                              const TextStyle(
                                color:
                                Colors.white,
                                fontSize: 18,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Padding(
                        padding:
                        const EdgeInsets
                            .only(
                          top: 28,
                        ),
                        child: Row(
                          children: [
                            StreamBuilder<int>(
                              stream:
                              watchlistService
                                  .getWatchlistCountStream(),
                              builder:
                                  (
                                  context,
                                  snapshot,
                                  ) {
                                final count =
                                    snapshot.data ??
                                        0;

                                return _Stat(
                                  number:
                                  count
                                      .toString(),
                                  title:
                                  l10n.watchList,
                                );
                              },
                            ),

                            const SizedBox(
                              width: 25,
                            ),

                            _Stat(
                              number: '0',
                              title:
                              l10n.history,
                            ),

                            const SizedBox(
                              width: 20,
                            ),

                            StreamBuilder<int>(
                              stream:
                              favoriteService
                                  .getFavoritesCountStream(),
                              builder:
                                  (
                                  context,
                                  snapshot,
                                  ) {
                                final count =
                                    snapshot.data ??
                                        0;

                                return _Stat(
                                  number:
                                  count
                                      .toString(),
                                  title:
                                  l10n.favorites,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 54,
                          child:
                          ElevatedButton(
                            onPressed:
                            openUpdateProfile,
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              ProfileColors
                                  .yellow,
                              foregroundColor:
                              Colors.black,
                              elevation: 0,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  14,
                                ),
                              ),
                            ),
                            child: Text(
                              l10n.editProfile,
                              style:
                              const TextStyle(
                                fontSize: 17,
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child:
                          ElevatedButton(
                            onPressed:
                            logout,
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              ProfileColors
                                  .red,
                              foregroundColor:
                              Colors.white,
                              elevation: 0,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  14,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                Text(
                                  l10n.exit,
                                  style:
                                  const TextStyle(
                                    fontSize:
                                    17,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Icon(
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

                  const SizedBox(
                    height: 22,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _ProfileTab(
                          icon:
                          Icons
                              .format_list_bulleted_rounded,
                          title:
                          l10n.watchList,
                          isSelected:
                          selectedSection ==
                              0,
                          onTap: () {
                            setState(() {
                              selectedSection =
                              0;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: _ProfileTab(
                          icon:
                          Icons.history,
                          title:
                          l10n.history,
                          isSelected:
                          selectedSection ==
                              1,
                          onTap: () {
                            setState(() {
                              selectedSection =
                              1;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: _ProfileTab(
                          icon:
                          Icons.favorite,
                          title:
                          l10n.favorites,
                          isSelected:
                          selectedSection ==
                              2,
                          onTap: () {
                            setState(() {
                              selectedSection =
                              2;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

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

      bottomNavigationBar:
      AppBottomNav(
        currentIndex: 3,
        onTap:
        _onNavigationTap,
      ),
    );
  }

  // ============================================================
  // GUEST PROFILE
  // ============================================================

  Widget buildGuestProfile() {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      ProfileColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor:
                      ProfileColors
                          .yellow,
                      child:
                      CircleAvatar(
                        radius: 52,
                        backgroundColor:
                        ProfileColors
                            .cardColor,
                        child: Icon(
                          Icons
                              .person_outline,
                          color:
                          Colors
                              .white70,
                          size: 55,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      l10n
                          .welcomeToMoviesApp,
                      textAlign:
                      TextAlign.center,
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      l10n
                          .guestProfileDescription,
                      textAlign:
                      TextAlign.center,
                      style:
                      const TextStyle(
                        color:
                        Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width:
                      double.infinity,
                      height: 52,
                      child:
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const LoginScreen(),
                            ),
                          );
                        },
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          ProfileColors
                              .yellow,
                          foregroundColor:
                          Colors.black,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              14,
                            ),
                          ),
                        ),
                        child: Text(
                          l10n.login,
                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      width:
                      double.infinity,
                      height: 52,
                      child:
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const RegisterScreen(),
                            ),
                          );
                        },
                        style:
                        OutlinedButton
                            .styleFrom(
                          foregroundColor:
                          ProfileColors
                              .yellow,
                          side:
                          const BorderSide(
                            color:
                            ProfileColors
                                .yellow,
                            width: 1.5,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              14,
                            ),
                          ),
                        ),
                        child: Text(
                          l10n
                              .createAccount,
                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              top: 12,
              left: 16,
              child:
              CompactLanguageSwitcher(),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
      AppBottomNav(
        currentIndex: 3,
        onTap:
        _onNavigationTap,
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
          style:
          const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Text(
          title,
          textAlign:
          TextAlign.center,
          style:
          const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight:
            FontWeight.w600,
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
      borderRadius:
      BorderRadius.circular(
        10,
      ),
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets
                .symmetric(
              vertical: 8,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color:
                  isSelected
                      ? ProfileColors
                      .yellow
                      : Colors
                      .white70,
                  size: 31,
                ),

                const SizedBox(
                  height: 7,
                ),

                Text(
                  title,
                  textAlign:
                  TextAlign.center,
                  style:
                  TextStyle(
                    color:
                    isSelected
                        ? Colors.white
                        : Colors.white70,
                    fontSize: 15,
                    fontWeight:
                    isSelected
                        ? FontWeight
                        .w600
                        : FontWeight
                        .normal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          AnimatedContainer(
            duration:
            const Duration(
              milliseconds: 200,
            ),
            width:
            isSelected
                ? 65
                : 0,
            height: 3,
            decoration:
            BoxDecoration(
              color:
              ProfileColors
                  .yellow,
              borderRadius:
              BorderRadius
                  .circular(
                10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}