import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState
    extends State<UpdateProfileScreen> {
  static const Color bg = Color(0xFF09070F);
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

  void saveProfile() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: Color(0xFF24143D),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          24,
          25,
          24,
          40,
        ),
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
                    color: purple.withOpacity(.25),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 58,
                backgroundColor: Color(0xFF1B1228),
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {},
              child: const Text(
                'Change Photo',
                style: TextStyle(
                  color: purple,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildField(
              controller: nameController,
              label: 'Name',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 18),

            _buildField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email_outlined,
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: saveProfile,
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

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      cursorColor: purple,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white54,
        ),
        prefixIcon: Icon(
          icon,
          color: purple,
        ),
        filled: true,
        fillColor: const Color(0xFF15111D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: purple,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}