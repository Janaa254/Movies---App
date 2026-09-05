import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Avatar {
  final String name;
  final String person;

  const Avatar({
    required this.name,
    required this.person,
  });
}

class AvatarPicker extends StatefulWidget {
  final int selectedAvatar;
  final ValueChanged<int> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  static const Color background = Color(0xFF0B0B0F);
  static const Color purple = Color(0xFF8B5CF6);

  final Map<String, String> imageCache = {};

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Marvel',
      'avatars': const [
        Avatar(name: 'Iron Man', person: 'Robert Downey Jr.'),
        Avatar(name: 'Captain America', person: 'Chris Evans'),
        Avatar(name: 'Thor', person: 'Chris Hemsworth'),
        Avatar(name: 'Black Widow', person: 'Scarlett Johansson'),
        Avatar(name: 'Spider-Man', person: 'Tom Holland'),
        Avatar(name: 'Wanda', person: 'Elizabeth Olsen'),
      ],
    },
    {
      'title': 'Disney',
      'avatars': const [
        Avatar(name: 'Elsa', person: 'Elsa'),
        Avatar(name: 'Anna', person: 'Anna Frozen'),
        Avatar(name: 'Stitch', person: 'Stitch'),
        Avatar(name: 'Ariel', person: 'Ariel Little Mermaid'),
        Avatar(name: 'Rapunzel', person: 'Rapunzel Tangled'),
        Avatar(name: 'Moana', person: 'Moana'),
      ],
    },
    {
      'title': 'Money Heist',
      'avatars': const [
        Avatar(name: 'Tokyo', person: 'Úrsula Corberó'),
        Avatar(name: 'Professor', person: 'Álvaro Morte'),
        Avatar(name: 'Berlin', person: 'Pedro Alonso'),
        Avatar(name: 'Nairobi', person: 'Alba Flores'),
        Avatar(name: 'Denver', person: 'Jaime Lorente'),
        Avatar(name: 'Rio', person: 'Miguel Herrán'),
      ],
    },
    {
      'title': 'Lucifer',
      'avatars': const [
        Avatar(name: 'Lucifer', person: 'Tom Ellis'),
        Avatar(name: 'Chloe', person: 'Lauren German'),
        Avatar(name: 'Maze', person: 'Lesley-Ann Brandt'),
        Avatar(name: 'Amenadiel', person: 'D. B. Woodside'),
        Avatar(name: 'Ella', person: 'Aimee Garcia'),
        Avatar(name: 'Dan', person: 'Kevin Alejandro'),
      ],
    },
    {
      'title': 'Stranger Things',
      'avatars': const [
        Avatar(name: 'Eleven', person: 'Millie Bobby Brown'),
        Avatar(name: 'Mike', person: 'Finn Wolfhard'),
        Avatar(name: 'Dustin', person: 'Gaten Matarazzo'),
        Avatar(name: 'Lucas', person: 'Caleb McLaughlin'),
        Avatar(name: 'Steve', person: 'Joe Keery'),
        Avatar(name: 'Max', person: 'Sadie Sink'),
      ],
    },
    {
      'title': 'Twilight',
      'avatars': const [
        Avatar(name: 'Bella', person: 'Kristen Stewart'),
        Avatar(name: 'Edward', person: 'Robert Pattinson'),
        Avatar(name: 'Jacob', person: 'Taylor Lautner'),
        Avatar(name: 'Alice', person: 'Ashley Greene'),
        Avatar(name: 'Rosalie', person: 'Nikki Reed'),
        Avatar(name: 'Jasper', person: 'Jackson Rathbone'),
      ],
    },
    {
      'title': 'Wednesday',
      'avatars': const [
        Avatar(name: 'Wednesday', person: 'Jenna Ortega'),
        Avatar(name: 'Enid', person: 'Emma Myers'),
        Avatar(name: 'Bianca', person: 'Joy Sunday'),
        Avatar(name: 'Xavier', person: 'Percy Hynes White'),
        Avatar(name: 'Tyler', person: 'Hunter Doohan'),
        Avatar(name: 'Eugene', person: 'Moosa Mostafa'),
      ],
    },
    {
      'title': 'Harry Potter',
      'avatars': const [
        Avatar(name: 'Harry', person: 'Daniel Radcliffe'),
        Avatar(name: 'Hermione', person: 'Emma Watson'),
        Avatar(name: 'Ron', person: 'Rupert Grint'),
        Avatar(name: 'Draco', person: 'Tom Felton'),
        Avatar(name: 'Luna', person: 'Evanna Lynch'),
        Avatar(name: 'Snape', person: 'Alan Rickman'),
      ],
    },
    {
      'title': 'The Vampire Diaries',
      'avatars': const [
        Avatar(name: 'Elena', person: 'Nina Dobrev'),
        Avatar(name: 'Damon', person: 'Ian Somerhalder'),
        Avatar(name: 'Stefan', person: 'Paul Wesley'),
        Avatar(name: 'Caroline', person: 'Candice King'),
        Avatar(name: 'Bonnie', person: 'Kat Graham'),
        Avatar(name: 'Klaus', person: 'Joseph Morgan'),
      ],
    },
  ];

  Future<String?> getWikipediaImage(String person) async {
    if (imageCache.containsKey(person)) {
      return imageCache[person];
    }

    try {
      final encodedName = Uri.encodeComponent(person);

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
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 45,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Choose Your Avatar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Choose your favorite character',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              itemCount: categories.length,
              itemBuilder: (context, categoryIndex) {
                final category = categories[categoryIndex];

                final List<Avatar> avatars =
                category['avatars'] as List<Avatar>;

                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        category['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 105,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        itemCount: avatars.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 16),
                        itemBuilder: (
                            context,
                            avatarIndex,
                            ) {
                          final avatar =
                          avatars[avatarIndex];

                          final globalIndex =
                              categoryIndex * 6 +
                                  avatarIndex;

                          final isSelected =
                              widget.selectedAvatar ==
                                  globalIndex;

                          return GestureDetector(
                            onTap: () {
                              widget.onAvatarSelected(
                                globalIndex,
                              );

                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 68,
                              child: Column(
                                children: [
                                  Container(
                                    width: 68,
                                    height: 68,
                                    padding:
                                    const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? purple
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child:
                                      FutureBuilder<String?>(
                                        future:
                                        getWikipediaImage(
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
                                              const Color(
                                                0xFF202027,
                                              ),
                                              child:
                                              const Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                  CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: purple,
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
                                              const Color(
                                                0xFF202027,
                                              ),
                                              child:
                                              const Icon(
                                                Icons.person,
                                                color:
                                                Colors.white54,
                                                size: 30,
                                              ),
                                            );
                                          }

                                          return Image.network(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                                ) {
                                              return Container(
                                                color:
                                                const Color(
                                                  0xFF202027,
                                                ),
                                                child:
                                                const Icon(
                                                  Icons.person,
                                                  color: Colors
                                                      .white54,
                                                  size: 30,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  Text(
                                    avatar.name,
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? purple
                                          : Colors.white70,
                                      fontSize: 11,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),
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