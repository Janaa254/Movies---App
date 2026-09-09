import 'package:flutter/material.dart';

class MovieScreenshots extends StatelessWidget {
  final List<String> screenshots;

  const MovieScreenshots({
    super.key,
    required this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: screenshots.map(
            (image) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            width: double.infinity,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Container(
                    color: const Color(0xff292929),
                    child: const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}