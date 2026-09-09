abstract class BrowseEvent {}

class LoadBrowseMovies extends BrowseEvent {}

class ChangeGenre extends BrowseEvent {
  final String genre;

  ChangeGenre(this.genre);
}

class LoadMoreBrowseMovies extends BrowseEvent {}