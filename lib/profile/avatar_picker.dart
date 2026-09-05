import 'package:flutter/material.dart';

class AvatarPicker extends StatelessWidget {
  final int selectedAvatar;
  final Function(int) onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  static const Color purple = Color(0xFF8B5CF6);

  // Temporary
  final List<String> avatars = const [
    'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
    'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    'https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg',
    'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
    'https://image.tmdb.org/t/p/w500/q6AGQZS8D7uK4p6M9q2xV5h8x8Y.jpg',
    'https://image.tmdb.org/t/p/w500/6b7swg6DLqXv8Y9L4kJv9Y3x7YQ.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF15151B),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Choose Avatar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: avatars.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              final isSelected = selectedAvatar == index;

              return GestureDetector(
                onTap: () {
                  onAvatarSelected(index);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? purple
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: ClipOval(
                    child: Image.network(
                      avatars[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF202027),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white54,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}