import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';

import '../widgets/movie_details_content.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailsBloc()
        ..add(
          GetMovieDetails(movieId),
        ),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101010),
      body: SafeArea(
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            // Loading state
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffffc107),
                ),
              );
            }

            // Error state
            if (state is MovieDetailsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }

            // Success state
            if (state is MovieDetailsSuccess) {
              return MovieDetailsContent(
                movie: state.movie,
                suggestions: state.suggestions,
                isFavorite: state.isFavorite,

                onFavoriteTap: () {
                  context.read<MovieDetailsBloc>().add(
                    ToggleFavorite(
                      state.movie,
                    ),
                  );
                },

                // Open another movie details screen
                onMovieTap: (id) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(
                        movieId: id,
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}