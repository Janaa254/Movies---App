import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../browse/screens/browse_screen.dart';
import '../../movie_details/screens/movie_details_screen.dart';
import '../../../profile/profile_screen.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

import '../../../data/models/movie_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _searchController =
  TextEditingController();

  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  // ============================================================
  // SCROLL
  // ============================================================

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<SearchBloc>().add(
        LoadMoreSearchMovies(),
      );
    }
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _search() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    context.read<SearchBloc>().add(
      SearchMovies(
        query,
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF121212,
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            _buildSearchBar(),

            const SizedBox(
              height: 14,
            ),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return _buildInitial();
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return _buildError(
                      state.message,
                    );
                  }

                  if (state is SearchSuccess) {
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

      bottomNavigationBar:
      _buildBottomNavigationBar(),
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
        12,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Search',
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
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: TextField(
        controller: _searchController,

        textInputAction: TextInputAction.search,

        onSubmitted: (_) {
          _search();
        },

        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),

        decoration: InputDecoration(
          hintText: 'Search...',

          hintStyle: const TextStyle(
            color: Colors.white38,
            fontSize: 13,
          ),

          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white54,
            size: 20,
          ),

          suffixIcon: IconButton(
            onPressed: _search,
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.amber,
              size: 20,
            ),
          ),

          filled: true,

          fillColor: const Color(
            0xFF1E1E1E,
          ),

          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 12,
          ),

          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              12,
            ),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              12,
            ),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              12,
            ),
            borderSide:
            const BorderSide(
              color: Colors.amber,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INITIAL STATE
  // ============================================================

  Widget _buildInitial() {
    return const Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Colors.white24,
            size: 60,
          ),

          SizedBox(
            height: 12,
          ),

          Text(
            'Search for a movie',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOVIES GRID
  // ============================================================

  Widget _buildMoviesGrid(
      SearchSuccess state,
      ) {
    if (state.movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,

      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        20,
      ),

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
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

        final movie =
        state.movies[index];

        return _buildMovieCard(
          movie: movie,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    MovieDetailsScreen(
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
  // MOVIE CARD
  // ============================================================

  Widget _buildMovieCard({
    required MovieModel movie,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AspectRatio(
        aspectRatio: 0.68,

        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                  10,
                ),

                child: Image.network(
                  movie.mediumCoverImage ??
                      movie.largeCoverImage ??
                      '',

                  fit: BoxFit.cover,

                  errorBuilder:
                      (_, __, ___) {
                    return Container(
                      color: const Color(
                        0xFF242424,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          color:
                          Colors.white54,
                          size: 40,
                        ),
                      ),
                    );
                  },

                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress ==
                        null) {
                      return child;
                    }

                    return Container(
                      color: const Color(
                        0xFF242424,
                      ),
                      child: const Center(
                        child:
                        CircularProgressIndicator(
                          color:
                          Colors.amber,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ==================================================
            // RATING
            // ==================================================

            Positioned(
              top: 7,
              left: 7,

              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: const Color(
                    0xDD202020,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    7,
                  ),
                ),

                child: Row(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    Text(
                      movie.rating
                          ?.toStringAsFixed(
                        1,
                      ) ??
                          '0.0',

                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 3,
                    ),

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          mainAxisAlignment:
          MainAxisAlignment.center,

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
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              message,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: _search,
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
  // NAVIGATION
  // ============================================================

  void _openHome() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  void _openBrowse() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const BrowseScreen(),
      ),
    );
  }

  void _openProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const ProfileScreen(),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      // Search = index 1
      currentIndex: 1,

      backgroundColor:
      const Color(
        0xFF1E1E1E,
      ),

      selectedItemColor:
      Colors.amber,

      unselectedItemColor:
      Colors.white54,

      type:
      BottomNavigationBarType.fixed,

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
          return;
        }

        // BROWSE
        if (index == 2) {
          _openBrowse();
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
          activeIcon: Icon(
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