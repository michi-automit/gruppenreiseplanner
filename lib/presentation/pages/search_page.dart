import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import '../../data/repositories/location_repository.dart';
import '../blocs/search_bloc.dart';
import '../blocs/trip_bloc.dart';
import '../../utils/icon_helper.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suchen'),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            print("State: ${state.locations.toList().toString()}");
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      context.read<SearchBloc>().add(SearchLocations(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Suchen',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      final isSelected =
                          state.selectedCategories.contains(category.name);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(category.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            final selectedCategories =
                                List<String>.from(state.selectedCategories);
                            if (selected) {
                              selectedCategories.add(category.name);
                            } else {
                              selectedCategories.remove(category.name);
                            }
                            context
                                .read<SearchBloc>()
                                .add(FilterByCategory(selectedCategories));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.locations.length,
                    itemBuilder: (context, index) {
                      final location = state.locations[index];
                      print("Location: ${location.toJson()}");
                      return BlocBuilder<TripBloc, TripState>(
                        builder: (context, tripState) {
                          bool isAddedToTrip = tripState is TripLoaded &&
                              tripState.trip != null &&
                              tripState.trip!.locations.contains(location);
                          print("TripState on Search Page: $isAddedToTrip");
                          //print("Is added to trip: $isAddedToTrip");
                          return Dismissible(
                            key: Key(location.name),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color:
                                  (isAddedToTrip) ? Colors.red : Colors.green,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: (isAddedToTrip)
                                  ? Icon(Icons.remove, color: Colors.white)
                                  : Icon(Icons.add, color: Colors.white),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                if (!isAddedToTrip) {
                                  context.read<TripBloc>().add(
                                      AddLocationToTrip(location: location));
                                } else {
                                  context.read<TripBloc>().add(
                                      RemoveLocationFromTrip(
                                          location: location));
                                }
                              }
                              return false; // Return false to prevent the item from being dismissed
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/details',
                                    arguments: location);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(location.image),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.dstATop),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5.0, sigmaY: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  location.name,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 3.0,
                                                        color: Colors.black,
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (isAddedToTrip)
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                    child: Text(
                                                      'Trip',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Divider(
                                                color: Colors.white,
                                                thickness: 1),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        child: Row(
                                          children: location.categories
                                              .map((category) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(
                                                getIconData(category),
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Text(
                                          location.address,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No locations found'));
          }
        },
      ),
    );
  }
}
