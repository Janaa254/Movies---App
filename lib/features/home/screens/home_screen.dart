import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie_model.dart';
import '../../movie_details/screens/movie_details_screen.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    context.read<HomeBloc>().add(LoadMovies());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<HomeBloc>().add(LoadMoreMovies());
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }

            if (state is HomeError) {
              return _buildError(state.message);
            }

            if (state is HomeSuccess) {
              return _buildHome(state);
            }

            return const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHome(HomeSuccess state) {
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

    return RefreshIndicator(
      color: Colors.amber,
      backgroundColor: const Color(0xFF1E1E1E),
      onRefresh: () async {
        context.read<HomeBloc>().add(LoadMovies());
      },
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 20,
        ),
        children: [
          _buildAvailableNow(state.movies),

          const SizedBox(height: 18),

          _buildSectionTitle(
            title: 'Action',
            onSeeMore: () {},
          ),

          const SizedBox(height: 10),

          _buildMoviesList(state.movies),

          if (state.isLoadingMore) ...[
            const SizedBox(height: 15),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
          ],

          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _buildAvailableNow(List<MovieModel> movies) {
    final mainMovie = movies.first;

    final leftMovie = movies.length > 1
        ? movies[1]
        : mainMovie;

    final rightMovie = movies.length > 2
        ? movies[2]
        : mainMovie;

    return SizedBox(
      height: 390,
      child: Stack(
        children: [

          Positioned.fill(
            child: Image.network(
              mainMovie.backgroundImage ??
                  mainMovie.largeCoverImage ??
                  mainMovie.mediumCoverImage ??
                  '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFF151515),
                );
              },
            ),
          ),


          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x55000000),
                    Color(0x99000000),
                    Color(0xFF121212),
                  ],
                  stops: [
                    0.0,
                    0.55,
                    1.0,
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/available_now.png',
                height: 42,
                fit: BoxFit.contain,
              ),
            ),
          ),


          Positioned(
            left: -28,
            top: 72,
            child: _buildSidePoster(
              leftMovie,
            ),
          ),


          Positioned(
            right: -28,
            top: 72,
            child: _buildSidePoster(
              rightMovie,
            ),
          ),


          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _openMovieDetails(mainMovie.id);
                },
                child: Container(
                  width: 170,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 18,
                        spreadRadius: 2,
                        offset: Offset(
                          0,
                          8,
                        ),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      mainMovie.largeCoverImage ??
                          mainMovie.mediumCoverImage ??
                          '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: const Color(0xFF202020),
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white54,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _openMovieDetails(mainMovie.id);
                },
                child: Image.asset(
                  'assets/images/watch_now.png',
                  height: 48,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSidePoster(MovieModel movie) {
    return Container(
      width: 85,
      height: 225,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          movie.mediumCoverImage ??
              movie.largeCoverImage ??
              '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: const Color(0xFF202020),
              child: const Icon(
                Icons.movie,
                color: Colors.white54,
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildSectionTitle({
    required String title,
    required VoidCallback onSeeMore,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          GestureDetector(
            onTap: onSeeMore,
            child: const Row(
              children: [
                Text(
                  'See More',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber,
                  size: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMoviesList(
      List<MovieModel> movies,
      ) {
    return SizedBox(
      height: 225,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification
          is ScrollUpdateNotification) {
            final metrics =
                notification.metrics;

            if (metrics.pixels >=
                metrics.maxScrollExtent - 100) {
              context
                  .read<HomeBloc>()
                  .add(LoadMoreMovies());
            }
          }

          return false;
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          separatorBuilder: (_, __) =>
          const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final movie = movies[index];

            return MovieCard(
              movie: movie,
              onTap: () {
                _openMovieDetails(movie.id);
              },
            );
          },
        ),
      ),
    );
  }


  void _openMovieDetails(int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(
          movieId: movieId,
        ),
      ),
    );
  }


  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 50,
            ),

            const SizedBox(height: 16),

            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context
                    .read<HomeBloc>()
                    .add(LoadMovies());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      unselectedFontSize: 10,
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
          label: 'Browse',
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}