import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:string_similarity/string_similarity.dart';
import '../../data/models/location_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/location_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final LocationRepository repository;
  List<Location> allLocations = [];
  List<String> selectedCategories = [];
  String searchQuery = '';

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<FetchLocations>(_onFetchLocations);
    on<SearchLocations>(_onSearchLocations);
    on<FilterByCategory>(_onFilterByCategory);
  }

  Future<void> _onFetchLocations(
      FetchLocations event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final locations = await repository.fetchLocations();
      final categories = await repository.fetchCategories();
      allLocations = locations;
      emit(SearchLoaded(locations, categories, selectedCategories));
    } catch (e) {
      print('Error fetching locations and categories: $e');
      emit(SearchError("Failed to fetch locations and categories"));
    }
  }

  void _onSearchLocations(SearchLocations event, Emitter<SearchState> emit) {
    searchQuery = event.query.toLowerCase();
    _applyFilters(emit);
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<SearchState> emit) {
    selectedCategories = event.selectedCategories;
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<SearchState> emit) {
    final filteredLocations = allLocations.where((location) {
      final locationName = location.name.toLowerCase();
      final matchesQuery =
          searchQuery.isEmpty || locationName.similarityTo(searchQuery) > 0.3;
      final matchesCategories = selectedCategories.isEmpty ||
          location.categories
              .any((category) => selectedCategories.contains(category));
      return matchesQuery && matchesCategories;
    }).toList();

    if (state is SearchLoaded) {
      final loadedState = state as SearchLoaded;
      emit(SearchLoaded(
          filteredLocations, loadedState.categories, selectedCategories));
    } else {
      emit(SearchLoaded(filteredLocations, [], selectedCategories));
    }
  }
}
