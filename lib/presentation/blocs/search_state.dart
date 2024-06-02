part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Location> locations;
  final List<Category> categories;
  final List<String> selectedCategories;

  const SearchLoaded(this.locations, this.categories, this.selectedCategories);

  @override
  List<Object> get props => [locations, categories, selectedCategories];

  factory SearchLoaded.fromJson(Map<String, dynamic> json) {
    var locations = (json['locations'] as List)
        .map((location) => Location.fromJson(location))
        .toList();
    var categories = (json['categories'] as List)
        .map((category) => Category.fromJson(category))
        .toList();
    var selectedCategories = (json['selectedCategories'] as List)
        .map((category) => category as String)
        .toList();

    return SearchLoaded(locations, categories, selectedCategories);
  }

  Map<String, dynamic> toJson() => {
        'locations': locations.map((location) => location.toJson()).toList(),
        'categories': categories.map((category) => category.toJson()).toList(),
        'selectedCategories': selectedCategories,
      };
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
