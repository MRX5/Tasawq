import 'package:shop_app/models/cart/cart_model.dart';

import '../../models/cart/change_cart_model.dart';
import '../../models/favourites/change_favourites_model.dart';
import '../../models/product_details_model.dart';

abstract class ShopLayoutStates{}

class ShopLayoutInitialState extends ShopLayoutStates{}
class ShopLayoutBottomNavChangeState extends ShopLayoutStates{}

// Get Home Data States
class GetHomeDataLoadingState extends ShopLayoutStates{}
class GetHomeDataSuccessState extends ShopLayoutStates{
}
class GetHomeDataErrorState extends ShopLayoutStates{
  final String error;
  GetHomeDataErrorState(this.error);

}

// Get Categories States
class GetCategoriesLoadingState extends ShopLayoutStates{}
class GetCategoriesSuccessState extends ShopLayoutStates{}
class GetCategoriesErrorState extends ShopLayoutStates{
  final String error;
  GetCategoriesErrorState(this.error);
}

// Change Favourites States
class ChangeFavouritesState extends ShopLayoutStates{}
class ChangeFavouritesSuccessState extends ShopLayoutStates{
  final ChangeFavouritesModel favouritesModel;
  ChangeFavouritesSuccessState(this.favouritesModel);
}
class ChangeFavouritesErrorState extends ShopLayoutStates{
  final String error;
  ChangeFavouritesErrorState(this.error);
}

// Get Favourites States
class GetFavouritesLoadingState extends ShopLayoutStates{}
class GetFavouritesSuccessState extends ShopLayoutStates{}
class GetFavouritesErrorState extends ShopLayoutStates{}

// Change Cart States
class ChangeCartState extends ShopLayoutStates{}
class ChangeCartSuccessState extends ShopLayoutStates{
  final ChangeCartModel favouritesModel;
  ChangeCartSuccessState(this.favouritesModel);
}
class ChangeCartErrorState extends ShopLayoutStates{
  final String error;
  ChangeCartErrorState(this.error);
}

// Get Cart States
class GetCartLoadingState extends ShopLayoutStates{}
class GetCartSuccessState extends ShopLayoutStates{
  final CartModel cartModel;
  GetCartSuccessState(this.cartModel);
}
class GetCartErrorState extends ShopLayoutStates{
  final String error;
  GetCartErrorState(this.error);
}

//Get Product Details
class GetProductLoadingState extends ShopLayoutStates{}
class GetProductSuccessStateState extends ShopLayoutStates{
  final ProductDetailsModel model;
  GetProductSuccessStateState(this.model);
}
class GetProductErrorState extends ShopLayoutStates{
  final String error;
  GetProductErrorState(this.error);
}


class IncreaseProductQuantityState extends ShopLayoutStates{}
class DecreaseProductQuantityState extends ShopLayoutStates{}
