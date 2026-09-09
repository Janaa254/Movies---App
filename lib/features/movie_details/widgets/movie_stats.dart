import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';

class MovieStats extends StatelessWidget {
  final MovieDetailsModel movie;

  const MovieStats({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.favorite,
            value: movie.likeCount?.toString() ?? '0',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _StatItem(
            icon: Icons.access_time,
            value: '${movie.runtime ?? 0}',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _StatItem(
            icon: Icons.star,
            value: '${movie.rating ?? 0}',
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xff292929),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xffffc107),
            size: 20,
          ),

          const SizedBox(width: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}