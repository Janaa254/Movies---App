import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'avatar_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState
    extends State<UpdateProfileScreen> {
  static const Color background = Color(0xFF0B0B0F);
  static const Color purple = Color(0xFF8B5CF6);

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
          avatarIndex < AvatarPicker.allAvatars.length) {
        setState(() {
          selectedAvatar = avatarIndex;
        });
      }
    } catch (_) {}
  }

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

  Future<void> saveChanges() async {
    FocusScope.of(context).unfocus();

    final String name =
    nameController.text.trim();

    final String email =
    emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      showMessage(
        'Please fill in all fields.',
      );
      return;
    }

    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      showMessage(
        'No user is currently logged in.',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Update name
      if (name != user.displayName) {
        await user.updateDisplayName(name);
      }

      // Update email
      if (email != user.email) {
        await user.verifyBeforeUpdateEmail(email);
      }

      // Save avatar + profile data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'avatarIndex': selectedAvatar,
          'name': name,
          'email': email,
        },
        SetOptions(merge: true),
      );

      // Reload Firebase user data
      await user.reload();

      if (!mounted) return;

      // Send true to ProfileScreen
      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      String message =
          'Something went wrong.';

      if (e.code == 'invalid-email') {
        message =
        'Please enter a valid email.';
      } else if (e.code ==
          'email-already-in-use') {
        message =
        'This email is already in use.';
      } else if (e.code ==
          'requires-recent-login') {
        message =
        'Please log in again before changing your email.';
      }

      showMessage(message);
    } catch (_) {
      showMessage(
        'Something went wrong.',
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: purple,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,

        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            GestureDetector(
              onTap: showAvatarPicker,

              child: Container(
                width: 116,
                height: 116,
                padding: const EdgeInsets.all(3),

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: purple,
                ),

                child: ClipOval(
                  child: selectedAvatar <
                      AvatarPicker.allAvatars.length
                      ? FutureBuilder<String?>(
                    future:
                    AvatarPicker.getWikipediaImage(
                      AvatarPicker
                          .allAvatars[selectedAvatar]
                          .person,
                    ),
                    builder:
                        (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          color:
                          const Color(0xFF202027),
                          child: const Center(
                            child:
                            CircularProgressIndicator(
                              color: purple,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot.data == null) {
                        return Container(
                          color:
                          const Color(0xFF202027),
                          child: const Icon(
                            Icons.movie_outlined,
                            color:
                            Colors.white70,
                            size: 55,
                          ),
                        );
                      }

                      return Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            color:
                            const Color(
                              0xFF202027,
                            ),
                            child: const Icon(
                              Icons.movie_outlined,
                              color:
                              Colors.white70,
                              size: 55,
                            ),
                          );
                        },
                      );
                    },
                  )
                      : Container(
                    color: const Color(0xFF202027),
                    child: const Icon(
                      Icons.movie_outlined,
                      color: Colors.white70,
                      size: 55,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: showAvatarPicker,

              child: const Text(
                'Change Avatar',
                style: TextStyle(
                  color: purple,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Name
            TextField(
              controller: nameController,

              style: const TextStyle(
                color: Colors.white,
              ),

              cursorColor: purple,

              decoration: InputDecoration(
                labelText: 'Name',

                labelStyle: const TextStyle(
                  color: Colors.white54,
                ),

                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: purple,
                ),

                filled: true,

                fillColor: const Color(
                  0xFF18181F,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),

                focusedBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),

                  borderSide:
                  const BorderSide(
                    color: purple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Email
            TextField(
              controller: emailController,

              keyboardType:
              TextInputType.emailAddress,

              style: const TextStyle(
                color: Colors.white,
              ),

              cursorColor: purple,

              decoration: InputDecoration(
                labelText: 'Email',

                labelStyle: const TextStyle(
                  color: Colors.white54,
                ),

                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: purple,
                ),

                filled: true,

                fillColor: const Color(
                  0xFF18181F,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),

                focusedBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),

                  borderSide:
                  const BorderSide(
                    color: purple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Save Changes
            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed:
                isLoading ? null : saveChanges,

                style:
                ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,

                  disabledBackgroundColor:
                  purple.withValues(
                    alpha: 0.5,
                  ),

                  elevation: 0,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,

                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
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
}