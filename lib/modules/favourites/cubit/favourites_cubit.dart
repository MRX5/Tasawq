import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favouritesModel.dart';
import 'package:shop_app/modules/favourites/cubit/favourites_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';

import '../../../shared/remote/end_points.dart';

class FavouritesCubit extends Cubit<FavouritesStates>{
  FavouritesCubit():super(FavouritesInitialState());

  static FavouritesCubit get(context)=>BlocProvider.of(context);
  
  FavouritesModel? favouritesModel;
  
  void getFavouritesProducts(){
    emit(GetFavouritesLoadingState());
    DioHelper.getData(url: favorites,token: token)
    .then((value){
      favouritesModel=FavouritesModel.fromJson(value.data);
      emit(GetFavouritesSuccessState());
    }).catchError((error){
      emit(GetFavouritesErrorState());
    });
  }
}