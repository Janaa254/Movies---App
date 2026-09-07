import 'package:flutter/material.dart';

import 'profile_colors.dart';

// ================= AVATAR MODEL =================

class Avatar {
  final String name;
  final String imagePath;

  const Avatar({
    required this.name,
    required this.imagePath,
  });
}

// ================= AVATAR PICKER =================

class AvatarPicker extends StatefulWidget {
  final int selectedAvatar;
  final Function(int) onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  // ================= CATEGORIES =================

  static const List<Map<String, dynamic>> categories = [
    {
      'title': 'Marvel',
      'avatars': [
        Avatar(
          name: 'Iron Man',
          imagePath: 'assets/avatars/marvel/iron_man.png',
        ),
        Avatar(
          name: 'Captain America',
          imagePath: 'assets/avatars/marvel/captain_america.png',
        ),
        Avatar(
          name: 'Thor',
          imagePath: 'assets/avatars/marvel/thor.png',
        ),
        Avatar(
          name: 'Black Widow',
          imagePath: 'assets/avatars/marvel/black_widow.png',
        ),
        Avatar(
          name: 'Spider-Man',
          imagePath: 'assets/avatars/marvel/spider_man.png',
        ),
        Avatar(
          name: 'Wanda',
          imagePath: 'assets/avatars/marvel/wanda.png',
        ),
      ],
    },

    {
      'title': 'Disney',
      'avatars': [
        Avatar(
          name: 'Elsa',
          imagePath: 'assets/avatars/disney/elsa.png',
        ),
        Avatar(
          name: 'Cinderella',
          imagePath: 'assets/avatars/disney/cinderella.png',
        ),
        Avatar(
          name: 'Stitch',
          imagePath: 'assets/avatars/disney/stitch.png',
        ),
        Avatar(
          name: 'Ariel',
          imagePath: 'assets/avatars/disney/ariel.png',
        ),
        Avatar(
          name: 'Rapunzel',
          imagePath: 'assets/avatars/disney/rapunzel.png',
        ),
        Avatar(
          name: 'Moana',
          imagePath: 'assets/avatars/disney/moana.png',
        ),
      ],
    },

    {
      'title': 'Harry Potter',
      'avatars': [
        Avatar(
          name: 'Harry',
          imagePath: 'assets/avatars/harry_potter/harry.png',
        ),
        Avatar(
          name: 'Hermione',
          imagePath: 'assets/avatars/harry_potter/hermione.png',
        ),
        Avatar(
          name: 'Ron',
          imagePath: 'assets/avatars/harry_potter/ron.png',
        ),
        Avatar(
          name: 'Draco',
          imagePath: 'assets/avatars/harry_potter/draco.png',
        ),
        Avatar(
          name: 'Luna',
          imagePath: 'assets/avatars/harry_potter/luna.png',
        ),
        Avatar(
          name: 'Snape',
          imagePath: 'assets/avatars/harry_potter/snape.png',
        ),
      ],
    },
  ];

  // ================= ALL AVATARS =================

  static List<Avatar> get allAvatars {
    final List<Avatar> result = [];

    for (final category in categories) {
      result.addAll(
        category['avatars'] as List<Avatar>,
      );
    }

    return result;
  }

  @override
  State<AvatarPicker> createState() =>
      _AvatarPickerState();
}

class _AvatarPickerState
    extends State<AvatarPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      MediaQuery.of(context).size.height *
          0.85,

      decoration: const BoxDecoration(
        color: ProfileColors.background,

        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),

      child: Column(
        children: [
          // ================= HANDLE =================

          const SizedBox(height: 12),

          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius:
              BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 22),

          // ================= TITLE =================

          const Text(
            'Choose Your Avatar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Choose your favorite character',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          // ================= CATEGORIES =================

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),

              itemCount:
              AvatarPicker.categories.length,

              itemBuilder: (
                  context,
                  categoryIndex,
                  ) {
                final category =
                AvatarPicker.categories[
                categoryIndex];

                final List<Avatar> avatars =
                category['avatars']
                as List<Avatar>;

                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    // ================= CATEGORY TITLE =================

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),

                      child: Text(
                        category['title'],

                        style:
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // ================= AVATARS =================

                    SizedBox(
                      height: 150,

                      child:
                      ListView.separated(
                        scrollDirection:
                        Axis.horizontal,

                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),

                        itemCount:
                        avatars.length,

                        separatorBuilder:
                            (_, __) =>
                        const SizedBox(
                          width: 20,
                        ),

                        itemBuilder: (
                            context,
                            avatarIndex,
                            ) {
                          final avatar =
                          avatars[
                          avatarIndex];

                          final globalIndex =
                              categoryIndex *
                                  6 +
                                  avatarIndex;

                          final bool
                          isSelected =
                              widget
                                  .selectedAvatar ==
                                  globalIndex;

                          return GestureDetector(
                            onTap: () {
                              widget
                                  .onAvatarSelected(
                                globalIndex,
                              );

                              Navigator.pop(
                                context,
                              );
                            },

                            child: SizedBox(
                              width: 105,

                              child: Column(
                                children: [
                                  // ================= AVATAR IMAGE =================

                                  AnimatedContainer(
                                    duration:
                                    const Duration(
                                      milliseconds:
                                      180,
                                    ),

                                    width: 100,
                                    height: 100,

                                    padding:
                                    const EdgeInsets
                                        .all(3),

                                    decoration:
                                    BoxDecoration(
                                      shape:
                                      BoxShape.circle,

                                      border:
                                      Border.all(
                                        color:
                                        isSelected
                                            ? ProfileColors
                                            .yellow
                                            : Colors
                                            .white24,

                                        width:
                                        isSelected
                                            ? 3
                                            : 1.5,
                                      ),

                                      boxShadow:
                                      isSelected
                                          ? [
                                        BoxShadow(
                                          color: ProfileColors
                                              .yellow
                                              .withValues(
                                            alpha:
                                            0.20,
                                          ),
                                          blurRadius:
                                          12,
                                          spreadRadius:
                                          1,
                                        ),
                                      ]
                                          : null,
                                    ),

                                    child:
                                    ClipOval(
                                      child:
                                      Image.asset(
                                        avatar
                                            .imagePath,

                                        width: 100,
                                        height: 100,

                                        fit:
                                        BoxFit.cover,

                                        errorBuilder:
                                            (
                                            context,
                                            error,
                                            stackTrace,
                                            ) {
                                          return Container(
                                            color:
                                            ProfileColors
                                                .cardColor,

                                            child:
                                            const Icon(
                                              Icons
                                                  .person,
                                              color:
                                              Colors.white54,
                                              size:
                                              42,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  // ================= NAME =================

                                  Text(
                                    avatar.name,

                                    maxLines: 1,

                                    overflow:
                                    TextOverflow
                                        .ellipsis,

                                    textAlign:
                                    TextAlign
                                        .center,

                                    style:
                                    TextStyle(
                                      color:
                                      isSelected
                                          ? ProfileColors
                                          .yellow
                                          : Colors
                                          .white,

                                      fontSize: 13,

                                      fontWeight:
                                      isSelected
                                          ? FontWeight
                                          .bold
                                          : FontWeight
                                          .w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}