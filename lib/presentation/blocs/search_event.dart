part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchLocations extends SearchEvent {}

class SearchLocations extends SearchEvent {
  final String query;

  const SearchLocations(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends SearchEvent {
  final List<String> selectedCategories;

  const FilterByCategory(this.selectedCategories);

  @override
  List<Object> get props => [selectedCategories];
}