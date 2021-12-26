
import 'package:shop_app/models/search_model.dart';

abstract class SearchStates{}

class InitialSearchState extends SearchStates{}

class LoadingSearchState extends SearchStates{}
class SuccessSearchState extends SearchStates{
  final SearchModel? searchModel;
  SuccessSearchState(this.searchModel);
}
class ErrorSearchState extends SearchStates{}