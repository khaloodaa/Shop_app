
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/state.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? searchModel;

  void search({required String? text}){

    emit(LoadingSearchState());

    DioHelper.postData(
        url: SEARCH_PRO,
        data: {
          'text':text,
        },
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data!);
      print(searchModel!.data!.data[0].name);
      emit(SuccessSearchState(searchModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
}