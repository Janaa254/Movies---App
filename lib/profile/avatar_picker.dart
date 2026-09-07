import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'profile_colors.dart';

// ================= AVATAR MODEL =================

class Avatar {
  final String name;
  final String person;

  const Avatar({
    required this.name,
    required this.person,
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
          person: 'Robert Downey Jr.',
        ),
        Avatar(
          name: 'Captain America',
          person: 'Chris Evans',
        ),
        Avatar(
          name: 'Thor',
          person: 'Chris Hemsworth',
        ),
        Avatar(
          name: 'Black Widow',
          person: 'Scarlett Johansson',
        ),
        Avatar(
          name: 'Spider-Man',
          person: 'Tom Holland',
        ),
        Avatar(
          name: 'Wanda',
          person: 'Elizabeth Olsen',
        ),
      ],
    },

    {
      'title': 'Disney',
      'avatars': [
        Avatar(
          name: 'Elsa',
          person: 'Idina Menzel',
        ),
        Avatar(
          name: 'Anna',
          person: 'Kristen Bell',
        ),
        Avatar(
          name: 'Stitch',
          person: 'Chris Sanders',
        ),
        Avatar(
          name: 'Ariel',
          person: 'Halle Bailey',
        ),
        Avatar(
          name: 'Rapunzel',
          person: 'Mandy Moore',
        ),
        Avatar(
          name: 'Moana',
          person: 'Auliʻi Cravalho',
        ),
      ],
    },

    {
      'title': 'Harry Potter',
      'avatars': [
        Avatar(
          name: 'Harry',
          person: 'Daniel Radcliffe',
        ),
        Avatar(
          name: 'Hermione',
          person: 'Emma Watson',
        ),
        Avatar(
          name: 'Ron',
          person: 'Rupert Grint',
        ),
        Avatar(
          name: 'Draco',
          person: 'Tom Felton',
        ),
        Avatar(
          name: 'Luna',
          person: 'Evanna Lynch',
        ),
        Avatar(
          name: 'Snape',
          person: 'Alan Rickman',
        ),
      ],
    },
  ];

  // ================= IMAGE CACHE =================

  static final Map<String, String> imageCache = {};

  static List<Avatar> get allAvatars {
    final List<Avatar> result = [];

    for (final category in categories) {
      result.addAll(
        category['avatars'] as List<Avatar>,
      );
    }

    return result;
  }

  // ================= WIKIPEDIA IMAGE =================

  static Future<String?> getWikipediaImage(
      String person,
      ) async {
    if (imageCache.containsKey(person)) {
      return imageCache[person];
    }

    try {
      final encodedName =
      Uri.encodeComponent(person);

      final url = Uri.parse(
        'https://en.wikipedia.org/api/rest_v1/page/summary/$encodedName',
      );

      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'MoviesApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final imageUrl =
        data['thumbnail']?['source'] as String?;

        if (imageUrl != null) {
          imageCache[person] = imageUrl;
          return imageUrl;
        }
      }
    } catch (_) {}

    return null;
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

                                      color:
                                      isSelected
                                          ? ProfileColors
                                          .yellow
                                          : Colors
                                          .transparent,

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
                                      FutureBuilder<
                                          String?>(
                                        future:
                                        AvatarPicker
                                            .getWikipediaImage(
                                          avatar.person,
                                        ),

                                        builder: (
                                            context,
                                            snapshot,
                                            ) {
                                          if (snapshot
                                              .connectionState ==
                                              ConnectionState
                                                  .waiting) {
                                            return Container(
                                              color:
                                              ProfileColors
                                                  .cardColor,

                                              child:
                                              const Center(
                                                child:
                                                SizedBox(
                                                  width:
                                                  25,
                                                  height:
                                                  25,

                                                  child:
                                                  CircularProgressIndicator(
                                                    strokeWidth:
                                                    2.5,
                                                    color:
                                                    ProfileColors.yellow,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          if (!snapshot
                                              .hasData ||
                                              snapshot.data ==
                                                  null) {
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
                                          }

                                          return Image
                                              .network(
                                            snapshot
                                                .data!,

                                            width:
                                            100,
                                            height:
                                            100,

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