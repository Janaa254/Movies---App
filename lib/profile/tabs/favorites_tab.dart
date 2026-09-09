import 'package:flutter/material.dart';
import '../profile_colors.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ProfileColors.background,

      child: Center(
        child: Padding(
          padding:
          const EdgeInsets.all(25),

          child: Container(
            width: double.infinity,

            padding:
            const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 45,
            ),

            decoration: BoxDecoration(
              color:
              ProfileColors.cardColor,
              borderRadius:
              BorderRadius.circular(18),
            ),

            child: const Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_border,
                  color:
                  ProfileColors.yellow,
                  size: 70,
                ),

                SizedBox(height: 20),

                Text(
                  'No Favorites Yet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Movies you like will appear here.',
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
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