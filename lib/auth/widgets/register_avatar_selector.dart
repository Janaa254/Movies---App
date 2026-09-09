import 'package:flutter/material.dart';

import '../auth_colors.dart';

class RegisterAvatarSelector extends StatelessWidget {
  final List<String> avatars;
  final int selectedAvatar;
  final ValueChanged<int> onSelected;

  const RegisterAvatarSelector({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: 180,
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics:
          const BouncingScrollPhysics(),
          padding:
          const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          itemCount: avatars.length,
          itemBuilder: (
              context,
              index,
              ) {
            final isSelected =
                selectedAvatar == index;

            return GestureDetector(
              onTap: () {
                onSelected(index);
              },
              child: AnimatedContainer(
                duration:
                const Duration(
                  milliseconds: 250,
                ),
                curve:
                Curves.easeInOut,
                width:
                isSelected ? 145 : 95,
                height:
                isSelected ? 145 : 95,
                margin:
                EdgeInsets.symmetric(
                  horizontal:
                  isSelected ? 5 : 8,
                  vertical:
                  isSelected ? 15 : 42,
                ),
                decoration:
                BoxDecoration(
                  shape:
                  BoxShape.circle,
                  border:
                  isSelected
                      ? Border.all(
                    color:
                    AuthColors.yellow,
                    width: 4,
                  )
                      : null,
                  boxShadow:
                  isSelected
                      ? [
                    BoxShadow(
                      color: AuthColors
                          .yellow
                          .withValues(
                        alpha: 0.35,
                      ),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                      : null,
                ),
                child: ClipOval(
                  child: Image.asset(
                    avatars[index],
                    fit: BoxFit.cover,
                    errorBuilder: (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return Container(
                        color:
                        AuthColors.fieldColor,
                        child: Icon(
                          Icons.person,
                          color:
                          Colors.white,
                          size:
                          isSelected
                              ? 60
                              : 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}