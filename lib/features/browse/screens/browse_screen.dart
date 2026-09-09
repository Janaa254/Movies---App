import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../movie_details/screens/movie_details_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../../profile/profile_screen.dart';

import '../bloc/browse_bloc.dart';
import '../bloc/browse_event.dart';
import '../bloc/browse_state.dart';
import '../widgets/browse_movie_card.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrowseBloc()
        ..add(
          LoadBrowseMovies(),
        ),
      child: const _BrowseView(),
    );
  }
}

class _BrowseView extends StatefulWidget {
  const _BrowseView();

  @override
  State<_BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<_BrowseView> {
  final ScrollController _scrollController = ScrollController();

  final List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'War',
    'Western',
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<BrowseBloc>().add(
        LoadMoreBrowseMovies(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            _buildGenres(),

            const SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, state) {
                  if (state is BrowseInitial ||
                      state is BrowseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }

                  if (state is BrowseError) {
                    return _buildError(
                      state.message,
                    );
                  }

                  if (state is BrowseSuccess) {
                    return _buildMoviesGrid(
                      state,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        4,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Browse',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // GENRES
  // ============================================================

  Widget _buildGenres() {
    return SizedBox(
      height: 42,
      child: BlocBuilder<BrowseBloc, BrowseState>(
        builder: (context, state) {
          String selectedGenre = 'Action';

          if (state is BrowseSuccess) {
            selectedGenre = state.selectedGenre;
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,

            separatorBuilder: (_, __) => const SizedBox(
              width: 6,
            ),

            itemBuilder: (context, index) {
              final genre = genres[index];

              final isSelected = genre == selectedGenre;

              return GestureDetector(
                onTap: () {
                  context.read<BrowseBloc>().add(
                    ChangeGenre(
                      genre,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.amber
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      9,
                    ),
                    border: Border.all(
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    genre,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.black
                          : Colors.amber,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // MOVIES GRID
  // ============================================================

  Widget _buildMoviesGrid(
      BrowseSuccess state,
      ) {
    if (state.movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,

      padding: const EdgeInsets.fromLTRB(
        14,
        5,
        14,
        20,
      ),

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.68,
      ),

      itemCount: state.movies.length +
          (state.isLoadingMore ? 2 : 0),

      itemBuilder: (context, index) {
        if (index >= state.movies.length) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }

        final movie = state.movies[index];

        return BrowseMovieCard(
          movie: movie,

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsScreen(
                  movieId: movie.id,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError(
      String message,
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 50,
            ),

            const SizedBox(
              height: 16,
            ),

            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                context.read<BrowseBloc>().add(
                  LoadBrowseMovies(),
                );
              },
              child: const Text(
                'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION METHODS
  // ============================================================

  void _openHome() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  void _openSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      ),
    );
  }

  void _openProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      // Browse screen = index 2
      currentIndex: 2,

      backgroundColor: const Color(
        0xFF1E1E1E,
      ),

      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white54,

      type: BottomNavigationBarType.fixed,

      selectedFontSize: 10,
      unselectedFontSize: 10,

      onTap: (index) {
        // HOME
        if (index == 0) {
          _openHome();
          return;
        }

        // SEARCH
        if (index == 1) {
          _openSearch();
          return;
        }

        // BROWSE
        if (index == 2) {
          return;
        }

        // PROFILE
        if (index == 3) {
          _openProfile();
          return;
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          activeIcon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Search',
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.movie_outlined,
          ),
          activeIcon: Icon(
            Icons.movie,
          ),
          label: 'Browse',
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          activeIcon: Icon(
            Icons.person,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}