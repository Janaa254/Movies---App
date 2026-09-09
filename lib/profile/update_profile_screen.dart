import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/compact_language_switcher.dart';

import 'avatar_picker.dart';
import 'profile_colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState
    extends State<UpdateProfileScreen> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  int selectedAvatar = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final User? user =
        FirebaseAuth.instance.currentUser;

    nameController.text =
        user?.displayName ?? '';

    emailController.text =
        user?.email ?? '';

    loadSelectedAvatar();
  }

  // ================= LOAD AVATAR =================

  Future<void> loadSelectedAvatar() async {
    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

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
          avatarIndex <
              AvatarPicker.allAvatars.length) {
        setState(() {
          selectedAvatar = avatarIndex;
        });
      }
    } catch (_) {}
  }

  // ================= AVATAR PICKER =================

  void showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return AvatarPicker(
          selectedAvatar: selectedAvatar,
          onAvatarSelected: (index) {
            setState(() {
              selectedAvatar = index;
            });
          },
        );
      },
    );
  }

  // ================= SAVE CHANGES =================

  Future<void> saveChanges() async {
    final l10n =
    AppLocalizations.of(context)!;

    FocusScope.of(context).unfocus();

    final String name =
    nameController.text.trim();

    final String email =
    emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      showMessage(
        l10n.fillAllFields,
      );
      return;
    }

    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      showMessage(
        l10n.noUserLoggedIn,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (name != user.displayName) {
        await user.updateDisplayName(name);
      }

      if (email != user.email) {
        await user.verifyBeforeUpdateEmail(email);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'avatarIndex': selectedAvatar,
          'name': name,
          'email': email,
        },
        SetOptions(
          merge: true,
        ),
      );

      await user.reload();

      if (!mounted) return;

      Navigator.pop(
        context,
        true,
      );
    } on FirebaseAuthException catch (e) {
      String message =
          l10n.somethingWentWrong;

      if (e.code == 'invalid-email') {
        message =
            l10n.enterValidEmail;
      } else if (
      e.code == 'email-already-in-use') {
        message =
            l10n.emailAlreadyInUse;
      } else if (
      e.code == 'requires-recent-login') {
        message =
            l10n.loginAgainBeforeEmailChange;
      }

      showMessage(message);
    } catch (_) {
      showMessage(
        l10n.somethingWentWrong,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ================= MESSAGE =================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        ProfileColors.yellow,
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      ProfileColors.background,

      appBar: AppBar(
        backgroundColor:
        ProfileColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme:
        const IconThemeData(
          color: Colors.white,
        ),

        title: Text(
          l10n.editProfile,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding:
            EdgeInsetsDirectional.only(
              end: 12,
            ),
            child: Center(
              child:
              CompactLanguageSwitcher(),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 15),

            GestureDetector(
              onTap: showAvatarPicker,
              child: Container(
                width: 116,
                height: 116,
                padding:
                const EdgeInsets.all(3),
                decoration:
                const BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  ProfileColors.yellow,
                ),
                child: ClipOval(
                  child:
                  _buildSelectedAvatar(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton.icon(
              onPressed: showAvatarPicker,
              icon: const Icon(
                Icons.edit_outlined,
                color:
                ProfileColors.yellow,
                size: 19,
              ),
              label: Text(
                l10n.changeAvatar,
                style: const TextStyle(
                  color:
                  ProfileColors.yellow,
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildTextField(
              controller: nameController,
              labelText: l10n.name,
              icon:
              Icons.person_outline,
            ),

            const SizedBox(height: 18),

            _buildTextField(
              controller: emailController,
              labelText: l10n.email,
              icon:
              Icons.email_outlined,
              keyboardType:
              TextInputType.emailAddress,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed:
                isLoading
                    ? null
                    : saveChanges,
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  ProfileColors.yellow,
                  foregroundColor:
                  Colors.black,
                  disabledBackgroundColor:
                  ProfileColors.yellow
                      .withValues(
                    alpha: 0.5,
                  ),
                  disabledForegroundColor:
                  Colors.black54,
                  elevation: 0,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                  width: 23,
                  height: 23,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color:
                    Colors.black,
                  ),
                )
                    : Text(
                  l10n.saveChanges,
                  style:
                  const TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= SELECTED AVATAR =================

  Widget _buildSelectedAvatar() {
    if (selectedAvatar < 0 ||
        selectedAvatar >=
            AvatarPicker.allAvatars.length) {
      return Container(
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
    AvatarPicker.allAvatars[selectedAvatar];

    return Image.asset(
      avatar.imagePath,
      width: 110,
      height: 110,
      fit: BoxFit.cover,
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return Container(
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

  // ================= TEXT FIELD =================

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      cursorColor:
      ProfileColors.yellow,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
        const TextStyle(
          color: Colors.white54,
        ),
        prefixIcon: Icon(
          icon,
          color:
          ProfileColors.yellow,
        ),
        filled: true,
        fillColor:
        ProfileColors.cardColor,
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(14),
          borderSide:
          BorderSide.none,
        ),
        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(14),
          borderSide:
          BorderSide.none,
        ),
        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(14),
          borderSide:
          const BorderSide(
            color:
            ProfileColors.yellow,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}