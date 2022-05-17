import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(BuildContext context)=>BlocProvider.of(context);


  SearchModel? searchModel;
  void searchFor({
  required String query
}){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH_END_POIINT,
        data: {
          'text':query
        }
    ).then((value){
       searchModel=SearchModel.fromJson(value.data);
      if(searchModel?.status! ==false){
        emit(SearchErrorState('${searchModel?.message}'));
      }else{
        emit(SearchSuccessState());
      }
    }).catchError((error){
      print(error);
      emit(SearchErrorState('Check internet connection'));
    });
  }
  
}