import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
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

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {},
              child: const Text(
                'Change Photo',
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