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
  TextEditingController(text: 'User Name');

  final TextEditingController emailController =
  TextEditingController(text: 'user@email.com');

  int selectedAvatar = 0;

  final List<String> avatars = const [
    'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
    'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    'https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
    'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
    'https://image.tmdb.org/t/p/w500/q6AGQZS8D7uK4p6M9q2xV5h8x8Y.jpg',
    'https://image.tmdb.org/t/p/w500/6b7swg6DLqXv8Y9L4kJv9Y3x7YQ.jpg',
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
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

  void saveChanges() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: purple,
      ),
    );
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

            GestureDetector(
              onTap: showAvatarPicker,
              child: Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: purple,
                    width: 3,
                  ),
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.network(
                    avatars[selectedAvatar],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF202027),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 55,
                        ),
                      );
                    },
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
                fillColor: const Color(0xFF18181F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: purple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
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
                fillColor: const Color(0xFF18181F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: purple,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Save Changes',
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
    );
  }
}