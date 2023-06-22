part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeSuccess extends HomeState {
  HomeSuccess(AllPokemonModel allPokemonModel);
}
class HomeFailed extends HomeState {}
class HomeLoading extends HomeState {}
class HomeAddToFav extends HomeState{
  HomeAddToFav(List<Results> favorites);
}
