import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeSuccessFavoritesState extends ShopStates{
  late final FavoritesModel model;
  ShopChangeSuccessFavoritesState(this.model);
}
class ShopChangeErrorFavoritesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}

class ShopLoadingFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingProfileState extends ShopStates{}
class ShopSuccessProfileState extends ShopStates{
  ShopLoginModel shopLoginModel;
  ShopSuccessProfileState(this.shopLoginModel);
}
class ShopErrorProfileState extends ShopStates{}

class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  ShopLoginModel? shopLoginModel;
  ShopSuccessUpdateUserDataState(this.shopLoginModel);
}
class ShopErrorUpdateUserDataState extends ShopStates{}




