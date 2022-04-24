import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/home_model.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class GetHomeDataLoadingState extends HomeStates{}
class GetHomeDataSuccessState extends HomeStates{
}
class GetHomeDataErrorState extends HomeStates{
  final String error;
  GetHomeDataErrorState(this.error);

}

class GetCategoriesLoadingState extends HomeStates{}
class GetCategoriesSuccessState extends HomeStates{}
class GetCategoriesErrorState extends HomeStates{
  final String error;
  GetCategoriesErrorState(this.error);
}


class ChangeFavouritesState extends HomeStates{}
class ChangeFavouritesSuccessState extends HomeStates{
  final ChangeFavouritesModel favouritesModel;
  ChangeFavouritesSuccessState(this.favouritesModel);
}
class ChangeFavouritesErrorState extends HomeStates{
  final String error;
  ChangeFavouritesErrorState(this.error);
}
